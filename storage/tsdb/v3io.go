// Copyright 2017 The Prometheus Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Don't build this module when running tests
// +build !test

package tsdb

import (
	"context"
	"encoding/json"
	"github.com/alecthomas/units"
	"os"
	"reflect"
	"sync"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/common/model"
	"github.com/prometheus/prometheus/storage"
	"github.com/prometheus/tsdb"

	"github.com/go-kit/kit/log"
	"github.com/go-kit/kit/log/level"
	"github.com/pkg/errors"
	"github.com/v3io/v3io-tsdb/pkg/config"
	"github.com/v3io/v3io-tsdb/promtsdb"
)

// ErrNotReady is returned if the underlying storage is not ready yet.
var ErrNotReady = errors.New("TSDB not ready")

var openedLogger log.Logger

// ReadyStorage implements the Storage interface while allowing to set the actual
// storage at a later point in time.
type ReadyStorage struct {
	mtx             sync.RWMutex
	v3ioPromAdapter storage.Storage
	v3ioConfig      *config.V3ioConfig
	logger          log.Logger
	closed          bool
	error           error
}

// Set the storage.
func (s *ReadyStorage) Set(db *tsdb.DB, startTimeMargin int64) {
	s.mtx.Lock()
	defer s.mtx.Unlock()

	// save the logger that was passed to Open()
	s.logger = openedLogger

	// get the config path
	configPath := s.getConfigPath()
	s.logger.Log("msg", "Creating initial v3io adapter", "configPath", configPath)

	// create the initial v3io adapter
	adapter, v3ioConfig, err := s.createV3ioPromAdapater(configPath)
	if err != nil {
		s.error = errors.Wrap(err, "failed to create v3io prometheus adapter")
		return
	}
	s.v3ioPromAdapter = adapter
	s.v3ioConfig = v3ioConfig

	// watch configuration file for changes
	s.watchConfigForChanges(configPath)
	if err != nil {
		s.error = errors.Wrap(err, "failed to start config watch")
		return
	}

	s.error = nil
}

// Get the storage.
func (s *ReadyStorage) Get() *tsdb.DB {
	return nil
}

// StartTime implements the Storage interface.
func (s *ReadyStorage) StartTime() (int64, error) {
	return 0, ErrNotReady
}

func (s *ReadyStorage) Error() error {
	return s.error
}

func (s *ReadyStorage) Config() *config.V3ioConfig {
	return s.v3ioConfig
}

// Querier implements the Storage interface.
func (s *ReadyStorage) Querier(ctx context.Context, mint, maxt int64) (storage.Querier, error) {
	s.logger.Log("msg", "Querier requested", "mint", mint, "maxt", maxt)

	if s.error != nil {
		return nil, errors.Wrap(s.error, "cannot return a querier without an adapter")
	}

	if !reflect.ValueOf(s.v3ioPromAdapter).IsNil() {
		return s.v3ioPromAdapter.Querier(ctx, mint, maxt) //NEW
	}

	return nil, ErrNotReady
}

// Appender implements the Storage interface.
func (s *ReadyStorage) Appender() (storage.Appender, error) {
	s.logger.Log("msg", "Appended requested")

	if s.error != nil {
		return nil, errors.Wrap(s.error, "cannot return an appender without an adapter")
	}

	if !reflect.ValueOf(s.v3ioPromAdapter).IsNil() {
		return s.v3ioPromAdapter.Appender() //NEW
	}

	return nil, ErrNotReady
}

// Close implements the Storage interface.
func (s *ReadyStorage) Close() error {
	s.closed = true
	return nil
}

func (s *ReadyStorage) getConfigPath() string {

	// Initialize V3IO Adapter
	configPath := os.Getenv("V3IO_FILE_PATH")
	if configPath == "" {
		configPath = "/etc/v3io/v3io-tsdb.yaml"
	}

	return configPath
}

func (s *ReadyStorage) watchConfigForChanges(configPath string) error {
	s.logger.Log("msg", "Starting to watch configuration for changes", "configPath", configPath)

	// get initial file mtime
	lastConfigFileInfo, err := os.Stat(configPath)
	if err != nil {
		return err
	}

	// in the background, check for mtime changes and reload config
	go func() {

		for !s.closed {

			// wait a bit
			time.Sleep(3 * time.Second)

			// get current file mtime
			currentConfigFileInfo, err := os.Stat(configPath)
			if err != nil {
				level.Warn(s.logger).Log("msg", "Failed to get config file info", "err", err.Error())
				continue
			}

			// compare mtimes
			if lastConfigFileInfo.ModTime() != currentConfigFileInfo.ModTime() {
				lastConfigFileInfo = currentConfigFileInfo

				s.logger.Log("msg", "Config file modification detected, recreating adapter", "configPath", configPath)

				config.UpdateConfig(configPath)
				newV3ioPromAdapter, _, err := s.createV3ioPromAdapater(configPath)
				if err != nil {
					level.Warn(s.logger).Log("msg", "Failed to create new v3io adapter", "err", err.Error())
					continue
				}

				// swap old pointer with new (atomic)
				s.v3ioPromAdapter = newV3ioPromAdapter
			}
		}

		s.logger.Log("msg", "Stopping config file change watch")
	}()

	return nil
}

func (s *ReadyStorage) createV3ioPromAdapater(configPath string) (*promtsdb.V3ioPromAdapter, *config.V3ioConfig, error) {
	loadedConfig, err := config.GetOrLoadFromFile(configPath)
	if err != nil {
		return nil, nil, err
	}

	// if the disabled flag is set, don't create an adapter
	if loadedConfig.Disabled {
		s.logger.Log("msg", "Adapter is disabled, not creating")
		return nil, nil, nil
	}

	if jsonLoadedConfig, err := json.Marshal(&loadedConfig); err == nil {
		s.logger.Log("msg", "Creating v3io adapter", "config", string(jsonLoadedConfig))
	}

	adapter, err := promtsdb.NewV3ioProm(loadedConfig, nil, nil)
	if err != nil {
		return nil, nil, err
	}
	return adapter, loadedConfig, nil
}

// Adapter return an adapter as storage.Storage.
func Adapter(db *tsdb.DB, startTimeMargin int64) storage.Storage {
	return nil
}

// Options of the DB storage.
type Options struct {
	// The timestamp range of head blocks after which they get persisted.
	// It's the minimum duration of any persisted block.
	MinBlockDuration model.Duration

	// The maximum timestamp range of compacted blocks.
	MaxBlockDuration model.Duration

	// The maximum size of each WAL segment file.
	WALSegmentSize units.Base2Bytes

	// Duration for how long to retain data.
	RetentionDuration model.Duration

	// Maximum number of bytes to be retained.
	MaxBytes units.Base2Bytes

	// Disable creation and consideration of lockfile.
	NoLockfile bool

	// When true it disables the overlapping blocks check.
	// This in-turn enables vertical compaction and vertical query merge.
	AllowOverlappingBlocks bool
}

// Open returns a new storage backed by a TSDB database that is configured for Prometheus.
func Open(path string, l log.Logger, r prometheus.Registerer, opts *Options) (*tsdb.DB, error) {

	// save the logger
	openedLogger = l

	return nil, nil
}

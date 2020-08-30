module github.com/prometheus/prometheus

go 1.14

require (
	contrib.go.opencensus.io/exporter/ocagent v0.4.9 // indirect
	github.com/Azure/azure-sdk-for-go v23.2.0+incompatible
	github.com/Azure/go-autorest v11.2.8+incompatible
	github.com/StackExchange/wmi v0.0.0-20181212234831-e0a55b97c705 // indirect
	github.com/VividCortex/ewma v1.1.1 // indirect
	github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf
	github.com/aws/aws-sdk-go v0.0.0-20180507225419-00862f899353
	github.com/biogo/store v0.0.0-20160505134755-913427a1d5e8 // indirect
	github.com/cenk/backoff v2.1.1+incompatible // indirect
	github.com/certifi/gocertifi v0.0.0-20190105021004-abcd57078448 // indirect
	github.com/cespare/xxhash v1.1.0
	github.com/cockroachdb/apd v1.1.0 // indirect
	github.com/cockroachdb/cmux v0.0.0-20170110192607-30d10be49292
	github.com/cockroachdb/cockroach v0.0.0-20170608034007-84bc9597164f
	github.com/cockroachdb/cockroach-go v0.0.0-20181001143604-e0a95dfd547c // indirect
	github.com/codahale/hdrhistogram v0.0.0-20161010025455-3a0bb77429bd // indirect
	github.com/coreos/etcd v3.3.12+incompatible // indirect
	github.com/dgrijalva/jwt-go v3.2.0+incompatible // indirect
	github.com/dustin/go-humanize v1.0.0 // indirect
	github.com/elastic/gosigar v0.10.0 // indirect
	github.com/elazarl/go-bindata-assetfs v1.0.0 // indirect
	github.com/evanphx/json-patch v4.1.0+incompatible // indirect
	github.com/facebookgo/clock v0.0.0-20150410010913-600d898af40a // indirect
	github.com/getsentry/raven-go v0.2.0 // indirect
	github.com/go-ini/ini v1.42.0 // indirect
	github.com/go-kit/kit v0.8.0
	github.com/go-logfmt/logfmt v0.4.0
	github.com/go-ole/go-ole v1.2.4 // indirect
	github.com/go-sql-driver/mysql v1.4.1 // indirect
	github.com/gogo/protobuf v1.2.0
	github.com/golang/snappy v0.0.0-20180518054509-2e65f85255db
	github.com/google/gofuzz v0.0.0-20170612174753-24818f796faf // indirect
	github.com/google/pprof v0.0.0-20180605153948-8b03ce837f34
	github.com/googleapis/gnostic v0.2.0 // indirect
	github.com/gophercloud/gophercloud v0.0.0-20181206160319-9d88c34913a9
	github.com/gregjones/httpcache v0.0.0-20190212212710-3befbb6ad0cc // indirect
	github.com/grpc-ecosystem/grpc-gateway v1.6.3
	github.com/grpc-ecosystem/grpc-opentracing v0.0.0-20180507213350-8e809c8a8645 // indirect
	github.com/hashicorp/consul v0.0.0-20180615161029-bed22a81e9fd
	github.com/hashicorp/go-cleanhttp v0.5.1 // indirect
	github.com/hashicorp/go-rootcerts v1.0.0 // indirect
	github.com/hashicorp/golang-lru v0.5.1 // indirect
	github.com/hashicorp/serf v0.8.2 // indirect
	github.com/influxdata/influxdb v0.0.0-20170331210902-15e594fc09f1
	github.com/jackc/fake v0.0.0-20150926172116-812a484cc733 // indirect
	github.com/jackc/pgx v3.3.0+incompatible // indirect
	github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af // indirect
	github.com/json-iterator/go v0.0.0-20180612202835-f2b4162afba3
	github.com/knz/strtime v0.0.0-20181018220328-af2256ee352c // indirect
	github.com/kr/pretty v0.2.1 // indirect
	github.com/lib/pq v1.0.0 // indirect
	github.com/lightstep/lightstep-tracer-go v0.15.6 // indirect
	github.com/mattn/go-runewidth v0.0.4 // indirect
	github.com/miekg/dns v1.1.4
	github.com/mitchellh/go-testing-interface v1.0.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.0 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.1 // indirect
	github.com/montanaflynn/stats v0.5.0 // indirect
	github.com/mwitkow/go-conntrack v0.0.0-20161129095857-cc309e4a2223
	github.com/nuclio/logger v0.0.1
	github.com/oklog/oklog v0.0.0-20170918173356-f857583a70c3
	github.com/olekukonko/tablewriter v0.0.1 // indirect
	github.com/opentracing-contrib/go-stdlib v0.0.0-20170113013457-1de4cc2120e7
	github.com/opentracing/basictracer-go v1.0.0 // indirect
	github.com/opentracing/opentracing-go v1.0.1
	github.com/peterbourgon/diskv v2.0.1+incompatible // indirect
	github.com/peterbourgon/g2s v0.0.0-20170223122336-d4e7ad98afea // indirect
	github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5 // indirect
	github.com/pkg/errors v0.8.1
	github.com/prometheus/client_golang v0.9.3-0.20190127221311-3c4408c8b829
	github.com/prometheus/client_model v0.0.0-20190115171406-56726106282f
	github.com/prometheus/common v0.2.0
	github.com/prometheus/tsdb v0.6.1
	github.com/rlmcpherson/s3gof3r v0.5.0 // indirect
	github.com/rubyist/circuitbreaker v2.2.1+incompatible // indirect
	github.com/samuel/go-zookeeper v0.0.0-20161028232340-1d7be4effb13
	github.com/sasha-s/go-deadlock v0.2.0 // indirect
	github.com/satori/go.uuid v1.2.0 // indirect
	github.com/shopspring/decimal v0.0.0-20180709203117-cd690d0c9e24 // indirect
	github.com/shurcooL/httpfs v0.0.0-20171119174359-809beceb2371
	github.com/shurcooL/vfsgen v0.0.0-20180711163814-62bca832be04
	github.com/smartystreets/goconvey v0.0.0-20190306220146-200a235640ff // indirect
	github.com/stretchr/testify v1.4.0
	github.com/v3io/v3io-tsdb v0.10.12
	go.opencensus.io v0.19.2 // indirect
	golang.org/x/net v0.0.0-20190311183353-d8887717615a
	golang.org/x/oauth2 v0.0.0-20190226205417-e64efc72b421
	golang.org/x/time v0.0.0-20170424234030-8be79e1e0910
	golang.org/x/tools v0.0.0-20190312170243-e65039ee4138
	google.golang.org/api v0.2.0
	google.golang.org/genproto v0.0.0-20190307195333-5fe7a883aa19
	google.golang.org/grpc v1.20.0
	gopkg.in/alecthomas/kingpin.v2 v2.2.6
	gopkg.in/fsnotify/fsnotify.v1 v1.3.0
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/ini.v1 v1.42.0 // indirect
	gopkg.in/yaml.v2 v2.2.2
	k8s.io/api v0.0.0-20181213150558-05914d821849
	k8s.io/apimachinery v0.0.0-20181127025237-2b1284ed4c93
	k8s.io/client-go v0.0.0-20181121191925-a47917edff34
	k8s.io/klog v0.1.0
	k8s.io/kube-openapi v0.0.0-20190320154901-5e45bb682580 // indirect
	sigs.k8s.io/yaml v1.1.0 // indirect
)

replace k8s.io/klog => github.com/simonpasquier/klog-gokit v0.1.0

replace labix.org/v2/mgo => github.com/go-mgo/mgo v0.0.0-20180705113738-7446a0344b7872c067b3d6e1b7642571eafbae17

replace launchpad.net/gocheck => github.com/go-check/check v0.0.0-20180628173108-788fd78401277ebd861206a03c884797c6ec5541

replace github.com/v3io/frames => github.com/v3io/frames v0.7.36

replace github.com/v3io/v3io-tsdb => github.com/v3io/v3io-tsdb v0.10.12

replace google.golang.org/grpc => google.golang.org/grpc v1.19.1

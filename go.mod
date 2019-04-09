module github.com/prometheus/prometheus

go 1.12

require (
	github.com/Azure/azure-sdk-for-go v0.0.0-20161028183111-bd73d950fa44
	github.com/Azure/go-autorest v10.8.1+incompatible
	github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc // indirect
	github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf // indirect
	github.com/aws/aws-sdk-go v0.0.0-20180507225419-00862f899353
	github.com/beorn7/perks v0.0.0-20160229213445-3ac7bf7a47d1 // indirect
	github.com/cespare/xxhash v1.1.0
	github.com/cockroachdb/cmux v0.0.0-20170110192607-30d10be49292
	github.com/cockroachdb/cockroach v0.0.0-20170608034007-84bc9597164f
	github.com/dgrijalva/jwt-go v0.0.0-20161101193935-9ed569b5d1ac // indirect
	github.com/dgryski/go-bits v0.0.0-20160601073636-2ad8d707cc05 // indirect
	github.com/go-ini/ini v1.21.1 // indirect
	github.com/go-kit/kit v0.0.0-20170320090536-04dd4f741c6e
	github.com/go-logfmt/logfmt v0.3.0 // indirect
	github.com/go-stack/stack v1.5.4 // indirect
	github.com/gogo/protobuf v0.0.0-20171123125729-971cbfd2e72b
	github.com/golang/snappy v0.0.0-20160529050041-d9eb7a3d35ec
	github.com/google/btree v0.0.0-20180124185431-e89373fe6b4a // indirect
	github.com/google/gofuzz v1.0.0 // indirect
	github.com/google/pprof v0.0.0-20180605153948-8b03ce837f34
	github.com/googleapis/gnostic v0.0.0-20180520015035-48a0ecefe2e4 // indirect
	github.com/gophercloud/gophercloud v0.0.0-20170607034829-caf34a65f602
	github.com/gregjones/httpcache v0.0.0-20180305231024-9cad4c3443a7 // indirect
	github.com/grpc-ecosystem/grpc-gateway v0.0.0-20171126203511-e4b8a938efae
	github.com/hashicorp/consul v0.0.0-20180615161029-bed22a81e9fd
	github.com/hashicorp/go-cleanhttp v0.0.0-20160407174126-ad28ea4487f0 // indirect
	github.com/hashicorp/go-rootcerts v0.0.0-20160503143440-6bb64b370b90 // indirect
	github.com/hashicorp/golang-lru v0.0.0-20180201235237-0fb14efe8c47 // indirect
	github.com/hashicorp/serf v0.0.0-20161007004122-1d4fa605f6ff // indirect
	github.com/influxdata/influxdb v0.0.0-20170331210902-15e594fc09f1
	github.com/jmespath/go-jmespath v0.0.0-20160803190731-bd40a432e4c7 // indirect
	github.com/json-iterator/go v0.0.0-20180612202835-f2b4162afba3
	github.com/julienschmidt/httprouter v0.0.0-20150905172533-109e267447e9 // indirect
	github.com/kr/logfmt v0.0.0-20140226030751-b84e30acd515 // indirect
	github.com/matttproud/golang_protobuf_extensions v0.0.0-20150406173934-fc2b8d3a73c4 // indirect
	github.com/miekg/dns v1.0.4
	github.com/mitchellh/go-homedir v0.0.0-20180523094522-3864e76763d9 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v0.0.0-20180701023420-4b7aa43c6742 // indirect
	github.com/mwitkow/go-conntrack v0.0.0-20161129095857-cc309e4a2223
	github.com/oklog/oklog v0.0.0-20170918173356-f857583a70c3
	github.com/oklog/ulid v0.0.0-20170117200651-66bb6560562f // indirect
	github.com/opentracing-contrib/go-stdlib v0.0.0-20170113013457-1de4cc2120e7
	github.com/opentracing/opentracing-go v1.0.1
	github.com/peterbourgon/diskv v0.0.0-20180312054125-0646ccaebea1 // indirect
	github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5 // indirect
	github.com/pkg/errors v0.8.1
	github.com/prometheus/client_golang v0.0.0-20180607123607-faf4ec335fe0
	github.com/prometheus/client_model v0.0.0-20150212101744-fa8ad6fec335
	github.com/prometheus/common v0.0.0-20180518154759-7600349dcfe1
	github.com/prometheus/procfs v0.0.0-20160411190841-abf152e5f3e9 // indirect
	github.com/prometheus/tsdb v0.0.0-20180921053122-9c8ca47399a7
	github.com/samuel/go-zookeeper v0.0.0-20161028232340-1d7be4effb13
	github.com/sasha-s/go-deadlock v0.2.0 // indirect
	github.com/shurcooL/httpfs v0.0.0-20171119174359-809beceb2371
	github.com/shurcooL/vfsgen v0.0.0-20180711163814-62bca832be04
	github.com/stretchr/testify v1.3.0
	github.com/v3io/v3io-tsdb v0.9.0
	golang.org/x/crypto v0.0.0-20180621125126-a49355c7e3f8 // indirect
	golang.org/x/net v0.0.0-20181114220301-adae6a3d119a
	golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be
	golang.org/x/time v0.0.0-20170424234030-8be79e1e0910
	google.golang.org/api v0.0.0-20180506000402-20530fd5d65a
	google.golang.org/cloud v0.0.0-20160622021550-0a83eba2cadb // indirect
	google.golang.org/genproto v0.0.0-20181026194446-8b5d7a19e2d9
	google.golang.org/grpc v1.17.0
	gopkg.in/alecthomas/kingpin.v2 v2.2.5
	gopkg.in/fsnotify/fsnotify.v1 v1.3.0
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/yaml.v2 v2.2.2
	k8s.io/api v0.0.0-20180628040859-072894a440bd
	k8s.io/apimachinery v0.0.0-20180621070125-103fd098999d
	k8s.io/client-go v8.0.0+incompatible
	k8s.io/kube-openapi v0.0.0-20180629012420-d83b052f768a // indirect
)

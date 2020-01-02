GO ?= go
GOPATH=${shell $(GO) env GOPATH}

build: proto
	mkdir -p cmd/output/mac && cd cmd && go build -i -o output/mac/test && cd ..

proto:
	@protoc -I=./proto_file -I=${GOPATH}/src -I=${GOPATH}/src/github.com/gogo/protobuf/protobuf --gogoslick_out=\
	Mgoogle/protobuf/any.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/duration.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/struct.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/timestamp.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/wrappers.proto=github.com/gogo/protobuf/types:./internal/gofast_out/tutorial \
	test.proto \
	addressbook.proto

clean:
	rm -f internal/gofast_out/tutorial/*.pb.go cmd/output/mac/test

.PHONY: clean

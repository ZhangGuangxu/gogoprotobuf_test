GO ?= go
GOFMT ?= gofmt
GOPATH=${shell $(GO) env GOPATH}
VETPACKAGES ?= $(shell $(GO) list ./... | grep -v /vendor/ | grep -v /examples/ | grep -v /internal/gogoslick_out/)
GOFILES := $(shell find . -name "*.go" -type f -not -path "./vendor/*" -not -path "./internal/gogoslick_out")

build: proto
	mkdir -p cmd/output/mac && \
	cd cmd \
	&& go build -i -o output/mac/test && cd ..

linux: proto
	mkdir -p cmd/output/linux_amd64 && \
	cd cmd && \
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -i -pkgdir output/linux_amd64/pkg -o output/linux_amd64/test

proto:
	@protoc \
    --proto_path=./proto_file \
    --proto_path=/usr/local/protoc/include \
    --gogoslick_out=./internal/gogoslick_out/tutorial \
    test.proto
	@protoc \
	--proto_path=./proto_file \
	--proto_path=${GOPATH}/src \
	--proto_path=${GOPATH}/src/github.com/gogo/protobuf/protobuf \
	--gogoslick_out=\
	Mgoogle/protobuf/any.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/duration.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/struct.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/timestamp.proto=github.com/gogo/protobuf/types,\
	Mgoogle/protobuf/wrappers.proto=github.com/gogo/protobuf/types:./internal/gogoslick_out/tutorial \
	addressbook.proto

run: build
	./cmd/output/mac/test

errcheck:
	go get github.com/kisielk/errcheck
	errcheck ./cmd/...

fmt:
	$(GOFMT) -s -l -w $(GOFILES)

vet: proto
	$(GO) vet $(VETPACKAGES)

clean:
	rm -rf internal/gogoslick_out/tutorial/*.pb.go cmd/output

.PHONY: build linux proto run errcheck fmt vet clean

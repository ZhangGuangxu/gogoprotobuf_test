## on Mac

### install protoc compiler

- download [protoc](https://github.com/protocolbuffers/protobuf/releases)
- cp protoc directory(with bin and include) to /usr/local
- ln -s /usr/local/protoc/bin/protoc /usr/local/bin/protoc

### install gogoprotobuf

- specify gogoprotobuf v1.3.1

```shell script
GIT_TAG="v1.3.1"

go get -d -u github.com/gogo/protobuf/protoc-gen-gofast

go get -d -u github.com/gogo/protobuf/proto
go get -d -u github.com/gogo/protobuf/protoc-gen-gogofast
go get -d -u github.com/gogo/protobuf/protoc-gen-gogofaster
go get -d -u github.com/gogo/protobuf/protoc-gen-gogoslick
go get -d -u github.com/gogo/protobuf/gogoproto

git -C "$(go env GOPATH)"/src/github.com/gogo/protobuf checkout $GIT_TAG

go install github.com/gogo/protobuf/protoc-gen-gofast

go install github.com/gogo/protobuf/proto
go install github.com/gogo/protobuf/protoc-gen-gogofast
go install github.com/gogo/protobuf/protoc-gen-gogofaster
go install github.com/gogo/protobuf/protoc-gen-gogoslick
go install github.com/gogo/protobuf/gogoproto
```

### compile proto files

- To generate the code of test.proto

```shell script
mkdir -p ./internal/gogoslick_out/tutorial

protoc \
--proto_path=./proto_file \
--gogoslick_out=./internal/gogoslick_out/tutorial \
test.proto
```

- To use proto files (like addressbook.proto) from "google/protobuf" you need to add additional args to protoc

```shell script
mkdir -p ./internal/gogoslick_out/tutorial

protoc \
--proto_path=./proto_file \
--proto_path="$(go env GOPATH)"/src \
--proto_path="$(go env GOPATH)"/src/github.com/gogo/protobuf/protobuf \
--gogoslick_out=\
Mgoogle/protobuf/any.proto=github.com/gogo/protobuf/types,\
Mgoogle/protobuf/duration.proto=github.com/gogo/protobuf/types,\
Mgoogle/protobuf/struct.proto=github.com/gogo/protobuf/types,\
Mgoogle/protobuf/timestamp.proto=github.com/gogo/protobuf/types,\
Mgoogle/protobuf/wrappers.proto=github.com/gogo/protobuf/types:./internal/gogoslick_out/tutorial \
addressbook.proto
```

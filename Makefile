# Build the docs for the proto3 definition.

make_go:
	protoc \
	  --proto_path=adcom/proto \
	  --proto_path=common/proto \
	  --proto_path=. \
	  --go_out=generated \
	  --go_opt=paths=source_relative \
	  $(find adcom/proto -name "*.proto") \
	  $(find common/proto -name "*.proto") \
	  extensions/bidon.proto

check:
	prototool lint

clean:
	rm -fr generated/*

docs:
	docker run --rm \
		-v ${PWD}/doc:/out \
		-v ${PWD}/proto:/protos \
		pseudomuto/protoc-gen-doc --doc_opt=markdown,README.md --proto_path=/protos \
		common/proto/com/iabtechlab/openrtb/v3/request.proto \
		common/proto/com/iabtechlab/openrtb/v3/response.proto \
		common/proto/com/iabtechlab/openrtb/v3/openrtb.proto

watch:
	fswatch  -r ./ | xargs -n1 make make_go

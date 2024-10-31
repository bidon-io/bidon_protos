# Build the docs for the proto3 definition.

make_go:
	mkdir -p generated/go && \
	protoc \
	  --proto_path=adcom/proto \
	  --proto_path=common/proto \
	  --proto_path=. \
	  --go_out=generated/go \
	  --go_opt=paths=source_relative \
	  --go_opt=Mcom/iabtechlab/openrtb/v3/enums.proto=appodeal.com/galaxy/protos/openrtb \
	  --go_opt=Mcom/iabtechlab/openrtb/v3/request.proto=appodeal.com/galaxy/protos/openrtb \
	  --go_opt=Mcom/iabtechlab/openrtb/v3/response.proto=appodeal.com/galaxy/protos/openrtb \
	  --go_opt=Mcom/iabtechlab/openrtb/v3/openrtb.proto=appodeal.com/galaxy/protos/openrtb \
	  --go_opt=Mcom/iabtechlab/adcom/v1/enums/enums.proto=appodeal.com/galaxy/protos/adcom/enums \
	  --go_opt=Mcom/iabtechlab/adcom/v1/media/media.proto=appodeal.com/galaxy/protos/adcom/media \
	  --go_opt=Mcom/iabtechlab/adcom/v1/placement/placement.proto=appodeal.com/galaxy/protos/adcom/placement \
	  --go_opt=Mcom/iabtechlab/adcom/v1/context/context.proto=appodeal.com/galaxy/protos/adcom/context \
	  --go_opt=Mcom/iabtechlab/adcom/v1/adcom.proto=appodeal.com/galaxy/protos/adcom \
	  --go_opt=Mextensions/bidon.proto=appodeal.com/galaxy/protos/extensions \
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

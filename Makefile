
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

# Install buf as per https://docs.buf.build/installation
check:
	buf lint

clean:
	rm -fr generated/*

watch:
	fswatch  -r ./ | xargs -n1 make make_go

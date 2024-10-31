
generate:
	buf generate

# Install buf as per https://docs.buf.build/installation
check:
	buf lint

clean:
	rm -fr gen/*

watch:
	fswatch  -r ./ | xargs -n1 make make_go

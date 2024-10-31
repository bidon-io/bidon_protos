# bidon-protos

This repository contains protobuf files describing APIs of Bidon server.

Install buf as per https://docs.buf.build/installation. 

Init submodules:

```bash
git submodule update --init --recursive
```

To generate go code from proto files, run  

```bash
make generate
```

Check [buf.gen.yaml](buf.gen.yaml) for the configuration of the generation. 

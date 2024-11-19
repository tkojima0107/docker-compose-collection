# Docker container with AMD MLIR-AIE for Ryzen AI Processors

This repository provides a Dockerfile and docker-compose configuration to build and run a Docker container to use AMD MLIR-AIE toolchain for Ryzen AI Processors.

## Prerequisites
Need to install XDNA driver to your host machine. Please refer to the oficial installation guide: [link](https://github.com/Xilinx/mlir-aie/blob/main/docs/buildHostLin.md#install-the-xdna-driver)

## Prepare the Docker images
### Option 1: Build the Docker images on your own
Just run the following command to build the Docker image.
```
docker compose build
```

### Option 2: Pull the pre-built Docker images from Docker Hub
```
docker pull tkojima0107/ryzen-ai-mlir-aie:latest
docker tag tkojima0107/ryzen-ai-mlir-aie:latest ryzen-ai-mlir-aie:latest
```


## Docker container run and attach to it
```
docker compose up -d
docker attach aie_devel_container
```

### important environment variables when launching the container
- XILINX_PATH: path to the Xilinx installation directory on the host machine (default: /tools/Xilinx)
- LM_LICENSE_FILE: path to the Xilinx license file
Note: the Xilinx license file should be copied to the container manually unless license server is available.


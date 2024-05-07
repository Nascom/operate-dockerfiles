This repository is a collection of dockerfiles used at Nascom for deploying and building application infrastructure.

# Create multi-platform images.

## Setup

On Ubuntu : install the qemu-user-static package :

```
$ apt-get install qemu-user-static
```


In order to be able to create multi-platform images you will have to add a new builder :

```
$ docker buildx create --name builder --driver docker-container --bootstrap
```

Switch to the new builder :

```
$ docker buildx use builder
```

Check that the builder is ok and supports the correct build platforms :

```
$ docker buildx inspect
Name:          builder
Driver:        docker-container
Last Activity: 2023-01-30 12:20:54 +0000 UTC

Nodes:
Name:      builder0
Endpoint:  unix:///var/run/docker.sock
Status:    running
Buildkit:  v0.11.2
Platforms: linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6
```

## Actual multi-platform build

Change to the location of the Dockerfile and execute the following :

```
docker buildx build --platform linux/amd64,linux/arm64 -t <username>/<image>:<tag> --push .
```

This will build and push the images.

## References

- Blog : https://www.padok.fr/en/blog/docker-arm-architectures
- Docker docs : https://docs.docker.com/build/building/multi-platform/

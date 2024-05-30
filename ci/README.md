Docker image builder for Travis CI
===

This directory contains tools to build following Docker images used in Travis CI,

- `espnet/warpctc_builder:cuda101` for CUDA 10.1
- `espnet/warpctc_builder:cuda100` for CUDA 10.0
- `espnet/warpctc_builder:cuda92` for CUDA 9.2
- `espnet/warpctc_builder:cuda91` for CUDA 9.1
- `espnet/warpctc_builder:cuda90` for CUDA 9.0
- `espnet/warpctc_builder:cuda80` for CUDA 8.0
- `espnet/warpctc_builder:cpu` for no CUDA environment


## Building Docker images

Run `build.sh`.

```console
$ ./build.sh
```

## Uploading images to Dockerhub

Run `docker push`.

```console
$ docker push espnet/warpctc_builder:TAG
```

Note that your Dockerhub account have write access to [espnet/warpctc_builder](https://hub.docker.com/r/espnet/warpctc_builder) repository.

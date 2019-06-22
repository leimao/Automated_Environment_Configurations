# NVIDIA-Docker

## Introduction

This bash script automatically install the latest NVIDIA-docker and all of its dependencies.

## Installing Components

* NVIDIA driver (latest)
* NVIDIA CUDA (latest)
* Docker (latest)
* NVIDIA-Docker (latest)

## Usage

```bash
$ chmod +x nvidia_docker.sh
$ sudo ./nvidia_docker.sh
```

## Notes

We might not be using the CUDA installed on the native system because it is always the latest. Instead, we use NVIDIA-Docker to run any container which has the CUDA with the version specified installed.
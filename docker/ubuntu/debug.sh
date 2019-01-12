#!/usr/bin/env bash
docker run --rm -it  --network host --security-opt seccomp:unconfined --device=/dev/kfd --device=/dev/dri -w /bfg/ -v /opt/amdgpu-pro:/opt/amdgpu-pro -v /etc/OpenCL:/etc/OpenCL eqb-bfg-amd:latest bash

#!/usr/bin/env bash
docker run -it --network host --device=/dev/kfd --device=/dev/dri -v /opt/amdgpu-pro:/opt/amdgpu-pro -v /etc/OpenCL:/etc/OpenCL -w /bfg/ eqb-bfg-amd:latest sh -c "./bfg"

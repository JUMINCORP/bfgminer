#!/usr/bin/env bash
docker run -it --network host --device=/dev/dri -v /opt/amdgpu-pro:/opt/amdgpu-pro -v /etc/OpenCL:/etc/OpenCL -w /bfg/ darvs/eqb-bfg-amd:v01.00 sh -c "./bfg"

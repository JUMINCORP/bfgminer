#!/usr/bin/env bash
docker run -d --rm --name eqb-bfg-amd \
	--network host \
	--device=/dev/dri \
	-v /opt/amdgpu-pro:/opt/amdgpu-pro \
	-v /etc/OpenCL:/etc/OpenCL \
	-v /etc/localtime:/etc/localtime \
	-v /etc/timezone:/etc/timezone \
	darvs/eqb-bfg-amd:v01.01

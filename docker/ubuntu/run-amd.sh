#!/usr/bin/env bash
if [ ! -z $(docker ps -q --filter name=eqb-bfg-amd) ]; then
	docker stop eqb-bfg-amd
fi

if [ ! -z $(docker ps -a -q --filter name=eqb-bfg-amd) ]; then
	docker rm eqb-bfg-amd
fi

docker run -d --name eqb-bfg-amd \
	--network host \
	--device=/dev/dri \
	-v /opt/amdgpu-pro:/opt/amdgpu-pro \
	-v /etc/OpenCL:/etc/OpenCL \
	-v /etc/localtime:/etc/localtime \
	-v /etc/timezone:/etc/timezone \
	darvs/eqb-bfg-amd:v01.01

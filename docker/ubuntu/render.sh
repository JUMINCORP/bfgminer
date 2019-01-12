#!/usr/bin/env bash
docker run -it --rm -u $(id -u):$(id -g) -w /render/ -v "${PWD}"/render/render.py:/render/render.py -v "$2":/render/config.yaml -v "${PWD}/$1":/render/template.j2 j2 python3 render.py

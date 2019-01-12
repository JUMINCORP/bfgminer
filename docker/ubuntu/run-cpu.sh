#!/usr/bin/env bash

docker run --rm -it --network host --env EQB_ADDRESS="tq1qhc6eardg9ae8q8k86988hg9vl9c6e3lukwm7qm" --env NODE_ADDRESS="http://localhost:18331" -w /bfg/ darvs/eqb-bfg-cpu:v01.00 sh -c "./bfg"


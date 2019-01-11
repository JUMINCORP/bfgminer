#/usr/bin/env bash
NAME=build-bfgminer
USER=$(id -u)
GROUP=$(id -g)

cd $(dirname "$0")

echo Building docker image...
docker build -t eqb-bfg-amd . || exit 1

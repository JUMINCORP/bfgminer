#/usr/bin/env bash
NAME=build-bfgminer
USER=$(id -u)
GROUP=$(id -g)

PWD=$(cd $(dirname "$0") && pwd)

echo Building docker image...
docker build -t bfg-builder . || exit 1

#CONTAINERS=$(docker ps -a -f name=${NAME} -q)
#[ -z ${CONTAINERS} ] || docker rm ${CONTAINERS}

#docker run --name ${NAME} -a stdin -a stdout -a stderr -u ${USER}:${GROUP} -v ${PWD}/../../:/bfg: -w /bfg/ bfg-builder:latest /bin/bash -c "find . && echo building && ./autogen.sh && sh reconfigure-combo.sh && make V=0"

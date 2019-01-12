#/usr/bin/env bash

while [ $# -gt 0 ]
do
	TARGET="$1"

	cd $(dirname "$0")

	echo Building docker image...

	CONF=$(mktemp)
	echo "target: ${TARGET}" > ${CONF}

	./render.sh Dockerfile ${CONF} | docker build -t eqb-bfg-${TARGET}:v01.00 -f - . || exit 1

	#rm -i ${CONF}

	shift

done

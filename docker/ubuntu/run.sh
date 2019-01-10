#!/usr/bin/env bash
docker run -t -a stdout --network host --device=/dev/kfd --device=/dev/dri -w /bfg/ bfg-builder:latest sh -c "/bfg/bfgminer -u equibit -p equibit --generate-to tq1qhc6eardg9ae8q8k86988hg9vl9c6e3lukwm7qm --coinbase-sig \"This is a testnet Equibit block\"  -D -o http://localhost:18331 --no-default-config -S auto"

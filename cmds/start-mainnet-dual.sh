#!/bin/bash
set -e
gcr-node start -p mainnet -a dual -t target/mainnet-dual  -c test/mainnet_preset.yml $1 $2 $3

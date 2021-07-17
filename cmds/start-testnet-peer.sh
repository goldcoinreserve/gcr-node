#!/bin/bash
set -e
gcr-node start -p testnet -a peer -t target/testnet-peer $1 $2 $3

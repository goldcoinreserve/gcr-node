#!/bin/bash
set -e
gcr-node start -p testnet -a api -t target/testnet-api $1 $2 $3

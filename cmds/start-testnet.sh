#!/bin/bash
set -e
gcr-node start -p testnet -a dual -t target/testnet $1

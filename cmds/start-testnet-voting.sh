#!/bin/bash
set -e
gcr-node start -p testnet -a dual -t target/testnet -c test/voting_preset.yml  $1

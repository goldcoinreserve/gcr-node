#!/bin/bash
set -e

gcr-node start --reset --preset bootstrap --customPreset ./test/freenodes_preset.yml --user current -t target/bootstrap-freenodes

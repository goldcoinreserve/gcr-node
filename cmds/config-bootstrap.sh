#!/bin/bash
set -e

gcr-node config -p bootstrap --report -t target/bootstrap $1

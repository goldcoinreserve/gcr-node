#!/bin/bash
set -e

gcr-node start -p bootstrap -a light -r  -t target/light $1

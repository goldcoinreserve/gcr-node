#!/bin/bash
set -e

# docker rm -f $(docker ps -aq)
gcr-node start -p bootstrap -r  -t target/bootstrap -a alpha --password 1234 $1

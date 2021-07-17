#!/bin/bash
set -e

# docker rm -f $(docker ps -aq)
gcr-node stop -t target/bootstrap

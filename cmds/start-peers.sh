#!/bin/bash
sudo ./cmds/clean-all.sh
gcr-node config
gcr-node compose -u current
docker-compose -f target/docker/docker-compose.yml up --build peer-node-0 peer-node-1

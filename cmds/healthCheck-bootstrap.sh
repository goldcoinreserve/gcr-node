#!/bin/bash
set -e

gcr-node healthCheck -t target/bootstrap $1

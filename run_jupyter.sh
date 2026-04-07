#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="ghcr.io/younginfolife/biohackathonbits2026:latest"

docker run --rm -it \
  -p 8888:8888 \
  -v "${SCRIPT_DIR}:/sharedFolder" \
  "${IMAGE_NAME}"

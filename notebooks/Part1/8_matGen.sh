#!/usr/bin/env bash

set -euo pipefail

echo "=== Running gene counting with Rsubread ==="

/opt/R/4.5.1/bin/Rscript /notebooks/Part1/8_matGen.R

echo ""
echo "=== Output files ==="
ls -lh /sharedFolder/counts

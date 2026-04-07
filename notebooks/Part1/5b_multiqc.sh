#!/usr/bin/env bash

set -euo pipefail

FASTQDIR=/sharedFolder/fastq
QC_DIR=/sharedFolder/fastqc_raw
OUTDIR=/sharedFolder/multiqc_raw

mkdir -p "${OUTDIR}"

echo "=== Running MultiQC ==="

multiqc "${QC_DIR}" -o "${OUTDIR}"

echo ""
echo "=== MultiQC report ==="
ls -lh "${OUTDIR}"
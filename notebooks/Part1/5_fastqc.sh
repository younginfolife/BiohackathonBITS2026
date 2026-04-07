#!/usr/bin/env bash

set -euo pipefail

FASTQDIR=/sharedFolder/fastq
OUTDIR=/sharedFolder/fastqc_raw
THREADS=4

mkdir -p "${OUTDIR}"

echo "=== Running FastQC ==="

for fq in "${FASTQDIR}"/*.fastq.gz; do
    echo "→ $(basename "$fq")"
    fastqc \
        -t "${THREADS}" \
        -o "${OUTDIR}" \
        "$fq"
done

echo ""
echo "=== FastQC completed ==="
ls -lh "${OUTDIR}"
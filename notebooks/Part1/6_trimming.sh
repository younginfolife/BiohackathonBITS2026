#!/usr/bin/env bash

set -euo pipefail

FASTQDIR=/sharedFolder/fastq
OUTDIR=/sharedFolder/fastq_trimmed
THREADS=4

mkdir -p "${OUTDIR}"

echo "=== Trimming reads with Trim Galore ==="

for fq1 in "${FASTQDIR}"/*_1.fastq.gz; do
    fq2="${fq1/_1.fastq.gz/_2.fastq.gz}"

    base=$(basename "${fq1}" _1.fastq.gz)

    echo "→ ${base}"

    trim_galore \
        --paired \
        --cores "${THREADS}" \
        --quality 20 \
        --length 20 \
        --fastqc \
        --output_dir "${OUTDIR}" \
        "${fq1}" "${fq2}"

done

echo ""
echo "=== Trimming completed ==="
ls -lh "${OUTDIR}"
#!/usr/bin/env bash

set -euo pipefail

TRIMMED_DIR=/sharedFolder/fastq_trimmed
INDEX_DIR=/sharedFolder/star_index
OUTDIR=/sharedFolder/alignments
THREADS=4

mkdir -p "${OUTDIR}"

echo "=== Running STAR alignment ==="

for fq1 in "${TRIMMED_DIR}"/*_1_val_1.fq.gz; do
    fq2="${fq1/_1_val_1.fq.gz/_2_val_2.fq.gz}"

    base=$(basename "${fq1}" _1_val_1.fq.gz)

    echo "→ ${base}"
    echo "   R1: $(basename "$fq1")"
    echo "   R2: $(basename "$fq2")"

    STAR \
        --runThreadN "${THREADS}" \
        --genomeDir "${INDEX_DIR}" \
        --readFilesIn "${fq1}" "${fq2}" \
        --readFilesCommand zcat \
        --outFileNamePrefix "${OUTDIR}/${base}." \
        --outSAMtype BAM SortedByCoordinate \
        --outSAMunmapped Within \
        --outSAMattributes NH HI AS nM
done

echo ""
echo "=== Alignment completed ==="
ls -lh "${OUTDIR}"
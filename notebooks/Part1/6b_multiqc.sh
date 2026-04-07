#!/usr/bin/env bash

set -euo pipefail

TRIMMED_DIR=/sharedFolder/fastq_trimmed
OUTDIR=/sharedFolder/multiqc_trimmed

mkdir -p "${OUTDIR}"

echo "=== Running MultiQC on trimmed data ==="

multiqc "${TRIMMED_DIR}" -o "${OUTDIR}"

echo ""
echo "=== MultiQC (trimmed) report ==="
ls -lh "${OUTDIR}"
echo ""
echo "Open:"
echo "${OUTDIR}/multiqc_report.html"
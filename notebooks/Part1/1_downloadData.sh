#!/usr/bin/env bash

SRA_IDS=(SRR031714 SRR031716 SRR031724 SRR031726 SRR031708 SRR031718 SRR031728)

FASTQDIR=/sharedFolder/fastq
mkdir -p "$FASTQDIR"

echo "=== Downloading FASTQ files ==="
for acc in "${SRA_IDS[@]}"; do
    echo "→ $acc"

    fasterq-dump "$acc" \
        --outdir "$FASTQDIR" \
        --split-files \
        --threads 4 \
        --progress

    for f in "${FASTQDIR}/${acc}"*.fastq; do
        [ -e "$f" ] || continue
        gzip -f "$f"
        echo "   ✓ $(basename "$f").gz"
    done
done

echo "Done!"
ls -lh "$FASTQDIR"

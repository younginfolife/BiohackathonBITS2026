#!/usr/bin/env bash

set -euo pipefail

REFDIR=/sharedFolder/reference
ENSEMBL_RELEASE=110
SPECIES=drosophila_melanogaster
ASSEMBLY=BDGP6.46

mkdir -p "${REFDIR}"

SPECIES_CAP="${SPECIES^}"

GENOME_FILE="${SPECIES_CAP}.${ASSEMBLY}.dna.toplevel.fa.gz"
GTF_FILE="${SPECIES_CAP}.${ASSEMBLY}.${ENSEMBL_RELEASE}.gtf.gz"

GENOME_URL="https://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/fasta/${SPECIES}/dna/${GENOME_FILE}"
GTF_URL="https://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/gtf/${SPECIES}/${GTF_FILE}"

echo "=== Downloading genome FASTA ==="
wget -c "${GENOME_URL}" -O "${REFDIR}/genome.fa.gz"
echo "Decompressing..."
gunzip -f "${REFDIR}/genome.fa.gz"

echo ""
echo "=== Downloading GTF annotation ==="
wget -c "${GTF_URL}" -O "${REFDIR}/annotation.gtf.gz"
echo "Decompressing..."
gunzip -f "${REFDIR}/annotation.gtf.gz"

echo ""
echo "=== Reference files ==="
ls -lh "${REFDIR}"
#!/usr/bin/env bash

set -euo pipefail

REFDIR=/sharedFolder/reference
INDEXDIR=/sharedFolder/star_index
THREADS=4
READ_LENGTH=37  #SUPER IMPORTANT!!!! it might be 101, 76... or 37 like this old school
SJDB_OVERHANG=$((READ_LENGTH - 1))
GENOME_SA_INDEX_NBASES=12

GENOME_FASTA="${REFDIR}/genome.fa"
ANNOTATION_GTF="${REFDIR}/annotation.gtf"

mkdir -p "${INDEXDIR}"

echo "=== Generating STAR genome index ==="
echo "Genome FASTA: ${GENOME_FASTA}"
echo "Annotation GTF: ${ANNOTATION_GTF}"
echo "STAR index dir: ${INDEXDIR}"
echo "sjdbOverhang: ${SJDB_OVERHANG}"
echo "genomeSAindexNbases: ${GENOME_SA_INDEX_NBASES}"

STAR \
  --runThreadN "${THREADS}" \
  --runMode genomeGenerate \
  --genomeDir "${INDEXDIR}" \
  --genomeFastaFiles "${GENOME_FASTA}" \
  --sjdbGTFfile "${ANNOTATION_GTF}" \
  --sjdbOverhang "${SJDB_OVERHANG}" \
  --genomeSAindexNbases "${GENOME_SA_INDEX_NBASES}"

echo ""
echo "=== STAR index created successfully ==="
ls -lh "${INDEXDIR}"
#!/bin/bash
set -euo pipefail

# Align paired-end RNA-seq reads to the GRCh38 reference genome using STAR.

FASTQ_DIR="/mnt/disk1/bulk_rnaseq/fastq"
STAR_INDEX="/mnt/disk1/bulk_rnaseq/star_index"
ALIGNED_DIR="/mnt/disk1/bulk_rnaseq/aligned"

mkdir -p "$ALIGNED_DIR"

SAMPLES=(
    F1 F2 F3
    K1 K2 K3
    L1 L2 L4
)

for SAMPLE in "${SAMPLES[@]}"
do
    echo "Aligning ${SAMPLE}..."

    SAMPLE_DIR="$ALIGNED_DIR/$SAMPLE"
    mkdir -p "$SAMPLE_DIR"

    STAR \
        --runThreadN 8 \
        --genomeDir "$STAR_INDEX" \
        --readFilesIn \
            "$FASTQ_DIR/${SAMPLE}_R1.fastq.gz" \
            "$FASTQ_DIR/${SAMPLE}_R2.fastq.gz" \
        --readFilesCommand zcat \
        --outSAMtype BAM SortedByCoordinate \
        --outFileNamePrefix "$SAMPLE_DIR/${SAMPLE}_"

    echo "${SAMPLE} alignment complete."
done

echo "All STAR alignments complete."

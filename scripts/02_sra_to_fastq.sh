#!/bin/bash
set -euo pipefail

# Convert SRA runs to paired-end FASTQ files and compress them

SRA_DIR="/mnt/disk1/bulk_rnaseq/sra"
FASTQ_DIR="/mnt/disk1/bulk_rnaseq/fastq"

mkdir -p "$FASTQ_DIR"

ACCESSIONS=(
    SRR13523878
    SRR13523879
    SRR13523880
    SRR13523884
    SRR13523885
    SRR13523886
    SRR13523889
    SRR13523890
    SRR13523891
)

for SRR in "${ACCESSIONS[@]}"
do
    echo "Converting $SRR to FASTQ..."

    fasterq-dump \
        "$SRA_DIR/$SRR" \
        --split-files \
        --threads 8 \
        --outdir "$FASTQ_DIR"
done

echo "Compressing FASTQ files..."

gzip "$FASTQ_DIR"/*.fastq

echo "FASTQ conversion complete."

#!/bin/bash
set -euo pipefail

# Download the GENCODE GRCh38 reference genome and annotation
# and build a STAR genome index for 150-bp paired-end reads.

REFERENCE_DIR="/mnt/disk1/bulk_rnaseq/reference"
STAR_INDEX="/mnt/disk1/bulk_rnaseq/star_index"

mkdir -p "$REFERENCE_DIR"
mkdir -p "$STAR_INDEX"

cd "$REFERENCE_DIR"

# Download GENCODE human release 50 reference files
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_50/GRCh38.primary_assembly.genome.fa.gz

wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_50/gencode.v50.primary_assembly.annotation.gtf.gz

# Decompress reference files
gunzip GRCh38.primary_assembly.genome.fa.gz
gunzip gencode.v50.primary_assembly.annotation.gtf.gz

# Build STAR genome index
STAR \
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir "$STAR_INDEX" \
    --genomeFastaFiles "$REFERENCE_DIR/GRCh38.primary_assembly.genome.fa" \
    --sjdbGTFfile "$REFERENCE_DIR/gencode.v50.primary_assembly.annotation.gtf" \
    --sjdbOverhang 149

echo "Reference preparation and STAR index generation complete."

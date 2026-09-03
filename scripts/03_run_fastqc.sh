#!/bin/bash
set -euo pipefail

FASTQ_DIR="/mnt/disk1/bulk_rnaseq/fastq"
FASTQC_DIR="/mnt/disk1/bulk_rnaseq/fastqc"

mkdir -p "$FASTQC_DIR"

fastqc \
    "$FASTQ_DIR"/*.fastq.gz \
    --outdir "$FASTQC_DIR" \
    --threads 8

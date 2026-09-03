#!/bin/bash
set -euo pipefail

FASTQC_DIR="/mnt/disk1/bulk_rnaseq/fastqc"
RESULTS_DIR="/mnt/disk1/bulk_rnaseq/results"

mkdir -p "$RESULTS_DIR"

multiqc \
    "$FASTQC_DIR" \
    --outdir "$RESULTS_DIR"

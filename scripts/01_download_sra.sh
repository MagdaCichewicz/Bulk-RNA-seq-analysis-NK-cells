#!/bin/bash

# Download SRA files for selected samples
# Dataset: GSE165498 / SRP303210

SRA_DIR="/mnt/disk1/bulk_rnaseq/sra"

mkdir -p "$SRA_DIR"
cd "$SRA_DIR"

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
    echo "Downloading $SRR"
    prefetch "$SRR"
done

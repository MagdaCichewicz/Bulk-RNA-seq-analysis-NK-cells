#!/bin/bash
set -euo pipefail

ALIGNED_DIR="/mnt/disk1/bulk_rnaseq/aligned"

SAMPLES=(
    F1 F2 F3
    K1 K2 K3
    L1 L2 L4
)

for SAMPLE in "${SAMPLES[@]}"
do

    BAM="$ALIGNED_DIR/$SAMPLE/${SAMPLE}_Aligned.sortedByCoord.out.bam"

    echo "Processing $SAMPLE"

    # Create BAM index
    samtools index "$BAM"

    # Basic alignment statistics
    samtools flagstat "$BAM" \
        > "$ALIGNED_DIR/$SAMPLE/${SAMPLE}_flagstat.txt"

done

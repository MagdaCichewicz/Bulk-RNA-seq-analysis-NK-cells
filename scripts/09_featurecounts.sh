#!/bin/bash
set -euo pipefail

PROJECT="/mnt/disk1/bulk_rnaseq"

featureCounts \
    -T 8 \
    -p \
    --countReadPairs \
    -s 0 \
    -t exon \
    -g gene_id \
    -a "$PROJECT/reference/gencode.v50.primary_assembly.annotation.gtf" \
    -o "$PROJECT/counts/gene_counts.txt" \
    "$PROJECT"/aligned/*/*_Aligned.sortedByCoord.out.bam

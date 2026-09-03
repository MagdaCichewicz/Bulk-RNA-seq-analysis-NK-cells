#!/bin/bash
set -euo pipefail

# Assess RNA-seq library strandedness using RSeQC infer_experiment.py.
# A BED12 annotation file is generated from the GENCODE GTF and used
# together with one representative aligned BAM file.

REFERENCE_DIR="/mnt/disk1/bulk_rnaseq/reference"
ALIGNED_DIR="/mnt/disk1/bulk_rnaseq/aligned"
SCRIPTS_DIR="/mnt/disk1/bulk_rnaseq/scripts"

GTF="$REFERENCE_DIR/gencode.v50.primary_assembly.annotation.gtf"
BED="$REFERENCE_DIR/gencode.v50.bed"
BAM="$ALIGNED_DIR/F1/F1_Aligned.sortedByCoord.out.bam"

# Convert GTF annotation to BED12 format
python "$SCRIPTS_DIR/gtf_to_bed12.py" \
    "$GTF" \
    "$BED"

# Infer library strandedness
infer_experiment.py \
    -r "$BED" \
    -i "$BAM"

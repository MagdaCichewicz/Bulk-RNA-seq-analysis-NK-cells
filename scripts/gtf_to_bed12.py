#!/usr/bin/env python3

"""
Convert a GTF annotation file to BED12 format.

Usage:
    python gtf_to_bed12.py input.gtf output.bed

The script groups exon features by transcript_id and writes one BED12
record per transcript. The resulting BED file can be used with tools
such as RSeQC infer_experiment.py.
"""

import sys
from collections import defaultdict


def parse_attributes(attribute_string):
    """
    Parse the attributes column of a GTF file into a dictionary.
    """
    attributes = {}

    for field in attribute_string.strip().split(";"):
        field = field.strip()

        if not field:
            continue

        parts = field.split(" ", 1)

        if len(parts) == 2:
            key, value = parts
            attributes[key] = value.strip().strip('"')

    return attributes


def main():
    if len(sys.argv) != 3:
        print("Usage: python gtf_to_bed12.py input.gtf output.bed")
        sys.exit(1)

    input_gtf = sys.argv[1]
    output_bed = sys.argv[2]

    transcripts = defaultdict(list)
    transcript_info = {}

    with open(input_gtf, "r") as gtf:

        for line in gtf:

            # Skip comments
            if line.startswith("#"):
                continue

            fields = line.rstrip("\n").split("\t")

            if len(fields) < 9:
                continue

            chrom = fields[0]
            feature = fields[2]
            start = int(fields[3])
            end = int(fields[4])
            strand = fields[6]
            attributes = parse_attributes(fields[8])

            # BED12 requires exon structure
            if feature != "exon":
                continue

            transcript_id = attributes.get("transcript_id")

            if transcript_id is None:
                continue

            # Convert GTF 1-based start to BED 0-based start
            exon_start = start - 1
            exon_end = end

            transcripts[transcript_id].append(
                (exon_start, exon_end)
            )

            transcript_info[transcript_id] = (
                chrom,
                strand
            )

    with open(output_bed, "w") as bed:

        for transcript_id, exons in transcripts.items():

            chrom, strand = transcript_info[transcript_id]

            # Sort exons by genomic position
            exons.sort()

            transcript_start = min(start for start, end in exons)
            transcript_end = max(end for start, end in exons)

            block_count = len(exons)

            block_sizes = [
                end - start
                for start, end in exons
            ]

            block_starts = [
                start - transcript_start
                for start, end in exons
            ]

            bed_fields = [
                chrom,
                str(transcript_start),
                str(transcript_end),
                transcript_id,
                "0",
                strand,
                str(transcript_start),
                str(transcript_end),
                "0",
                str(block_count),
                ",".join(map(str, block_sizes)) + ",",
                ",".join(map(str, block_starts)) + ","
            ]

            bed.write("\t".join(bed_fields) + "\n")


if __name__ == "__main__":
    main()

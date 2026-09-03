Scripts are numbered according to the order in which they were used in the
bulk RNA-seq workflow.

| Script | Purpose |
|---|---|
| `01_download_sra.sh` | Download sequencing runs from SRA |
| `02_sra_to_fastq.sh` | Convert SRA files to paired-end FASTQ |
| `03_run_fastqc.sh` | Perform raw-read quality control |
| `04_run_multiqc.sh` | Aggregate FastQC reports |
| `05_prepare_reference.sh` | Prepare GRCh38 reference and STAR genome index |
| `06_star_alignment.sh` | Align paired-end reads to GRCh38 |
| `07_process_bam.sh` | Index and inspect BAM files using samtools |
| `08_featurecounts.sh` | Generate gene-level raw counts |
| `NKcells_differential_expression_analysis.Rmd` | Perform downstream analysis in R/DESeq2 |

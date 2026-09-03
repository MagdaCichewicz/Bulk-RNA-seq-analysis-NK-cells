Scripts are numbered according to the order in which they were used in the
bulk RNA-seq workflow.

scripts/
- 01_download_sra.sh
- 02_sra_to_fastq.sh
- 03_run_fastqc.sh
- 04_run_multiqc.sh
- 05_prepare_reference.sh
- 06_star_alignment.sh
- 07_process_bam.sh
- 08_check_strandedness.sh (RSeQC infer_experiment.py on a representative aligned BAM file)
-   - gtf_to_bed12.py 
- 09_featurecounts.sh 
- NKcells_differential_expression_analysis.Rmd

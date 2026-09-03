# Bulk-RNA-seq-workflow

Description

This repository contains a demonstration of a basic bulk RNA-seq pipeline using publicly available RNA-seq data from human natural killer (NK) cells, based on "RNA-Seq Analysis Reveals CCR5 as a Key Target for CRISPR Gene Editing to Regulate In Vivo NK Cell Trafficking", by ER Levy et al., 2021, PMID: 33669611. 
The main aim of this analysis was to compare the transcriptome of ex vivo expanded NK cell populations to resting NK cells. 

Overall, both K562- and LCL-expanded NK cells showed substantial transcriptional differences relative to Fresh NK cells, whereas the two expanded conditions were considerably more similar to each other. Expansion was associated with increased expression of cell-cycle/proliferation-related genes and reduced expression of several Fresh-associated genes.


Dataset: GSE165498 / SRP303210

The analysis compares three NK-cell conditions:

- Fresh NK cells
- LCL-expanded NK cells
- K562-expanded NK cells
  

Three biological samples were analyzed per condition.

<img width="570" height="354" alt="image" src="https://github.com/user-attachments/assets/c5934f36-e9d5-476d-a195-0e76f318989b" />

Workflow

<img width="224" height="319" alt="image" src="https://github.com/user-attachments/assets/17af5936-8256-4cc3-9be6-149a0f6432ba" />

<img width="213" height="318" alt="image" src="https://github.com/user-attachments/assets/9c721556-b293-4ef5-89a5-f7947a66f3d7" />




Analysis workflow

The bulk RNA-seq workflow consisted of the following steps:

1. **Raw data acquisition**
   - Downloaded paired-end RNA-seq data from SRA/GEO.

2. **Raw read quality control**
   - Assessed FASTQ quality using **FastQC**.
   - Aggregated QC reports using **MultiQC**.
  
3. **Reference preparation and read alignment**
   - Downloaded the **GENCODE GRCh38 primary assembly** and corresponding **GENCODE release 50 gene annotation**.
   - Generated a **STAR genome index** using the GRCh38 reference genome and GTF annotation.

4. **Read alignment**
   - Aligned reads to the human **GRCh38 reference genome** using **STAR**.
   - Processed and inspected BAM files using **samtools**.
  
5. **Library strandedness assessment**
   - Assessed library orientation using **RSeQC `infer_experiment.py`**.
   - The results supported treating the RNA-seq libraries as **unstranded** for gene-level quantification.

6. **Gene-level quantification**
   - Assigned aligned paired-end fragments to annotated genes using
     **featureCounts (Subread)** and the GENCODE GRCh38 annotation.

7. **Differential expression analysis in R**
   - Imported raw gene counts into **DESeq2**.
   - Filtered low-count genes and normalized sequencing-depth differences.
   - Compared Fresh, K562-expanded, and LCL-expanded NK cells.

8. **Exploratory transcriptomic analysis**
   - Variance-stabilizing transformation (VST)
   - Principal component analysis (PCA)
   - Sample-to-sample distance analysis

9. **Differential expression visualization**
   - DEG summaries
   - MA plots and log2 fold-change shrinkage
   - Volcano plots
   - Heatmap of top differentially expressed genes

10. **Functional interpretation**
   - Ensembl-to-gene-symbol annotation
   - Gene Ontology (GO) enrichment analysis
   - Comparison of enriched biological processes between expansion conditions
   - Visualization of normalized expression for representative genes


Tools

<img width="450" height="250" alt="image" src="https://github.com/user-attachments/assets/31745859-9c22-429e-951e-a2bb329a5f62" />


Uploaded documents: 

[https://magdacichewicz.github.io/Bulk-RNA-seq-workflow/reports/bulk_RNA-seq_multiqc_report.html]

Raw FASTQ files were assessed using FastQC and results were aggregated using MultiQC. Across the nine samples, sequencing depth ranged from approximately 23.5 to 32.5 million paired-end reads per sample. Reads were 150 bp in length and showed consistently high per-base sequence quality with low adapter contamination. All nine samples were retained for downstream analysis.

https://magdacichewicz.github.io/Bulk-RNA-seq-workflow/reports/NKcells_differential_expression_analysis.html

R Markdown summarizing read quantification, DESeq2-based differential expression, and exploratory data analysis.

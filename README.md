# Bulk-RNA-seq-workflow

DESCRIPTION

This repository presents an independent reanalysis of publicly available bulk RNA-seq data from human natural killer (NK) cells generated in the study “RNA-Seq Analysis Reveals CCR5 as a Key Target for CRISPR Gene Editing to Regulate In Vivo NK Cell Trafficking” (Levy et al., 2021; PMID: 33669611). The objective was to characterize the transcriptional changes associated with ex vivo NK-cell expansion and to compare the molecular profiles of K562- and LCL-expanded NK cells with those of freshly isolated NK cells.

Both K562- and LCL-expanded NK cells exhibited pronounced transcriptional differences relative to Fresh NK cells, while the two expanded populations were substantially more similar to one another. Ex vivo expansion was associated with increased expression of genes involved in cell-cycle progression and proliferation, together with reduced expression of genes characteristic of the Fresh NK-cell state.

Dataset: GSE165498 / SRP303210

The analysis compares three NK-cell conditions:

- Fresh NK cells
- LCL-expanded NK cells
- K562-expanded NK cells
  

Three biological samples were analyzed per condition.

| Sample | SRR | Condition |
|--------|-----|-----------|
| F1 | SRR13523878 | Fresh NK |
| F2 | SRR13523879 | Fresh NK |
| F3 | SRR13523880 | Fresh NK |
| L1 | SRR13523884 | LCL-expanded NK |
| L2 | SRR13523885 | LCL-expanded NK |
| L4 | SRR13523886 | LCL-expanded NK |
| K1 | SRR13523889 | K562-expanded NK |
| K2 | SRR13523890 | K562-expanded NK |
| K3 | SRR13523891 | K562-expanded NK |


WORKFLOW

### Bulk RNA-seq Workflow - Ubuntu Linux

`FASTQ` → **FastQC** → **MultiQC** → **STAR** → `BAM` → **featureCounts** → `counts.csv`

### Differential Expression Analysis in R

`counts.csv` → **DESeq2** → **PCA** → **Differential Expression Analysis** → **Heatmap / Volcano Plot** → **Pathway Analysis**


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


TOOLS

| Software                | Version |
| ----------------------- | ------- |
| SRA Toolkit             | 3.4.1   |
| FastQC                  | 0.12.1  |
| STAR                    | 2.7.10b |
| samtools                | 1.24    |
| Subread / featureCounts | 2.1.1   |
| R                       | 4.6.1   |
| DESeq2                  | 1.52.0  |
| ggplot2                 | 4.0.3   |
| pheatmap                | 1.0.13  |

NOTE: Full list of used packages is included in sessionInfo(), reports/NKcells_differential_expression_analysis.html.

## Reports

### Quality control

[View the interactive MultiQC report](https://magdacichewicz.github.io/Bulk-RNA-seq-workflow/reports/bulk_RNA-seq_multiqc_report.html)

Raw FASTQ files were assessed using FastQC and results were aggregated using MultiQC. Across the nine samples, sequencing depth ranged from approximately 23.5 to 32.5 million paired-end reads per sample. Reads were 150 bp in length and showed consistently high per-base sequence quality with low adapter contamination. All nine samples were retained for downstream analysis.

### Differential expression analysis

[View the complete DESeq2 analysis report](https://magdacichewicz.github.io/Bulk-RNA-seq-workflow/reports/NKcells_differential_expression_analysis.html)

R Markdown report summarizing read quantification, DESeq2-based differential expression, exploratory transcriptomic analysis, differential expression visualization, and functional enrichment.

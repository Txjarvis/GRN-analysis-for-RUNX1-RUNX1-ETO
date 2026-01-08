# RNA-seq processing and quantification scripts

This directory contains scripts used for RNA-seq preprocessing, alignment, and gene-level quantification prior to downstream analysis.

The scripts are using SLURM and rmd format and form the RNA-seq input to the GRN analysis.

---

## ORDER OF RUN

### `starsetup.sh`
Prepares the STAR genome index and reference files required for
RNA-seq alignment.

### `FastQC.sh`
Runs FastQC on raw FASTQ files to assess sequencing quality
before trimming.

### `Trimmomatic.sh`
Performs adapter removal and quality trimming on raw FASTQ files
using Trimmomatic.

### `reFASTQC.sh`
Runs FastQC on trimmed FASTQ files to confirm that
adapter contamination and low-quality bases have been removed.

### `featurecount.sh`
Quantifies gene-level expression from aligned BAM files using
featureCounts.

### 'DEG.rmd'
The differentially expressed genes are analysised and turned into a csv file.



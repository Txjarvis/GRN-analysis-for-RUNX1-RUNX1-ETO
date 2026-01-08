# ATAC-seq processing and differential accessibility analysis

This directory contains scripts used to process ATAC-seq data, performing differential accessibility analysis 

The resulting differentially accessible peaks (DAPs) are used for motif analysis and gene regulatory network (GRN) construction.

---

## Scripts overview

### `align.sh`
Aligns ATAC-seq reads to the human reference genome.

### `dedup.sh`
Removes duplicate reads from aligned ATAC-seq BAM files.

### `peakcall.sh`
Calls ATAC-seq peaks from deduplicated BAM files.

### `peakcount.sh`
Counts reads overlapping ATAC-seq peaks across samples to generate a peak-by-sample count matrix.

### `Diff_peaks.Rmd`
Performs differential accessibility analysis of ATAC-seq peaks using limma/voom



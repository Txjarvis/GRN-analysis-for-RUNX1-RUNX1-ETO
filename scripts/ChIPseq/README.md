# ChIP-seq processing and peak calling

This directory contains scripts used to process ChIP-seq data including alignment, filtering and peak calling.

---

## Scripts overview

### `alignment.sh`
Aligns ChIP-seq reads to the human reference genome using a short-read aligner (e.g. BWA).

### `deadup.sh`
Removes duplicate reads from aligned BAM files

### `Allfiltering.sh`
Applies post-alignment filtering steps, including:
- Removal of low-quality reads
- Removal of reads mapping to ENCODE blacklist regions

### `macs2.sh`
Calls ChIP-seq peaks using MACS2.
Separate peak sets are generated for each condition and factor

## ENCODE blacklist

ENCODE blacklist regions were obtained from:

ENCODE Project Consortium  
File: ENCFF356LFX  
Genome: hg38  
https://www.encodeproject.org/files/ENCFF356LFX/

Amemiya HM, Kundaje A, Boyle AP.  
*The ENCODE Blacklist: Identification of Problematic Regions of the Genome.*  
Scientific Reports. 2019;9:935.  
doi: 10.1038/s41598-018-30959-z



# GRN-analysis-for-RUNX1-RUNX1-ETO
MSc thesis: integrative RNA-seq, ATAC-seq, ChIP-seq and GRN analysis of RUNX1–ETO

'Investigating RUNX1-ETO–Driven Rewiring of Gene Regulatory Networks in Early Myeloid Cells'

This repository contains the analysis pipeline and supporting scripts used to construct and analyse the 0dox and gene regulatory networks (GRNs) for RUNX1 and RUNX1–RUNX1-ETO in an AML t(8;21) model under 0Dox and 5Dox conditions.

## Running order

1. **RNA-seq preprocessing and expression quantification**  
   RNA-seq data were processed and quantified to generate gene-level
   expression matrices.  
   (`scripts/RNAseq/`)

2. **ATAC-seq processing and differential accessibility analysis**  
   ATAC-seq data were processed to identify open chromatin regions and
   differentially accessible peaks (DAPs) between conditions.  
   (`scripts/ATACseq/`)

3. **ChIP-seq processing and peak calling**  
   ChIP-seq data for RUNX1 and RUNX1–ETO were processed to generate
   high-confidence peak sets, with ENCODE blacklist regions removed.  
   (`scripts/ChIPseq/`)

4. **Motif scanning and annotation**  
   Transcription factor binding motifs were identified within ATAC-seq
   and ChIP-seq peak regions using motif scanning approaches.  
   (`scripts/Motifs/`)

5. **De novo motif enrichment**  
   De novo motif enrichment for ATAC-seq  
   (`scripts/Denovo/`)

6. **Gene regulatory network construction**  
   Condition-specific GRNs were constructed by integrating ATAC-seq
   peaks, motif information, RNA-seq expression data, and TF annotations.  
   (`scripts/GRN/`)

7. **Network analysis and visualisation**
8.  GRNs were analysed to assess network topology and regulatory differences between conditions.  
   Constructed GRNs were analysed to assess network topology and
   regulatory differences between conditions.

   (`Analysis/`)

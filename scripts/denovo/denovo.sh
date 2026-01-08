#!/bin/bash
#SBATCH --job-name=ATAC_denovo
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --output=logs/atac_denovo_%j.out
#SBATCH --error=logs/atac_denovo_%j.err

set -euo pipefail

module purge
module load bear-apps/2020a/live
module load HOMER/4.11-foss-2020a
module load BEDTools/2.29.2-GCC-9.3.0

BASE=/rds/projects/c/cazierj-msc-bioinf-dl/txj215/Project
ATAC_DIR=${BASE}/Peaks/ATAC
PREP=${BASE}/Motifs/preparsed_genomes

PEAKS_0=${ATAC_DIR}/DAPs_annotated_for_GRN_0Dox_clean.bed
PEAKS_5=${ATAC_DIR}/DAPs_annotated_for_GRN_5Dox_clean.bed
BG=${ATAC_DIR}/background_peaks.bed

OUT0=${BASE}/Motifs/Denovo_Motif_results_0Dox
OUT5=${BASE}/Motifs/Denovo_Motif_results_5Dox

mkdir -p ${BASE}/logs
mkdir -p ${PREP}
mkdir -p ${OUT0}
mkdir -p ${OUT5}

bedtools sort -i ${PEAKS_0} > /tmp/peaks0.sorted.bed
bedtools sort -i ${PEAKS_5} > /tmp/peaks5.sorted.bed
bedtools sort -i ${BG} > /tmp/bg.sorted.bed

findMotifsGenome.pl /tmp/peaks0.sorted.bed hg38 ${OUT0} \
  -bg /tmp/bg.sorted.bed -size given -len 8,10,12 -p 8 -preparsedDir ${PREP}

findMotifsGenome.pl /tmp/peaks5.sorted.bed hg38 ${OUT5} \
  -bg /tmp/bg.sorted.bed -size given -len 8,10,12 -p 8 -preparsedDir ${PREP}

#!/bin/bash
#SBATCH --job-name=chip_union
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=06:00:00
#SBATCH --output=logs/chip_union_%j.out
#SBATCH --error=logs/chip_union_%j.err

set -euo pipefail

module purge
module load bear-apps/2020a/live
module load HOMER/4.11-foss-2020a
module load BEDTools/2.29.2-GCC-9.3.0

BASE=/rds/projects/c/cazierj-msc-bioinf-dl/txj215/Project
CHIP_DIR=${BASE}/Peaks/ChIP/ATAC_filtered_noBL
OUT_CHIP=${BASE}/Peaks/ChIP/union_by_condition
MOTIF_BASE=${BASE}/Motifs/ChIP_union_denovo
PREP=${BASE}/Motifs/preparsed_genomes

mkdir -p ${BASE}/logs
mkdir -p ${OUT_CHIP}
mkdir -p ${MOTIF_BASE}
mkdir -p ${PREP}

cat ${CHIP_DIR}/ChIPseq_RUNX1_0Dox_inATAC_noBL.narrowPeak \
    ${CHIP_DIR}/ChIPseq_RUNX1-ETO_0Dox_inATAC_noBL.narrowPeak \
| cut -f1-3 | bedtools sort -i - | bedtools merge -i - \
> ${OUT_CHIP}/ChIP_union_0Dox.bed

cat ${CHIP_DIR}/ChIPseq_RUNX1_5Dox_inATAC_noBL.narrowPeak \
    ${CHIP_DIR}/ChIPseq_RUNX1-ETO_5Dox_inATAC_noBL.narrowPeak \
| cut -f1-3 | bedtools sort -i - | bedtools merge -i - \
> ${OUT_CHIP}/ChIP_union_5Dox.bed

annotatePeaks.pl ${OUT_CHIP}/ChIP_union_0Dox.bed hg38 > ${OUT_CHIP}/ChIP_union_0Dox.annot.txt
annotatePeaks.pl ${OUT_CHIP}/ChIP_union_5Dox.bed hg38 > ${OUT_CHIP}/ChIP_union_5Dox.annot.txt

findMotifsGenome.pl ${OUT_CHIP}/ChIP_union_0Dox.bed hg38 ${MOTIF_BASE}/0Dox \
  -size given -len 8,10,12 -mask -noknown -preparsedDir ${PREP}

findMotifsGenome.pl ${OUT_CHIP}/ChIP_union_5Dox.bed hg38 ${MOTIF_BASE}/5Dox \
  -size given -len 8,10,12 -mask -noknown -preparsedDir ${PREP}

HITS0=${BASE}/Motifs/ChIP_union_motif_hits_0Dox.mbed
OUT0=${BASE}/Motifs/ChIP_union_Motif_results_0Dox
mkdir -p ${OUT0}

annotatePeaks.pl ${OUT_CHIP}/ChIP_union_0Dox.bed hg38 \
  -m ${MOTIF_BASE}/0Dox/homerMotifs.all.motifs \
  -mbed > ${HITS0}

awk -v outdir="${OUT0}" 'BEGIN{OFS="\t"}
  $4 !~ /^description=/{
    fn=$4; gsub(/[^A-Za-z0-9._-]/,"_",fn);
    print $1,$2,$3,$4,$5,$6 >> (outdir "/" fn ".bed")
  }' ${HITS0}

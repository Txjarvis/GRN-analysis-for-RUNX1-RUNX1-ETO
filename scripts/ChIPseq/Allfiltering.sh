###############
#ATAC filter
###############

#!/bin/bash
#SBATCH --job-name=ChIP_filter_ATAC
#SBATCH --output=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_filter_ATAC_%j.out
#SBATCH --error=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_filter_ATAC_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=4G

set -euo pipefail

module purge
module load bear-apps/2024a/live
module load BEDTools/2.31.1-GCC-13.3.0

ROOT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
CHIP=${ROOT}/peaks/ChIP/raw_macs2
ATAC=${ROOT}/peaks
OUT=${ROOT}/peaks/ChIP/ATAC_filtered

mkdir -p "$OUT"

bedtools intersect -u -a ${CHIP}/ChIPseq_RUNX1_0Dox_peaks_filt10.narrowPeak -b ${ATAC}/0Dox_peaks_filt10.narrowPeak > ${OUT}/ChIPseq_RUNX1_0Dox_inATAC.narrowPeak
bedtools intersect -u -a ${CHIP}/ChIPseq_RUNX1_5Dox_peaks_filt10.narrowPeak -b ${ATAC}/5Dox_peaks_filt10.narrowPeak > ${OUT}/ChIPseq_RUNX1_5Dox_inATAC.narrowPeak
bedtools intersect -u -a ${CHIP}/ChIPseq_RUNX1-ETO_0Dox_peaks_filt10.narrowPeak -b ${ATAC}/0Dox_peaks_filt10.narrowPeak > ${OUT}/ChIPseq_RUNX1-ETO_0Dox_inATAC.narrowPeak
bedtools intersect -u -a ${CHIP}/ChIPseq_RUNX1-ETO_5Dox_peaks_filt10.narrowPeak -b ${ATAC}/5Dox_peaks_filt10.narrowPeak > ${OUT}/ChIPseq_RUNX1-ETO_5Dox_inATAC.narrowPeak


##################
#Encode download
#################

cd /rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan

mkdir -p blacklist
cd blacklist

wget -L https://raw.githubusercontent.com/Boyle-Lab/Blacklist/master/lists/hg38-blacklist.v2.bed.gz
gunzip hg38-blacklist.v2.bed.gz

################
#encode filter
###############

#!/bin/bash
#SBATCH --job-name=ChIP_blacklist
#SBATCH --output=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_blacklist_%j.out
#SBATCH --error=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_blacklist_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=4G

set -euo pipefail

module purge
module load bear-apps/2024a/live
module load BEDTools/2.31.1-GCC-13.3.0

ROOT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
BL=${ROOT}/blacklist/hg38-blacklist.v2.bed
IN=${ROOT}/peaks/ChIP/ATAC_filtered
OUT=${ROOT}/peaks/ChIP/ATAC_filtered_noBL

mkdir -p "$OUT"

bedtools intersect -v -a ${IN}/ChIPseq_RUNX1_0Dox_inATAC.narrowPeak -b ${BL} > ${OUT}/ChIPseq_RUNX1_0Dox_inATAC_noBL.narrowPeak
bedtools intersect -v -a ${IN}/ChIPseq_RUNX1_5Dox_inATAC.narrowPeak -b ${BL} > ${OUT}/ChIPseq_RUNX1_5Dox_inATAC_noBL.narrowPeak
bedtools intersect -v -a ${IN}/ChIPseq_RUNX1-ETO_0Dox_inATAC.narrowPeak -b ${BL} > ${OUT}/ChIPseq_RUNX1-ETO_0Dox_inATAC_noBL.narrowPeak
bedtools intersect -v -a ${IN}/ChIPseq_RUNX1-ETO_5Dox_inATAC.narrowPeak -b ${BL} > ${OUT}/ChIPseq_RUNX1-ETO_5Dox_inATAC_noBL.narrowPeak
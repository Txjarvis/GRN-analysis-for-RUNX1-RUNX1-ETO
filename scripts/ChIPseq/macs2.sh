#!/bin/bash
#SBATCH --job-name=ChIP_macs2
#SBATCH --output=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_macs2_%j.out
#SBATCH --error=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_macs2_%j.err
#SBATCH --time=04:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2022a/live
module load MACS2/2.2.9.1-foss-2022a

ROOT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
ALIGN=${ROOT}/alignments/ChIP_align
OUT=${ROOT}/peaks/ChIP/raw_macs2

mkdir -p "$OUT"
cd "$ALIGN"

macs2 callpeak -t ChIPseq_RUNX1_0Dox.rmdup.bam -f BAM -g hs -q 0.01 --call-summits -n ChIPseq_RUNX1_0Dox --outdir "$OUT"
awk '$5 >= 10' "$OUT/ChIPseq_RUNX1_0Dox_peaks.narrowPeak" \
  | sort -k1,1 -k2,2n \
  > "$OUT/ChIPseq_RUNX1_0Dox_peaks_filt10.narrowPeak"

macs2 callpeak -t ChIPseq_RUNX1_5Dox.rmdup.bam -f BAM -g hs -q 0.01 --call-summits -n ChIPseq_RUNX1_5Dox --outdir "$OUT"
awk '$5 >= 10' "$OUT/ChIPseq_RUNX1_5Dox_peaks.narrowPeak" \
  | sort -k1,1 -k2,2n \
  > "$OUT/ChIPseq_RUNX1_5Dox_peaks_filt10.narrowPeak"

macs2 callpeak -t ChIPseq_RUNX1-ETO_0Dox.rmdup.bam -f BAM -g hs -q 0.01 --call-summits -n ChIPseq_RUNX1-ETO_0Dox --outdir "$OUT"
awk '$5 >= 10' "$OUT/ChIPseq_RUNX1-ETO_0Dox_peaks.narrowPeak" \
  | sort -k1,1 -k2,2n \
  > "$OUT/ChIPseq_RUNX1-ETO_0Dox_peaks_filt10.narrowPeak"

macs2 callpeak -t ChIPseq_RUNX1-ETO_5Dox.rmdup.bam -f BAM -g hs -q 0.01 --call-summits -n ChIPseq_RUNX1-ETO_5Dox --outdir "$OUT"
awk '$5 >= 10' "$OUT/ChIPseq_RUNX1-ETO_5Dox_peaks.narrowPeak" \
  | sort -k1,1 -k2,2n \
  > "$OUT/ChIPseq_RUNX1-ETO_5Dox_peaks_filt10.narrowPeak"
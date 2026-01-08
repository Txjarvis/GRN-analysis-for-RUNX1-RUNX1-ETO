#!/bin/bash
#SBATCH --job-name=ATAC_MACS2
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
#SBATCH --output=logs/ATAC_MACS2_%j.out
#SBATCH --error=logs/ATAC_MACS2_%j.err
#SBATCH --time=06:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2022a/live
module load MACS2/2.2.9.1-foss-2022a

ROOT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
ALIGN=${ROOT}/alignments
PEAKS=${ROOT}/peaks

mkdir -p logs "$PEAKS"
cd "$ALIGN"

for s in 0Dox 5Dox; do
  macs2 callpeak \
    -t "ATACseq_${s}.rmdup.bam" \
    -f BAM -g hs -n "${s}" \
    --nomodel --shift -100 --extsize 200 --call-summits \
    --outdir "$PEAKS"

  awk '$5 >= 10' "$PEAKS/${s}_peaks.narrowPeak" \
    | sort -k1,1 -k2,2n \
    > "$PEAKS/${s}_peaks_filt10.narrowPeak"
done
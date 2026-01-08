#!/bin/bash
#SBATCH --job-name=ATAC_peakcounts
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
#SBATCH --output=logs/ATAC_peakcounts_%j.out
#SBATCH --error=logs/ATAC_peakcounts_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=8G

set -euo pipefail

module purge
module load bear-apps/2022a/live
module load BEDTools

ROOT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
ALIGN=${ROOT}/alignments
PEAKS=${ROOT}/peaks

mkdir -p logs
cd "$PEAKS"

bedtools multicov \
  -bams "${ALIGN}/ATACseq_0Dox.rmdup.bam" \
        "${ALIGN}/ATACseq_5Dox.rmdup.bam" \
  -bed consensus_peaks.bed \
  > peak_counts.txt

printf "chr\tstart\tend\t0Dox\t5Dox\n" > peak_counts_named.txt
cat peak_counts.txt >> peak_counts_named.txt
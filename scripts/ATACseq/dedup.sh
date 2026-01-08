#!/bin/bash
#SBATCH --job-name=ATAC_dedup
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
#SBATCH --output=logs/ATAC_dedup_%j.out
#SBATCH --error=logs/ATAC_dedup_%j.err
#SBATCH --time=04:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2023a/live
module load SAMtools/1.18-GCC-12.3.0

ALIGN=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/alignments

mkdir -p logs
cd "$ALIGN"

for bam in ATACseq_*.sorted.bam; do
  base=${bam%.sorted.bam}

  samtools sort -n -o "${base}.namesort.bam" "$bam"
  samtools fixmate -m "${base}.namesort.bam" "${base}.fixmate.bam"
  samtools sort -o "${base}.possort.bam" "${base}.fixmate.bam"
  samtools markdup -r "${base}.possort.bam" "${base}.rmdup.bam"
  samtools index "${base}.rmdup.bam"

  rm -f "${base}.namesort.bam" "${base}.fixmate.bam" "${base}.possort.bam"
done
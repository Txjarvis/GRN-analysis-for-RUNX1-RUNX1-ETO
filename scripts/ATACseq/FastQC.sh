#!/bin/bash
#SBATCH --job-name=ATAC_fastqc
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
#SBATCH --output=logs/ATAC_fastqc_%j.out
#SBATCH --error=logs/ATAC_fastqc_%j.err
#SBATCH --time=02:00:00
#SBATCH --mem=4G

set -euo pipefail

module purge
module load bear-apps/2023a/live
module load FastQC

RAW=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data
OUT=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/qc

mkdir -p logs "$OUT"

fastqc \
  "$RAW"/ATACseq_0Dox.fastq.gz \
  "$RAW"/ATACseq_5Dox.fastq.gz \
  --outdir "$OUT"
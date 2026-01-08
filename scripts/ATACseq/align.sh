#!/bin/bash
#SBATCH --job-name=ATAC_align
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan
#SBATCH --output=logs/ATAC_align_%j.out
#SBATCH --error=logs/ATAC_align_%j.err
#SBATCH --time=12:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2023a/live
module load Bowtie2/2.5.4-GCC-12.3.0-Python-2.7.18
module load SAMtools/1.18-GCC-12.3.0

RAW=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data
ALIGN=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/alignments
GENOME=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/genomes/hg38/bowtie2/GRCh38

mkdir -p logs "$ALIGN"

SAMPLES=("ATACseq_0Dox.fastq.gz" "ATACseq_5Dox.fastq.gz")

for FASTQ in "${SAMPLES[@]}"; do
  base=$(basename "$FASTQ" .fastq.gz)

  bowtie2 -x "$GENOME" -U "$RAW/$FASTQ" --very-sensitive \
    | samtools view -b - \
    | samtools sort -o "${ALIGN}/${base}.sorted.bam"

  samtools index "${ALIGN}/${base}.sorted.bam"
done
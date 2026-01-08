#!/bin/bash
#SBATCH --job-name=ChIP_align
#SBATCH --output=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_align_%j.out
#SBATCH --error=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_align_%j.err
#SBATCH --time=12:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2023a/live
module load Bowtie2/2.5.4-GCC-12.3.0-Python-2.7.18
module load SAMtools/1.18-GCC-12.3.0

RAW=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data
GENOME=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/genomes/hg38/bowtie2/GRCh38
ALIGN=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/alignments/ChIP_align

mkdir -p "$ALIGN"

cd "$ALIGN"

bowtie2 -x "$GENOME" -U "$RAW/ChIPseq_RUNX1_0Dox.fastq.gz" --very-sensitive \
  | samtools view -b - \
  | samtools sort -o ChIPseq_RUNX1_0Dox.sorted.bam
samtools index ChIPseq_RUNX1_0Dox.sorted.bam

bowtie2 -x "$GENOME" -U "$RAW/ChIPseq_RUNX1_5Dox.fastq.gz" --very-sensitive \
  | samtools view -b - \
  | samtools sort -o ChIPseq_RUNX1_5Dox.sorted.bam
samtools index ChIPseq_RUNX1_5Dox.sorted.bam

bowtie2 -x "$GENOME" -U "$RAW/ChIPseq_RUNX1-ETO_0Dox.fastq.gz" --very-sensitive \
  | samtools view -b - \
  | samtools sort -o ChIPseq_RUNX1-ETO_0Dox.sorted.bam
samtools index ChIPseq_RUNX1-ETO_0Dox.sorted.bam

bowtie2 -x "$GENOME" -U "$RAW/ChIPseq_RUNX1-ETO_5Dox.fastq.gz" --very-sensitive \
  | samtools view -b - \
  | samtools sort -o ChIPseq_RUNX1-ETO_5Dox.sorted.bam
samtools index ChIPseq_RUNX1-ETO_5Dox.sorted.bam
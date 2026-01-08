#!/bin/bash
#SBATCH --job-name=trimmomatic
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --output=trimmomatic_%j.out
#SBATCH --mail-type=END

set -euo pipefail

module purge
module load bear-apps/2022b
module load Trimmomatic

R1="sample_1.fastq.gz"
R2="sample_2.fastq.gz"

OUT_DIR="trimmed"
mkdir -p "$OUT_DIR"

P1="$OUT_DIR/sample_1.paired.fastq.gz"
U1="$OUT_DIR/sample_1.unpaired.fastq.gz"
P2="$OUT_DIR/sample_2.paired.fastq.gz"
U2="$OUT_DIR/sample_2.unpaired.fastq.gz"

ADAPTERS="$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa"
THREADS="$SLURM_CPUS_PER_TASK"

trimmomatic PE \
  -threads "$THREADS" \
  -phred33 \
  "$R1" "$R2" \
  "$P1" "$U1" \
  "$P2" "$U2" \
  ILLUMINACLIP:"$ADAPTERS":2:30:10 \
  LEADING:3 \
  TRAILING:3 \
  SLIDINGWINDOW:4:20 \
  MINLEN:36
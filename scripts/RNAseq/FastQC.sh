#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --time=1:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=4
#SBATCH --output=fastqc_%j.out
#SBATCH --mail-type=END

set -euo pipefail

module purge
module load bear-apps/2022b
module load FastQC

mkdir -p fastqc_results

fastqc --threads "$SLURM_CPUS_PER_TASK" *.fastq.gz -o fastqc_results/
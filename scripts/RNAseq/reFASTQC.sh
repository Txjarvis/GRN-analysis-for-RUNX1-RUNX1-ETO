#!/bin/bash
#SBATCH --job-name=fastqc_trimmed
#SBATCH --time=1:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=4
#SBATCH --output=fastqc_trimmed_%j.out

set -euo pipefail

module purge
module load bear-apps/2022b
module load FastQC

mkdir -p trimmed/fastqc_results_trimmed

fastqc --threads "$SLURM_CPUS_PER_TASK" trimmed/*.paired.fastq.gz -o trimmed/fastqc_results_trimmed/
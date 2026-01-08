#!/bin/bash
#SBATCH --job-name=featureCounts
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --output=logs/featurecounts_%j.out
#SBATCH --error=logs/featurecounts_%j.err

set -euo pipefail

module purge
module load bear-apps/2022b
module load Subread

#edit to path - temporary
GTF="/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/ref/GRCh38/genes.gtf"

mkdir -p counts logs

featureCounts \
  -T "$SLURM_CPUS_PER_TASK" \
  -a "$GTF" \
  -o counts/gene_counts.txt \
  -p \
  -B \
  -C \
  /rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data/map/*.sorted.bam

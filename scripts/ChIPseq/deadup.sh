#!/bin/bash
#SBATCH --job-name=ChIP_dedup
#SBATCH --output=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_dedup_%j.out
#SBATCH --error=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/logs/ChIP_dedup_%j.err
#SBATCH --time=06:00:00
#SBATCH --mem=16G

set -euo pipefail

module purge
module load bear-apps/2023a/live
module load SAMtools/1.18-GCC-12.3.0

cd /rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/alignments/ChIP_align

samtools sort -n -o ChIPseq_RUNX1_0Dox.namesort.bam ChIPseq_RUNX1_0Dox.sorted.bam
samtools fixmate -m ChIPseq_RUNX1_0Dox.namesort.bam ChIPseq_RUNX1_0Dox.fixmate.bam
samtools sort -o ChIPseq_RUNX1_0Dox.possort.bam ChIPseq_RUNX1_0Dox.fixmate.bam
samtools markdup -r ChIPseq_RUNX1_0Dox.possort.bam ChIPseq_RUNX1_0Dox.rmdup.bam
samtools index ChIPseq_RUNX1_0Dox.rmdup.bam
rm -f ChIPseq_RUNX1_0Dox.namesort.bam ChIPseq_RUNX1_0Dox.fixmate.bam ChIPseq_RUNX1_0Dox.possort.bam

samtools sort -n -o ChIPseq_RUNX1_5Dox.namesort.bam ChIPseq_RUNX1_5Dox.sorted.bam
samtools fixmate -m ChIPseq_RUNX1_5Dox.namesort.bam ChIPseq_RUNX1_5Dox.fixmate.bam
samtools sort -o ChIPseq_RUNX1_5Dox.possort.bam ChIPseq_RUNX1_5Dox.fixmate.bam
samtools markdup -r ChIPseq_RUNX1_5Dox.possort.bam ChIPseq_RUNX1_5Dox.rmdup.bam
samtools index ChIPseq_RUNX1_5Dox.rmdup.bam
rm -f ChIPseq_RUNX1_5Dox.namesort.bam ChIPseq_RUNX1_5Dox.fixmate.bam ChIPseq_RUNX1_5Dox.possort.bam

samtools sort -n -o ChIPseq_RUNX1-ETO_0Dox.namesort.bam ChIPseq_RUNX1-ETO_0Dox.sorted.bam
samtools fixmate -m ChIPseq_RUNX1-ETO_0Dox.namesort.bam ChIPseq_RUNX1-ETO_0Dox.fixmate.bam
samtools sort -o ChIPseq_RUNX1-ETO_0Dox.possort.bam ChIPseq_RUNX1-ETO_0Dox.fixmate.bam
samtools markdup -r ChIPseq_RUNX1-ETO_0Dox.possort.bam ChIPseq_RUNX1-ETO_0Dox.rmdup.bam
samtools index ChIPseq_RUNX1-ETO_0Dox.rmdup.bam
rm -f ChIPseq_RUNX1-ETO_0Dox.namesort.bam ChIPseq_RUNX1-ETO_0Dox.fixmate.bam ChIPseq_RUNX1-ETO_0Dox.possort.bam

samtools sort -n -o ChIPseq_RUNX1-ETO_5Dox.namesort.bam ChIPseq_RUNX1-ETO_5Dox.sorted.bam
samtools fixmate -m ChIPseq_RUNX1-ETO_5Dox.namesort.bam ChIPseq_RUNX1-ETO_5Dox.fixmate.bam
samtools sort -o ChIPseq_RUNX1-ETO_5Dox.possort.bam ChIPseq_RUNX1-ETO_5Dox.fixmate.bam
samtools markdup -r ChIPseq_RUNX1-ETO_5Dox.possort.bam ChIPseq_RUNX1-ETO_5Dox.rmdup.bam
samtools index ChIPseq_RUNX1-ETO_5Dox.rmdup.bam
rm -f ChIPseq_RUNX1-ETO_5Dox.namesort.bam ChIPseq_RUNX1-ETO_5Dox.fixmate.bam ChIPseq_RUNX1-ETO_5Dox.possort.bam
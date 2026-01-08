#!/bin/bash
#SBATCH --job-name=findMotifs
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --output=findMotifs_%j.log

module purge
module load bear-apps/2020a/live
module load HOMER/4.11-foss-2020a

module load BEDTools/2.29.2-GCC-9.3.0

source ~/.bashrc
conda activate grn-env

echo "annotatePeaks.pl path:"
which annotatePeaks.pl

cd /rds/projects/c/cazierj-msc-bioinf-dl/txj215/Project/Gene_regulatory_network_analysis

# Sort peaks
bedtools sort \
  -i /rds/projects/c/cazierj-msc-bioinf-dl/txj215/Project/Peaks/ATAC/DAPs_annotated_for_GRN.bed \
  > DAPs_annotated_for_GRN.sorted.bed

# Run motif discovery
python findMotifs.py \
  DAPs_annotated_for_GRN.sorted.bed \
  motif_PWM_database \
  hg38 \
  Motif_results

# 

#############
#additional
#############

mkdir -p ${BASE}/Motifs/ChIP_union_Motif_results_0Dox
annotatePeaks.pl ${OUT_CHIP}/ChIP_union_0Dox.bed hg38 \
  -m ${MOTIF_BASE}/0Dox/homerMotifs.all.motifs \
  -mbed ${BASE}/Motifs/ChIP_union_motif_hits_0Dox.mbed > /dev/null

# split into per-motif BEDs
cd ${BASE}/Motifs
mkdir -p ChIP_union_Motif_results_0Dox
awk '$4 !~ /^description=/' \
  {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6 >> "ChIP_union_Motif_results_0Dox/"$4".bed"} \
  ChIP_union_motif_hits_0Dox.mbed


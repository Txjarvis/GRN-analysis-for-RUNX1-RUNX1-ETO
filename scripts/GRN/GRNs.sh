#!/bin/bash
#SBATCH --job-name=GRN_final_0Dox_5Dox
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --output=GRN_final_0Dox_5Dox_%j.log

module purge
module load bear-apps/2020a/live

source ~/.bashrc
conda activate grn-env

BASE=/rds/projects/c/cazierj-msc-bioinf-dl/txj215/Project
GRN_REPO=${BASE}/Gene_regulatory_network_analysis
ATAC_DIR=${BASE}/Peaks/ATAC
MOTIF_DIR_0=${BASE}/Motifs/Denovo_Motif_results_0Dox
MOTIF_DIR_5=${BASE}/Motifs/Denovo_Motif_results_5Dox
EXPR_0=${BASE}/expression_GRN_0Dox_noFC.tsv
EXPR_5=${BASE}/expression_GRN_5Dox_noFC.tsv
TF_ANN=${GRN_REPO}/TF_family_gene_annotation.tsv
GRN_OUT_DIR=${BASE}/GRN

mkdir -p "${GRN_OUT_DIR}"

cd "${GRN_REPO}" || exit 1

python build_gene_regulatory_network.py \
  "${ATAC_DIR}/DAPs_annotated_for_GRN_0Dox_clean.bed" \
  "${MOTIF_DIR_0}" \
  "${EXPR_0}" \
  "${TF_ANN}" \
  "${GRN_OUT_DIR}/AML_t821_GRN_0Dox_final" \
  -a \
  -m 0

python build_gene_regulatory_network.py \
  "${ATAC_DIR}/DAPs_annotated_for_GRN_5Dox_clean.bed" \
  "${MOTIF_DIR_5}" \
  "${EXPR_5}" \
  "${TF_ANN}" \
  "${GRN_OUT_DIR}/AML_t821_GRN_5Dox_final" \
  -a \
  -m 0

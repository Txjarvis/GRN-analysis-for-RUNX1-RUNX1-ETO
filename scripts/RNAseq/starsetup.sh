#STAR setup

mkdir -p /rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/ref/GRCh38/STAR_index
cd /rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/ref/GRCh38
still inside your GRCh38 folder
wget ftp://ftp.ensembl.org/pub/release-112/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-112/gtf/homo_sapiens/Homo_sapiens.GRCh38.112.gtf.gz
gunzip *.gz
Homo_sapiens.GRCh38.dna.primary_assembly.fa
Homo_sapiens.GRCh38.112.gtf
module load STAR
wget ftp://ftp.ensembl.org/pub/release-112/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-112/gtf/homo_sapiens/Homo_sapiens.GRCh38.112.gtf.gz
gunzip *.gz
mv Homo_sapiens.GRCh38.dna.primary_assembly.fa GRCh38.fa
mv Homo_sapiens.GRCh38.112.gtf genes.gtf

--genomeDir STAR_index \
--genomeFastaFiles GRCh38.fa \
--sjdbGTFfile genes.gtf

#STAR step 1

#!/bin/bash
#SBATCH --job-name=build_star_index
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --output=build_star_index_%j.out
#SBATCH --error=build_star_index_%j.err
#SBATCH --chdir=/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/ref/GRCh38

set -euo pipefail

module purge
module load bear-apps/2020b/live
module load STAR/2.7.6a-GCC-10.2.0

STAR --runThreadN "${SLURM_CPUS_PER_TASK:-8}" \
     --runMode genomeGenerate \
     --genomeDir STAR_index \
     --genomeFastaFiles GRCh38.fa \
     --sjdbGTFfile genes.gtf \
     --sjdbOverhang 100

#Star step 2

#!/bin/bash
#SBATCH --job-name=star_align
#SBATCH --time=08:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --output=star_align_%j.out
#SBATCH --error=star_align_%j.err

set -euo pipefail

module purge
module load bear-apps/2020b/live
module load STAR/2.7.6a-GCC-10.2.0

GENOME_DIR="/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/ref/GRCh38/STAR_index"
MAP_DIR="/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data/map"

mkdir -p "$MAP_DIR"

R1="/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data/trimmed/sample_1.paired.fastq.gz"
R2="/rds/projects/k/keanep-bioinformatics/MSc_DL_Tegan/raw_data/trimmed/sample_2.paired.fastq.gz"
SAMPLE="sample"

STAR \
  --runThreadN "$SLURM_CPUS_PER_TASK" \
  --genomeDir "$GENOME_DIR" \
  --readFilesIn "$R1" "$R2" \
  --readFilesCommand zcat \
  --outSAMtype BAM SortedByCoordinate \
  --limitBAMsortRAM 12000000000 \
  --outFileNamePrefix "${MAP_DIR}/${SAMPLE}_"

mv "${MAP_DIR}/${SAMPLE}_Aligned.sortedByCoord.out.bam" \
   "${MAP_DIR}/${SAMPLE}.sorted.bam"
#!/bin/bash
#SBATCH --job-name=post_mapping_fastq_qc
#SBATCH --output=post_mapping_fastq_qc.txt
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mem=100G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@postgrad.manchester.ac.uk

############################################################################## 

ml apps/multiqc/1.15

##############################################################################

cd '/data/eoh/kgurashi/Other_projects/KB42/STAR_Alignments'

multiqc /data/eoh/kgurashi/Other_projects/KB42/FASTQ/FastqQC /data/eoh/kgurashi/Other_projects/KB42/STAR_Alignments

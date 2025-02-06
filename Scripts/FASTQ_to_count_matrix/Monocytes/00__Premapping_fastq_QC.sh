#!/bin/bash
#SBATCH --job-name=pre_mapping_fastq_qc
#SBATCH --output=pre_mapping_fastq_qc.txt
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mem=100G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@postgrad.manchester.ac.uk

############################################################################## 

ml apps/fastqc/0.12.1
ml apps/multiqc/1.15

##############################################################################

fastqc /data/eoh/kgurashi/Other_projects/KB42/FASTQ/*.fastq.gz -t 48 --outdir=/data/eoh/kgurashi/Other_projects/KB42/FASTQ/FastqQC

cd '/data/eoh/kgurashi/Other_projects/KB42/FASTQ/FastqQC'

multiqc .
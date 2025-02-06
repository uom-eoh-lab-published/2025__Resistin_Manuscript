#!/bin/bash
#SBATCH --job-name=salmon_quantification
#SBATCH --output=salmon_quantification.txt
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mem=100G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@postgrad.manchester.ac.uk

############################################################################## 

ml apps/salmon/1.10.2

##############################################################################

BAM_folder=/data/eoh/kgurashi/Other_projects/KB42/STAR_Alignments
mkdir /data/eoh/kgurashi/Other_projects/KB42/Salmon_reads

cd $BAM_folder/

for i in $(ls *_star_Aligned.toTranscriptome.out.bam | awk -F_R '{print $1}' | uniq )

do

output_name="${i%_S[0-9]*}"


salmon quant --threads 96 \
--geneMap /data/eoh/kgurashi/Genomes/GENCODE_genome_files/GENCODE_v42.annotation.gtf \
--targets /data/eoh/kgurashi/Genomes/GENCODE_genome_files/GENCODE_v42.transcripts.fa \
--gencode \
--libType A \
--gcBias \
--seqBias \
--alignments $i \
--output /data/eoh/kgurashi/Other_projects/KB42/Salmon_reads/$output_name


done

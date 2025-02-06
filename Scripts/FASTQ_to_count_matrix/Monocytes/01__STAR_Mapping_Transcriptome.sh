#!/bin/bash
#SBATCH --job-name=STAR_mapping
#SBATCH --output=STAR_mapping.txt
#SBATCH --cpus-per-task=48
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mem=100G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@postgrad.manchester.ac.uk

############################################################################## 

ml apps/star/2.5.1b
ml apps/bedtools/2.31.0
ml apps/samtools/1.17

##############################################################################

## Merged Fastq Dir

fastqDir=/data/eoh/kgurashi/Other_projects/KB42/FASTQ/Merged
cd $fastqDir/

# STAR mapping

genomeDir="/data/eoh/kgurashi/Genomes/GENCODE_genome_files/GENCODE_v42.INDEX_STAR_100bp"
gtfFile="/data/eoh/kgurashi/Genomes/GENCODE_genome_files/GENCODE_v42.annotation.gtf"

# Looping through all files

for i in $(ls *.fastq.gz | awk -F_R '{print $1}' | uniq )

do


R1=$fastqDir/${i}"_R1.fastq.gz"

mkdir /data/eoh/kgurashi/Other_projects/KB42/STAR_Alignments

outputPrefix=/data/eoh/kgurashi/Other_projects/KB42/STAR_Alignments/${i}_star_

STAR --runThreadN 48 \
--genomeDir $genomeDir \
--twopassMode Basic \
--readFilesCommand zcat \
--readFilesIn $R1 \
--sjdbGTFfile $gtfFile \
--sjdbScore 2 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes NH HI AS NM MD \
--outFilterMultimapNmax 20 \
--outFilterScoreMinOverLread 0.50 \
--outFilterMatchNminOverLread 0.50 \
--outFilterMismatchNmax 10 \
--outFilterType BySJout \
--outFilterMismatchNoverLmax 0.04 \
--outFileNamePrefix $outputPrefix \
--quantTranscriptomeBan IndelSoftclipSingleend \
--quantMode TranscriptomeSAM GeneCounts


done
#!/bin/bash
#SBATCH -n 4              # Number of cores
#SBATCH -N 1               # Ensure that all cores are on one machine
#SBATCH -t 0-00:30         # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test            # Partition to submit to
#SBATCH --mem=2000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/fastqs_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/fastqs_%j.err  # File to which STDERR will be written, %j inserts jobid

mkdir -p raw_fastqs
cd raw_fastqs

#create symlinks to raw fastqs for all included samples

cat ../samples_rmoutliers.txt | while read sample
do
	ln -s ../../2_ipyrad/varroa_edits/${sample}.trimmed_R1_.fastq.gz \
		./${sample}.trimmed_R1_.fastq.gz
		
	ln -s ../../2_ipyrad/varroa_edits/${sample}.trimmed_R2_.fastq.gz \
		./${sample}.trimmed_R2_.fastq.gz
	
done

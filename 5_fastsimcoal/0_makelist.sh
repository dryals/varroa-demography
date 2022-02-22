#!/bin/bash
#SBATCH -n 1               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-00:10          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=200         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/makelist_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/makelist_%j.err  # File to which STDERR will be written, %j inserts jobid

mkdir -p filelists
cd pops_bystate

cat list.txt | while read pop
do
	cat $pop.txt | while read sample
	do
		touch ../filelists/$pop.filelist
		echo "../../3_PCA/bamfiles/$sample.bam" >> ../filelists/$pop.filelist
	done
	
done

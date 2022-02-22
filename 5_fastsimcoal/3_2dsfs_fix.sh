#!/bin/bash
#SBATCH -n 12               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=2500        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/fix_2dsfs_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/fix_2dsfs_%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals and B. Medeiros Mar 2020
#updated 10feb21

module load angsd/0.920-fasrc01 samtools


cd 2dsfs

	
	realSFS ../saf_files/MT.s.saf.idx ../saf_files/MT.m.saf.idx -P 12 >MT.s.sfs

echo 'done'

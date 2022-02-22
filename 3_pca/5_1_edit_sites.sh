#!/bin/bash
#SBATCH -n 1                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=1000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/edit_list_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/edit_list_%j.err  # File to which STDERR will be written, %j inserts jobid

#dylan ryals 10jan21

echo 'editing ascii list'

touch hwe_filter/varroa.edited.sites

cat hwe_filter/varroa.filtered.sites | while read site
do
	echo "$site" | tr _ '\t' >> hwe_filter/varroa.edited.sites

done


echo 'loading modules'

module load angsd/0.920-fasrc01 samtools

echo 'converting ascii -> bin with angsd'

angsd sites index hwe_filter/varroa.edited.sites

echo 'done' 

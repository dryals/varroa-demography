#!/bin/bash
#SBATCH -n 1               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-00:10          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=1000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/thetaw.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/thetaw.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals May 2021

module load angsd/0.920-fasrc01

cat pop_list.txt | while read pop
do
	echo working on $pop
	
	thetaStat do_stat thetas/$pop.thetas.idx -win 10000 -step 10000 \
	-outnames thetas/$pop.thetasWindow
	
	echo done

done

echo all done
#!/bin/bash
#SBATCH -n 4               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=10000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/theta.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/theta.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals March 2020

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna

angsd -P 4 -b global.bamlist -ref $REF -anc $REF -out priors/global.theta \
        -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 \
        -minMapQ 20 -minQ 20 -setMinDepth 1 -doCounts 1 \
        -GL 1 -doSaf 1 \
		-doThetas 1 -pest priors/global.sfs

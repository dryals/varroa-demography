#!/bin/bash
#SBATCH -n 4               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-01:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=2000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/thetaw.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/thetaw.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals March 2020

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna

thetaStat do_stat priors/global.theta.thetas.idx -win 10000 -step 10000 \
-outnames priors/global.thetaWindow

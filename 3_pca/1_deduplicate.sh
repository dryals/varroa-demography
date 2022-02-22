#!/bin/bash
#SBATCH -n 16              # Number of cores
#SBATCH -N 1               # Ensure that all cores are on one machine
#SBATCH -t 0-08:00         # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test            # Partition to submit to
#SBATCH --mem=20000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/dedup_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/dedup_%j.err  # File to which STDERR will be written, %j inserts jobid

mkdir -p filtered_fastqs

module load gcc/7.1.0-fasrc01 stacks/2.4-fasrc01

clone_filter -P -p ./raw_fastqs -i gzfastq -o ./filtered_fastqs --index_null --oligo_len_2 8

echo done
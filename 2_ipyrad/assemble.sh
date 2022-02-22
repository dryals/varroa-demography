#!/bin/bash
#SBATCH -n 1                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-4:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p serial_requeue   # Partition to submit to
#SBATCH --mem=25000           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/ipyrad_%a_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/ipyrad_%a_%j.err  # File to which STDERR will be written, %j inserts jobid


echo loading modules

module load Anaconda
source activate ipyrad


echo starting ipyrad

#run step 1 for each pool
ipyrad -p params-P${SLURM_ARRAY_TASK_ID}.txt -f -s 1 -c 24


echo done

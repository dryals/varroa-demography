#!/bin/bash
#SBATCH -n 4                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-01:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=25000           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/list_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/list_%j.err  # File to which STDERR will be written, %j inserts jobid


#updated: 6jan21

echo loading modules

module load Anaconda3 angsd
source activate pcangsd

echo 'running script...'
gzip hwe_filter/varroa.post.beagle

python3 pcangsd/pcangsd.py -b hwe_filter/varroa.post.beagle.gz -minMaf 0 \
	-hwe hwe_filter/varroa.lrt.sites.npy -sites_save -o hwe_filter/varroa.filtered



echo done

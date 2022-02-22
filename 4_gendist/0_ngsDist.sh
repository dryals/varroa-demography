#!/bin/bash
#SBATCH -n 8              # Number of cores
#SBATCH -N 1               # Ensure that all cores are on one machine
#SBATCH -t 0-08:00         # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test            # Partition to submit to
#SBATCH --mem=20000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/ngsDist_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/ngsDist_%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals 20oct21

#create variables
echo "zipping beagle"
gzip ../3_PCA/pcangsd_out/varroa.pca.post.beagle

export BEAGLE=../3_PCA/pcangsd_out/varroa.pca.post.beagle.gz

NSAMP=`wc -l ../3_PCA/bam.filelist | cut -d " " -f 1`
NSITES=`wc -l ../3_PCA/pcangsd_out/varroa.pca.sites| cut -d " " -f 1`


echo "$NSAMP samples"
echo "$NSITES sites"

mkdir -p dist_out

echo "working on ngsDist"

#usage:
# ./ngsDist [options] --geno /path/to/input/file --n_ind INT --n_sites INT --out /path/to/output/file

ngsDist/ngsDist --geno $BEAGLE --probs --n_ind $NSAMP --n_sites $NSITES -out dist_out/varroa

echo "done"

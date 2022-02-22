#!/bin/bash
#SBATCH -n 16                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=20000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/PCA_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/PCA_%j.err  # File to which STDERR will be written, %j inserts jobid

# adapted Jan 2020 from script by Bruno de Medeiros 
# updated 15 dec 20; 6jan21


#  We will use ANGSD to generate PCA plots, which we will use to calculate population distances
echo loading Anaconda...
module load Anaconda3 angsd

echo activating environment...
source activate pcangsd

#set variables for command
echo 'working on PCA'
nsamp=$(cat bam.filelist | wc -l)
maf=$(bc <<< "scale=6; 2/$nsamp") #need at least two ind. 



mkdir -p pcangsd_out

python3 pcangsd/pcangsd.py -beagle final_angsd_out/varroa.beagle.gz -sites_save -post_save\
    -threads $SLURM_NTASKS -geno 0.8 -o pcangsd_out/varroa.pca
	
echo 'done'

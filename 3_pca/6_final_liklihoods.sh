#!/bin/bash
#SBATCH -n 8                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=25000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/final_lik_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/final_lik_%j.err  # File to which STDERR will be written, %j inserts jobid

#adapted Jan 2020 from script by Bruno de Medeiros 
#edited Dylan Ryals 10jan21

# We will use ANGSD to generate PCA plots, which we will use to calculate population distances
echo 'loading modules...'

module load angsd/0.920-fasrc01 samtools


mkdir -p final_angsd_out
# it seems threading does not really speed up angsd, so we will run in only one core 

# run angsd to obtain genotype likelihoods
# options used:
# -nThreads		number of threads
# -GL 2			use GATK for genotype likelihoods
# -doGlf 2		create an output file in beagle format
# -doMaf 1		both major and minor alleles assumed to be known
# -doMajorMinor 1	infer major and minor alleles from genotype likelihoods
# -SNP_pval 1e-6	filter only to SNPs with p-value less than 1e-6
# -dosnpstat 1		calculate SNP statistics to enable filtering
# -uniqueOnly 1		only use reads mapping to unique location
# -bam bam.filelist	input file
# -out g_likelihoods	root of output file
# -setmindepth 		minimum amount of reads to count as a site. 1 gives all sites possible to keep the most data

echo 'working on angsd'

angsd   -nThreads $SLURM_NTASKS \
        -GL 2 \
        -doGlf 2 \
        -doMaf 1 \
        -doMajorMinor 1 \
        -minMapQ 30 \
        -minQ 20 \
        -SNP_pval 1e-6 \
        -doHWE 1 \
        -dosnpstat 1 \
        -bam bam.filelist \
        -uniqueOnly 1 \
        -remove_bads 1 \
        -only_proper_pairs 1 \
        -doCounts 1 \
        -setMinDepth 1 \
	-sites hwe_filter/varroa.edited.sites \
        -out final_angsd_out/varroa
        
echo 'done'

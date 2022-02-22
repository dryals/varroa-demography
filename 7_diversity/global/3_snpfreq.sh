#!/bin/bash
#SBATCH -n 12               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=20000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/snpfreq.sfs.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/snpfreq.sfs.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals March 2020

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna

#make saf
echo working on global saf

angsd   -anc $REF \
		-P $SLURM_NTASKS \
		-b global.bamlist \
		-doHWE 1 \
        -GL 2 \
        -doGlf 2 \
        -doMaf 1 \
        -doMajorMinor 1 \
        -minMapQ 30 \
        -minQ 20 \
        -SNP_pval 1e-6 \
        -dosnpstat 1 \
        -uniqueOnly 1 \
        -remove_bads 1 \
        -only_proper_pairs 1 \
        -doCounts 1 \
        -setMinDepth 1 \
        -doSaf 1 \
        -out snpfreq/global
        
echo 'done'

#create sfs
echo working on SFS
realSFS snpfreq/global.saf.idx -P 12 2> /dev/null > snpfreq/global.sfs

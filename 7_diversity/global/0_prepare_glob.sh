#!/bin/bash
#SBATCH -n 8               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=20000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/prep.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/prep.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals April 2021

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna

#make bamfile

if [ ! -f global.bamlist ]; then
    echo "making bamlist"
    touch global.bamlist
    cat samples_rmoutliers.txt | while read sample
    do
    	echo "../../3_PCA/bamfiles/$sample.bam" >> global.bamlist
    done
fi

#create SAF

echo creating SAF prior

angsd -b global.bamlist -ref $REF -anc $REF -out priors/global \
	-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
	-minMapQ 30 -minQ 20 -setMinDepth 1 -minInd 135 -doCounts 1 \
	-GL 1 -doSaf 1 -P 8

#create sfs
echo creating SFS
realSFS priors/global.saf.idx -P 8 2> /dev/null > priors/global.sfs

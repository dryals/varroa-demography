#!/bin/bash
#SBATCH -n 8               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=10000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/mafs.%a.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/mafs.%a.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals April 2021

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna
export SIM=../../6_fastsimcoal/filelists

pop=$(cat pop_list.txt | sed -n ${SLURM_ARRAY_TASK_ID}p) 

N=$(wc -l < $SIM/$pop.filelist | tr -d ' \t\n')
N=$(( $N / 2 ))

touch mafsout.txt
 
echo working on $pop maf >> mafsout.txt

angsd -P 8 -b $SIM/$pop.filelist -ref $REF -anc $REF -out mafs/$POP \
        -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
        -minMapQ 30 -minQ 20 -minInd $N -setMinDepth 1 -doCounts 1 \
        -GL 1 -doMajorMinor 5 -doMaf 1 -skipTriallelic 1
        
echo $pop done >> mafsout.txt
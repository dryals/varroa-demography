#!/bin/bash
#SBATCH -n 24               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-08:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test   # Partition to submit to
#SBATCH --mem=20000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/saf_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/saf_%j.err  # File to which STDERR will be written, %j inserts jobid

#10feb21 dylan ryals

module purge
module load angsd/0.920-fasrc01 samtools

mkdir -p saf_files

cd saf_files

cat ../pops_bystate/list.txt | while read pop
do
        #options as suggested by Bruno
        #reference genome
        #-dosaf 1 / -gl 2 : saf and genotype likelihood models: GATK
        #-minmapq : minimum mapping quality to consider a read. 30 = 1^e3, or 0.1% estimate error rate
        #-minQ : minimum sequence quality to consider a read. 20 = 1e-2, or 1% error rate.
        #-SNP_pval : p-val threshold to consider that a site contains a SNP
        #-uniqueonly : discard reads mapped to multiple places
        
        angsd -b ../filelists/$pop.filelist \
              -anc ../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna \
              -dosaf 1 \
              -gl 2 \
              -minmapq 30 \
              -minQ 20 \
              -uniqueonly 1 \
              -remove_bads 1 \
              -only_proper_pairs 1 \
              -doCounts 1 \
              -setMinDepth 1 \
              -setMaxDepth 200 \
              -out $pop
done
echo 'done'

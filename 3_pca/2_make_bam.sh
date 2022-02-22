#!/bin/bash
#SBATCH -n 16              # Number of cores
#SBATCH -N 1               # Ensure that all cores are on one machine
#SBATCH -t 0-04:00         # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p test            # Partition to submit to
#SBATCH --mem=20000         # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/make_bam_%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e outputs/make_bam_%j.err  # File to which STDERR will be written, %j inserts jobid

#20 jan 2020; updated for new genome 14 dec 20

mkdir -p bamfiles
cd bamfiles

echo Making bwa index

#index reference genome with bwa
module load bwa/0.7.15-fasrc02 samtools/1.5-fasrc02 
bwa index -p varroa ../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna

# map using bwa:
cat ../samples_rmoutliers.txt | while read sample
do
    echo WORKING ON $sample
    echo mapping...
    
    #selecting samples filtered with stacks
    bwa mem -M -t $SLURM_NTASKS -R "@RG\tID:${sample}\tSM:${sample}\tPL:ILLUMINA\tLB:${sample}_LIB" \
                varroa ../filtered_fastqs/${sample}.trimmed_R1_.1.fq.gz \
                ../filtered_fastqs/${sample}.trimmed_R2_.2.fq.gz > ${sample}_bwa.sam
                    
    echo sorting and indexing
    
    #sort and index sam files, output to .bam for use in angsd
    samtools sort ${sample}_bwa.sam -o $sample.bam
    samtools index $sample.bam
done

echo done

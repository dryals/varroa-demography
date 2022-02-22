#!/bin/bash
#SBATCH -n 1               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 0-04:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p shared,test   # Partition to submit to
#SBATCH --mem=5000        # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output/het.%a.%j.out  # File to which STDOUT will be written, %j inserts jobid
#SBATCH -e output/het.%a.%j.err  # File to which STDERR will be written, %j inserts jobid

#Dylan Ryals Oct 2021

echo script starting...

module load angsd/0.920-fasrc01

export REF=../../0_ref/GCA_002443255.1_Vdes_3.0_genomic.fna
export SIM=../../6_fastsimcoal/filelists

pop=$(cat pop_list.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)

mkdir -p het_est/$pop

echo working on $pop >> het.txt

cat $SIM/$pop.filelist | while read bamfile
    do   	
			bam=$( basename $bamfile )
			bam=$(echo "$bam" | cut -f 1 -d '.')    
    
    
    	echo working on $bam saf
        	
        angsd -P 1 -i $bamfile -anc $REF -ref $REF -out het_est/$pop/$bam \
        	-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
        	-minMapQ 30 -minQ 20 -setMinDepth 10 \
        	-GL 1 -doSaf 1 -doMaf 1 -doMajorMinor 1 -doCounts 1
        	
        echo working on $bam sfs
        
		realSFS het_est/$pop/$bam.saf.idx -P 1 > het_est/$pop/$bam.sfs
   
    done

echo finished $pop >> het.txt
    

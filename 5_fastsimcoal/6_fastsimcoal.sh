#!/bin/bash
#SBATCH -J SFS_ML
#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 2-00:00 # Runtime in D-HH:MM
#SBATCH -p serial_requeue # Partition to submit to
#SBATCH --mem 300 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o outputs/ML_%a_%A.out # File to which STDOUT will be written

#script adapted from Bruno de Medieros
#Dylan Ryals 2 mar 21
#https://github.com/brunoasm/rad_palm_weevil/blob/master/fastsimcoal/1-do_ML_estimate.sh


# We estimated the SFS in ANGSD and will use it now to estimate migration between populations in fastsimcoal


module load gcc openmpi

# make sure there is a tpl and an est file in the folder


mkdir -p ML_SEARCH_$SLURM_ARRAY_TASK_ID
cd ML_SEARCH_$SLURM_ARRAY_TASK_ID

ln -s ../*.obs ./
ln -s ../*.est ./
ln -s ../*.tpl ./

echo 'starting fastsimcoal'

#-L number of cycles for parameter update. Seems to stabilize around 100
#-n number of simulated SFS 


../../../fsc26_linux64/fsc26 -t *.tpl \
      -e *.est \
      --multiSFS \
      --dsfs \
      --cores $SLURM_NTASKS \
      --numBatches $SLURM_NTASKS \
      --maxlhood \
      -L 100 \
      -n 100000 \
      --seed 6450$SLURM_ARRAY_TASK_ID \
      -q

echo 'done'
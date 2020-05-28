#!/bin/bash
# 
#This is a job array to run script.py -i array task id
#
#Give your job a name
#SBATCH --job-name=name
#SBATCH --output=/nfs/scistore08/kondrgrp/alyulina/path-to-the-outputs/name-%A_%a.out
#
#Specify time limit; max is 10 days, i.e. 240 hours
#SBATCH --time=1-00:00
#
#Specify memory in gigabytes
#SBATCH --mem=64G
#
#Specify account and partition
#SBATCH --account=kondrgrp
#SBATCH --partition=bigtb
#
#Would you like to be notified when the job starts or is completed?
#SBATCH --mail-user=alyulina@ist.ac.at
#SBATCH --mail-type=ALL
#
#Do not restart the job if it fails
#SBATCH --no-requeue
#
#Submit a job array of N + 1 jobs limiting the number of simultateously running ones to K
#SBATCH --array=0-N%K
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV
#
#For single-CPU jobs, make sure that they use a single thread
export OMP_NUM_THREADS=1
#
#Load the software module you intend to use
module load python/3.5
#
#Print the task id
echo $SLURM_ARRAY_TASK_ID
#
#Run a script that takes $SLURM_ARRAY_TASK_ID as input
srun --cpu_bind=verbose python ./script.py -i $SLURM_ARRAY_TASK_ID

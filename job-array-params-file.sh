#!/bin/bash
# 
#This is a job array to run a script varying input parameters;
#requires an additional input file of lenght N
#
#Give your job a name
#SBATCH --job-name=name
#SBATCH --output=name-%A_%a.out
#
#Specify time limit; max is 10 days, i.e. 240 hours
#SBATCH --time=10-00:00
#
#Specify memory in gigabytes
#SBATCH --mem=4G
#
#Specify account and partition, if needed
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
#Submit a job array of N jobs
#SBATCH --array=1-N
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV
#
#For single-CPU jobs, make sure that they use a single thread
export OMP_NUM_THREADS=1
#
#Load modules, if needed
#
#Print the task id
echo $SLURM_ARRAY_TASK_ID
#
#Run a binary that takes nth line of input.txt as input
srun --cpu_bind=verbose /nfs/scistore08/kondrgrp/alyulina/path/to/the/binary $(head -$SLURM_ARRAY_TASK_ID input.txt | tail -1)

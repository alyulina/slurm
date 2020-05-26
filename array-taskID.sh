#!/bin/bash
# 
#This is a job array script to run script.py that tekes the array task ID as input to the -i flag
#
#SBATCH --job-name=name
#SBATCH --output=name-%A_%a.out
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, i.e. 240 hours
#SBATCH --time=1-00:00
#
#Define the amount of RAM used by your job in GB
#SBATCH --mem=64G
#
#Specify account and partition
#SBATCH --account=kondrgrp
#SBATCH --partition=bigtb
#
#Send emails when a job starts, it is finished or it exits
#SBATCH --mail-user=alyulina@ist.ac.at
#SBATCH --mail-type=ALL
#
#SBATCH --no-requeue
#
#Submit a job array
#SBATCH --array=0-N
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
echo $SLURM_ARRAY_TASK_ID

#Run the binary that takes $SLURM_ARRAY_TASK_ID as input
srun --cpu_bind=verbose python ./script.py -i $SLURM_ARRAY_TASK_ID

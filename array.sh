#!/bin/bash
#
#SBATCH --job-name=name
#SBATCH --output=name-%A_%a.out
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, ie. 240 hours
#SBATCH --time=1-00:00
#
#Define the amount of RAM used by your job in GigaBytes
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
#Pick whether you prefer requeue or not. If you use the --requeue
#option, the requeued job script will start from the beginning, 
#potentially overwriting your previous progress, so be careful.
#For some people the --requeue option might be desired if their
#application will continue from the last state.
#Do not requeue the job in the case it fails
#SBATCH --no-requeue
#
#Job array
#SBATCH --array=0-1
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV
#
#for single-CPU jobs make sure that they use a single thread
export OMP_NUM_THREADS=1
#
#load the respective software module you intend to use
module load python/3.5
#
#run your CUDA binary through SLURM's srun
echo $SLURM_ARRAY_TASK_ID
#run the respective binary through SLURM's srun
srun --cpu_bind=verbose python ./name.py -i $SLURM_ARRAY_TASK_ID

#!/bin/bash

#SBATCH --time=00:20:00
#SBATCH --account=rrg-pbellec
#SBATCH --array=1-10

module load singularity/3.4
PARAMS=$(cat params | head -n $SLURM_ARRAY_TASK_ID| tail -n 1)
echo $PARAMS

singularity --quiet exec -B ~/projects/rrg-pbellec/<user_name>/:/scripts anaconda3.simg python /scripts/par_job.py ${PARAMS[0]} ${PARAMS[1]}
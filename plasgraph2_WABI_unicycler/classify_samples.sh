#!/bin/bash

# Samples text file
SAMPLES=$1
# Creating the main slurm array script
sed "s/SAMPLES/${SAMPLES}/g" classify_samples_tmp.sh > classify_samples_${SAMPLES}.sh
# Running the slrm array script
sbatch classify_samples_${SAMPLES}.sh

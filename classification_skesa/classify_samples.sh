#!/bin/bash

# Samples text file
SAMPLES=$1
# Number of samples
NBSAMPLES=`wc -l ${SAMPLES} | cut -f 1 -d " "`
# Creating the main slurm array script
sed "s/NBSAMPLES/${NBSAMPLES}/g" classify_samples_tmp.sh > classify_samples_array.sh
# Running the slrm array script
sbatch classify_samples_array.sh

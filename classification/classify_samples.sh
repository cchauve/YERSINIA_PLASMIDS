#!/bin/bash
#SBATCH --gres=gpu:1 
#SBATCH --cpus-per-task=6 
#SBATCH --mem=32000M       
#SBATCH --time=1:00:00
#SBATCH --account=def-chauvec
#SBATCH --array=1-2
#SBATCH --output=plASgraph_%A_%a.log
#SBATCH --job-name=plasgraph

# Environment variables
source ../../config.sh
## Sample ID
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" samples.txt)
## Experiment and output directory
EXP_DIR=${REPO_HOME}/classification
OUT_DIR=${EXP_DIR}/${SAMPLE}
mkdir -p ${OUT_DIR} ${EXP_DIR}/tmp

# Preparing input: assembly graph
cp ${REPO_HOME}/assemblies/${SAMPLE}/short.gfa.gz ${EXP_DIR}/tmp/${SAMPLE}.gfa.gz
gunzip ${EXP_DIR}/tmp/${SAMPLE}.gfa.gz
GFA=${EXP_DIR}/tmp/${SAMPLE}.gfa

# Running plASgraph
source ${TOOLS_DIR}/env_plasgraph/bin/activate
cd ${TOOLS_DIR}/plASgraph
python plASgraph.py -i ${GFA} -o ${OUT_DIR}/${SAMPLE}_class.csv --draw_graph

# Cleaning
rm ${GFA}

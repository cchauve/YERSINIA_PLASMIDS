#!/bin/bash
#SBATCH --gres=gpu:1 
#SBATCH --cpus-per-task=6 
#SBATCH --mem=32000M       
#SBATCH --time=1:00:00
#SBATCH --account=def-chauvec
#SBATCH --array=1-1
#SBATCH --output=plASgraph_%A_%a.log
#SBATCH --job-name=plasgraph

# Environment variables
source ../config.sh
## Sample ID
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" samples.txt)
## Experiment and output directory
EXP_DIR=${REPO_HOME}/classification_skesa
OUT_DIR=${EXP_DIR}/${SAMPLE}
mkdir -p ${OUT_DIR}

# Preparing input: assembly graph
cp ${REPO_HOME}/assemblies_skesa/${SAMPLE}/short.gfa.gz ${OUT_DIR}/
gunzip ${OUT_DIR}/short.gfa.gz
GFA=${OUT_DIR}/short.gfa

# Running plASgraph
source ${TOOLS_DIR}/env_plasgraph/bin/activate
cd ${TOOLS_DIR}/plASgraph
python plASgraph.py -i ${GFA} -o ${OUT_DIR}/${SAMPLE}_class.csv --draw_graph

# Cleaning
rm ${GFA}

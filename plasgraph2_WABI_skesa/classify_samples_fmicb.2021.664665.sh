#!/bin/bash
#SBATCH --gres=gpu:1 
#SBATCH --cpus-per-task=6 
#SBATCH --mem=32000M       
#SBATCH --time=8:00:00
#SBATCH --account=def-chauvec
#SBATCH --output=plASgraph_fmicb.2021.664665.log
#SBATCH --job-name=plasgraph

# Environment variables
source ../config.sh
## Experiment and output directory
EXP_DIR=${REPO_HOME}/plasgraph2_WABI_skesa
OUT_DIR=${EXP_DIR}

# Running plASgraph
source ${TOOLS_DIR}/env_plasgraph2_working/bin/activate
cd ${TOOLS_DIR}/plasgraph2-working/src
python3 test.py ${EXP_DIR}/fmicb.2021.664665.csv ${REPO_HOME}/ ../tmp/efae-wabi-model ${OUT_DIR}/fmicb.2021.664665_class.csv

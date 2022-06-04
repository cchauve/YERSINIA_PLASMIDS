#!/bin/bash

LOGS=`ls slurm*.out`
for LOG in ${LOGS}
do
    SAMPLE=`grep fastq-dump ${LOG} | sed 's/\// /g' | cut -f 11 -d " "`
    cp ${LOG} ${SAMPLE}/short.log
    mv ${LOG} logs/
done

#!/usr/bin/env bash

sed -e 1d ../data/SraRunTable.txt | while read line
do

SRR=$(echo ${line} | cut -d , -f1)

indir="../data/sequencing/${SRR}"
outdir="../output/fastqc/${SRR}"
[[ -d ${outdir} ]] || mkdir ${outdir}

echo "SRR: ${SRR}"

call="fastqc -o ${outdir} -t 4 \
${indir}/${SRR}_1.fastq.gz \
${indir}/${SRR}_2.fastq.gz"

echo ${call}
eval ${call}

echo "${SRR} done"

done

#!/usr/bin/env bash

sed -e 1d ../data/SraRunTable.txt | while read line
do

SRR=$(echo ${line} | cut -d , -f1)

indir="../data/sequencing/${SRR}"
outdir="../output/trimmed/${SRR}"
[[ -d ${outdir} ]] || mkdir ${outdir}

echo "SRR: ${SRR}"

call="cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-j 8 --trim-n -m 25 -q 20,20 \
-o ${outdir}/${SRR}_1.fastq.gz \
-p ${outdir}/${SRR}_2.fastq.gz \
${indir}/${SRR}_1.fastq.gz \
${indir}/${SRR}_2.fastq.gz"

echo ${call}
eval ${call} 2>&1 | tee ../output/trimmed/logs/${SRR}.log

echo "${SRR} done"

done

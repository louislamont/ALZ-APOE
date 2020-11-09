#!/usr/bin/env bash

sed -e 1d ../data/SraRunTable.txt | tail -n +2 | head -1 | while read line
do

SRR=$(echo ${line} | cut -d , -f1)

indir="../output/trimmed/${SRR}"
outdir="../output/bams"
[[ -d ${outdir} ]] || mkdir ${outdir}

echo "SRR: ${SRR}"

#### Run HISAT2
### Indicate strandedness (RF)
### Use 20 cores
### Output any unaligned reads
### Stringtie needs --dta
### Pipe directly to samtools view for quality filtering (-q 15) and
### sorting
call="hisat2 -p 6 --rna-strandness RF \
--dta -x ../../../hisat-indexes/HS2-ens98 \
--summary-file ../output/bams/logs/${SRR}.log \
-1 ${indir}/${SRR}_1.fastq.gz \
-2 ${indir}/${SRR}_2.fastq.gz | \
samtools view -q 15 -Su | samtools sort -m 1G -@ 4 - \
-o ${outdir}/${SRR}.sorted.bam"

echo $call
eval $call

echo "${SRR} done"

done

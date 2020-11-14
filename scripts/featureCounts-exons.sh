#!/usr/bin/env bash

### Set in and out directories
indir="../output/bams"
outdir="../output/counts"
### Get bam files in a variable
bamfiles=$(ls ${indir}/*.bam)
echo ${bamfiles}

###### Run featureCounts
call="featureCounts -f -p -a ../data/Homo_sapiens.GRCh38.98.chr.gtf.gz \
-O -s 2 -o ${outdir}/exon-counts.txt -T 6 ${bamfiles}"

echo $call
eval $call

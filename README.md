# Alzheimer's investigation

Here I am just playing around with some mRNA-Seq data used in a study related to Alzheimer's disease.

### APOE4 expression in cerebral organoids

APOE E4 variant is a major genetic risk allele for Alzheimer's disease.

APOE E3 variant is the most common in caucasian populations.

Here, is an analysis of RNA sequencing data from two lines of cerebral organoids derived from iPSCs. One line is homozygous for the E3 variant and one for the E4 variant.

RNA-seq data were downloaded from GEO, accession GSE117588. Thank you to the authors for making their data available.

Source: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6386196/

### Results

### lncRNAs DE between E3 and E4 cell lines

In the DE analysis, H19 is the most significantly DE gene, and upregulated in E4 cells (log2FC=3.49, FDR=4.71E-248). [H19 is thought to be a pro-inflammatory lncRNA](https://www.frontiersin.org/articles/10.3389/fimmu.2020.579687/full)

PAX8-AS1 is significantly upregulated in E4 cells (log2FC=4.67, FDR=2.29E-59). Reads from PAX-AS1 seem to mostly be from the final exon of the transcript. 

![PAX8-AS1](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/PAX8-AS1-all-2.png) 

They also seem to overlap with two cCREs (candidate cis-regulatory element) in the ENCODE database, determined by high H3K4me3 and H3K27ac marks at these regions. These elements are identified as EH38E2025977 and EH38E2025978. 

![PAX8-AS1 cCREs](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/PAX8-AS1-last-exon-2.png)

![Both cCREs](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/both-ENCODE.png)

However, of cell types in the ENCODE database, H3K27ac marks were most depleted in neural progenitor cells for each cCRE. 

![EH38E2025977 H3K27ac](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/EH38E2025977-H3K27ac.png)

![EH38E2025978 H3K27ac](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/EH38E2025978-H3K27ac.png)

Is it possible these reads represent an activated enhancer element in E4 cells? If so, why are we seeing these reads in polyA-enriched RNA-Seq data?

### Differential gene usage

**Gene-level and exon-level differential expression suggest a switch from PCDHGC3 in E3 cells to PCDHGC4 in E4 cells**

At the gene-level, PCDHGC3 is found to be significantly downregulated in E4 cells (log2FC=-4.46, FDR=3.79E-58), while PCDHGC4 was found to be significantly upregulated in E3 cells (log2FC=1.86, FDR=8.58E-12).

At the exon-level, the exons in the first half of PCDHGC3 were found to be downregulated in E4 cells while the latter half of the gene was not different between the two cell lines. 

![PCDHGC3 exon differential expression](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC3-exonusage.png)

On the other hand, exons in the first half of PCDHGC4 were found to be upregulated in E4 cells, while the latter half of the gene was not different.

![PCDHGC4 exon differential expression](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC4-exonusage.png)

Visualizing the locus containing PCDHGC3 and PCDHGC4 suggests a switch from PCDHGC3 to PCDHGC4 in E4 cells.

![PCDHGC switch](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC3-IGV.png)



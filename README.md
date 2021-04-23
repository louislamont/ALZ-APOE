# Alzheimer's investigation

In this repository, I am just playing around with some rRNA-depleted RNA-Seq data used in a study related to Alzheimer's disease. RNA-seq data were downloaded from GEO, accession GSE117588. Thank you to the authors for making their data available.

Source: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6386196/

### APOE4 expression in cerebral organoids

### Background

The Apolipoprotein E (APOE) E3 variant is the most common variant of the gene in caucasion populations. However, the E4 variant is known to be a major genetic risk allele for Alzheimer's disease.

Here is an analysis of RNA sequencing data from two lines of cerebral organoids derived from iPSCs. One line is homozygous for the E3 variant and one for the E4 variant. Differential expression was performed at the gene-level and the exon-level between the E3 and E4 cell lines.

### Methods

*Data acquisition*

Sequencing files were downloaded from GEO accession GSE117588 using prefetch and fasterq-dump (v 2.10.9) from the SRA toolkit.

*Data processing*

Raw RNA-Seq files were trimmed using cutadapt (v 2.10) with the following flags: `-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -j 8 --trim-n -m 25 -q 20,20`. Trimmed reads were aligned to the Ensembl v98 GRCh38 genome using hisat2 (v 2.2.1) with the following flags: `--rna-strandness RF --dta`. Gene-level counts were determined using featureCounts (v 2.0.1) with flags `-s 2 -p`. Exon-level counts were determined with featureCounts and the flags `-s 2 -p -f -O`. Bam files were also processed into bigwig files for visualization with the bamCoverage function from deepTools (v 3.4.0) using flag `-bs 1`.

*Differential expression*

Counts were read into R (v4.0.4) and differential expression at gene and exon levels was performed using edgeR (v3.32.1). Briefly, low expression genes (genes with expression lower than 10/L, where L is the minimum library size in millions, in at least 3 samples) were removed. Normalization by the TMM method was calculated (`calcNormFactors`) and the two groups were compared with the `exactTest` function. DE genes were defined as those having FDR <= 0.05 and log2(FC)>=1. Exon-level DE was performed similarly, with differentially spliced genes called using the `diffSpliceDGE` function. Scripts for these analyses are available in the scripts/R folder.

*Visualization*

Visualization of expression data was performed in R using tidyverse and ggplot2 packages, as well as IGV as a genome browser.

### Results

### lncRNAs DE between E3 and E4 cell lines

*Broad strokes*

In the DE analysis, H19 is the most significantly DE gene, and upregulated in E4 cells (log2FC=8.49, FDR=4.71E-248). [H19 is thought to be a pro-inflammatory lncRNA](https://www.frontiersin.org/articles/10.3389/fimmu.2020.579687/full). [Other lncRNAs shown to be associated with Alzheimer's](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6262561/) and neuroinflammation are also upregulated in this dataset, including MIAT (log2FC=1.37, FDR=6.57e-08), and NEAT1 (log2FC=1.61, FDR=4.11e-07). Additionally, a small nucleolar host gene (SNHG1) has been [shown to promote neuroinflammation](https://www.tandfonline.com/doi/full/10.1080/15476286.2020.1788848). While this is not upregulated in this dataset, we see differential expression of other SNHG genes, including SNHG18 (log2FC=-1.2, FDR=8.34e-10) and SNHG3 (log2FC=1.14, FDR=3.23e-06), possibly implicating additional members of this class of lncRNAs in the disease process as well.

*More targeted*

PAX8-AS1 is significantly upregulated in E4 cells (log2FC=4.67, FDR=2.29E-59). However, PAX8-AS1 seems to be poorly transcribed, and reads mostly align to the final exon of the transcript.

![PAX8-AS1](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/PAX8-AS1-all-2.png) 

They also seem to overlap with two cCREs (candidate cis-regulatory element) in the ENCODE database, determined by high H3K4me3 and H3K27ac marks at these regions. These elements are identified as EH38E2025977 and EH38E2025978. 

![PAX8-AS1 cCREs](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/PAX8-AS1-last-exon-2.png)

![Both cCREs](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/both-ENCODE.png)

However, of cell types in the ENCODE database, H3K27ac (enhancer) marks were most depleted in neural progenitor cells for each cCRE. 

![EH38E2025977 H3K27ac](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/EH38E2025977-H3K27ac.png)

![EH38E2025978 H3K27ac](https://github.com/louislamont/ALZ-APOE/blob/main/plots/lncRNAs/EH38E2025978-H3K27ac.png)

Given that H3K27ac marks are depleted in neural progenitor cells normally, is it possible these reads represent an enhancer elements that become activated in E4 cells?

### Differential gene usage

**Gene-level and exon-level differential expression suggest a switch from PCDHGC3 in E3 cells to PCDHGC4 in E4 cells**

At the gene-level, PCDHGC3 is found to be significantly downregulated in E4 cells (log2FC=-4.46, FDR=3.79E-58), while PCDHGC4 was found to be significantly upregulated in E4 cells (log2FC=1.86, FDR=8.58E-12).

At the exon-level, the exons in the first half of PCDHGC3 were found to be downregulated in E4 cells while the latter half of the gene was not different between the two cell lines. 

![PCDHGC3 exon differential expression](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC3-exonusage.png)

On the other hand, exons in the first half of PCDHGC4 were found to be upregulated in E4 cells, while the latter half of the gene was not different.

![PCDHGC4 exon differential expression](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC4-exonusage.png)

PCDHGC3 and 4 share their last exons, so the exon-level differential expression data potentially indicates a switch from one PCDHGC3 to 4. More directly, if we look at expression data coming from the locus containing PCDHGC3 and PCDHGC4, we can see a clear difference in the initial exons, while expression looks similar for the latter exons. This suggests a switch from PCDHGC3 to PCDHGC4 expression in E4 cells. [APOE E4, but not E3, was also found to bind to the promoter of PCDHGC4](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4719010/), suggesting the APOE E4 variant is the direct cause of this transcriptional switching.

![PCDHGC switch](https://github.com/louislamont/ALZ-APOE/blob/main/plots/splicing/PCDHGC3-IGV.png)



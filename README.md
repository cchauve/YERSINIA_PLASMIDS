# Plasmids in *Yersinia pestis*

## Overview
Case study of labelled assembly graphs for *Yersinia pestis*. It looks like most *Y. pestis* isolates have the same three plasmids (pCD1, pMT1 and pPCP1), so there might not be much to learn aside of the ability to label the graphs well. One potential issue of interest is the case of multimerization of plasmids.

## Data

### Extant DNA

#### Rapid Detection of Genetic Engineering, Structural Variation, and Antimicrobial Resistance Markers in Bacterial Biothreat Pathogens by Nanopore Sequencing
<a href="https://www.nature.com/articles/s41598-019-49700-1">Paper</a>

This paper has only two samples, a *Y. pestis* and a *Bacillus anthracis*, for which they generated Illumina, PacBio and Oxford Nanopore data. The *Y. pestis* sample is interesting as it has several variants of the pPCP1 plasmid, if I understood well. One interesting issue they deal with is that the pPCP1 plasmid appears in monomer and dimer/trimer/quadrimer (duplicates) forms.  

Raw data: <a href="https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA523610">RJNA523610</a>

#### Molecular Characterization of Multidrug-Resistant Yersinia enterocolitica From Foodborne Outbreaks in Sweden
<a href="https://doi.org/10.3389/fmicb.2021.664665">Paper</a>  

This is not *Y. pestis* but *Y. enterocolitica*. There are five new samples, sequenced using Illumina and Oxford Nanopore. All samples have the same virulence plasmid and one sample has an extra plasmid.  

Raw Illumina data: <a href="https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=702388">PRJEB42815</a>

#### Complete, closed and curated genome sequences of Photobacterium damselae subsp. piscicida isolates from Australia indicate mobilome-driven localized evolution and novel pathogenicity determinants
<a href="https://doi.org/10.1099/mgen.0.000562">Paper</a>  

Again, not *Y. pestis*, but an interesting case of a newly sequenced pathogen, with two chromosomes and a large number of plasmids, and sequenced using Illumina and Oxford Nanopore.  

Raw data: <a href="https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=662633">PRJNA662633</a>. Other related available SRA datasets include <a href="https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=529570">GCA_004683985.1</a>, <a href="https://www.ncbi.nlm.nih.gov/sra?LinkName=biosample_sra&from_uid=7327716">GCA_003026245.1</a>, <a href="https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=529569">GCA_004684005.1</a>.
	



### Ancient DNA

The papers below describe aDAN datasets. None of them was assembled de-novo, but genomes, whenr econstructed, were obtained by mapping to a reference genome. How realistic is-it to embark into pre-processing the raw reads data and assembling the data? Lack of uniform coverage is likely a serious issue.

#### Stone Age Yersinia pestis genomes shed light on the early evolution, diversity, and ecology of plague
<a href="https://doi.org/10.1073/pnas.2116722119">Paper</a>

Seventeen *Y. pestis* genomes from 5,000 to 2,500 y BP from a wide geographic expanse across Eurasia.  

Raw data: <a href="https://www.ebi.ac.uk/ena/browser/view/PRJEB51099">PRJEB51099</a>

#### Analysis of 3800-year-old Yersinia pestis genomes suggests Bronze Age origin for bubonic plague
<a href="https://www.nature.com/articles/s41467-018-04550-9">Paper</a>

Two samples *RT5* and *RT6* sequenced using a combination of deep WGS and capture-based sequencing. Capture-based sequencing uses baits from the following extant molecules: CO92 chromosome (NC_003143.1), CO92 plasmid pMT1 (NC_003134.1), CO92 plasmid pCD1 (NC_003131.1), KIM 10 chromosome (NC_004088.1), Pestoides F chromosome (NC_009381.1) and Y. pseudotuberculosis IP32953 chromosome (NC_006155.1). Both single-end and paired-end reads were sequenced, generally short (76bp). Genomes were reconstructed by mapping to the CO92 strain, not by de-novo assembly.  

Raw data: <a href="https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJEB24296">PRJEB24296</a>; <a href="https://www.ncbi.nlm.nih.gov/sra?LinkName=biosample_sra&from_uid=9556285">sample RT5</a>, <a href="https://www.ncbi.nlm.nih.gov/sra?LinkName=biosample_sra&from_uid=9556286">sample RT6</a>.

#### New ancient Eastern European Yersinia pestis genomes illuminate the dispersal of plague in Europe
<a href="https://doi.org/10.1098/rstb.2019.0569">Paper</a>

Target enrichment with probes specific for the *Y. pestis* chromosome and its three plasmids (pCD1, pMT1 and pPCP1), and subsequent high-throughput sequencing, yielded data sufficient for analysis in four out of five *Y. pestis* positive human samples (Rostov2033, Rostov2039, Azov38 and Gdansk8). The mapping to the *Y. pestis* reference genome (NC 003143.1, NC 003134.1, NC 003131.1, NC 003132.1) revealed 88–96% of genome length coverage for *Y. pestis* chromosome, 67–100% length coverage for the plasmids, and a minimum fourfold to maximum 184-fold mean coverage (9–245-fold for plasmids).  

Raw data: <a href="https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=667376">PRJEB35426</a>.

#### Yersinia pestis genomes reveal plague in Britain 4,000 years ago
<a href="https://doi.org/10.1101/2022.01.26.477195">Paper</a>

Data not available, but clear preprocessing protocole: Samples were processed via the nf-core/eager v2 pipeline. First, adapters were removed, paired-end reads were merged and bases with a quality below 20 were trimmed using AdapterRemoval v2 with –trimns –trimqualities –collapse –minadapteroverlap 1 and –preserve5p. Merged reads with a minimum length of 35bp were mapped to the hs37d5 human reference genome with Burrows-Wheeler Aligner (BWA-0.7.17 aln) using the following parameters “-l 16500 -n 0.01 -o 2 -t 1” 25,26, and unmapped reads were then processed in Kraken2 to detect k-mers matching *Yersinia pestis*.

#### Phylogeography of the second plague pandemic revealed through analysis of historical Yersinia pestis genomes
<a href="https://www.nature.com/articles/s41467-019-12154-0">Paper</a>

Here we analyse human remains from ten European archaeological sites spanning this period and reconstruct 34 ancient *Y. pestis* genomes.
After capture, all products were sequenced on an Illumina NextSeq500 platform or on a HiSeq4000. Preprocessing of de-multiplexed reads was performed on the automated pipeline EAGER (v1.92.55) and involved the removal of Illumina adaptors and read merging using AdapterRemoval v2, as well as filtering all reads for sequencing quality (minimum base quality of 20) and length (to retrieve only reads ≥30 bp). Subsequently, reads were mapped with BWA (version 0.7.12), implemented in EAGER, against the CO92 reference genome (NC_003143.1) using stringent parameters (-n 0.1, -l 32) for genome reconstruction and mean coverage calculation and more lenient parameters (-n 0.01, -l 32) for inspection of regions surrounding potential variants. Reads with mapping quality lower than 37 (-q) were removed using SAMtools.  

Raw data: <a href="https://www.ebi.ac.uk/ena/browser/view/PRJEB29990">PRJEB29990</a>.

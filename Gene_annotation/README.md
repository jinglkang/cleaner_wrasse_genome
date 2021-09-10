Gene_annotation
---------------
## 1. Mapping RNA-seq data to hardmasked genome fasta (Cleaner_wrasse_hardmasked_ChaHeader.fasta)
### a. Build the index of reference genome (~/genome/Gene_annotation/)
```bash
hisat2-build -f Cleaner_wrasse_hardmasked_ChaHeader.fasta Cleaner_wrasse
```
### b. Align RNA-seq to genome (~/genome/Gene_annotation/RNA-seq)
```bash
mkdir RNA-align
perl Hisat2_align_bam.pl
```
***
## 2. ab-initio gene pridiction
### 2.1 Augustus
working directory:  ~/genome/Gene_annotation  
```bash
~/software/Augustus/bin/augustus --species=zebrafish \
--strand=both \
--genemodel=partial \
--gff3=on \
--protein=on \
--codingseq=on \
--outfile=./GenePrediction_Augustus_Cleaner_wrasse.gff3 \
Cleaner_wrasse_hardmasked_ChaHeader.fasta
```
***
# BRAKER
## 1. genome file only
--esmode: In this mode, run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes predicted by GeneMark-ES. Final predictions are ab initio.  
```bash
braker.pl --softmasking --species Labroides_dimidiatus --esmode --cores 20 --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta
```
**Result files:**~/genome/Gene_annotation/braker  
|**File Name**|**File Description**|
|:---:|:---:|
|augustus.ab_initio.gtf|Genes predicted by Augustus in *ab initio* mode in gtf-format (--esmode or --AUGUSTUS_ab_initio)|
|GeneMark-ES/genemark.gtf|Genes predicted by GeneMark-EX predictions|
|braker.gtf|The union of augustus.ab_initio.gtf and genemark.gtf|
***
## 2. Using OrthoDB as basis for protein.fa to predict genes
### prepare the input OrthoDB proteins  
**download Vertebrata proteins**: ~/genome/Gene_annotation  
```bash
mkdir OrthoDB_Vertebrata
cd OrthoDB_Vertebrata
wget https://v100.orthodb.org/download/odb10_vertebrata_fasta.tar.gz
tar xvf odb10_vertebrata_fasta.tar.gz
cat vertebrate/Rawdata/* >proteins.fasta
```
### run BRAKER second time

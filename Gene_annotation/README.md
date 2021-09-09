Gene_annotation
---------------
# BRAKER
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
## 1. genome file only
--esmode: In this mode, run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes predicted by GeneMark-ES. Final predictions are ab initio.  
```bash
braker.pl --softmasking --species Labroides_dimidiatus --esmode --cores 20 --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta
```

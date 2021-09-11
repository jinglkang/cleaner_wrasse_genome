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
for txt in *.txt;do echo -e "$txt\c"; grep 'overall alignment rate' $txt|perl -alne 'print "\t$F[0]"';done >RNA_overall_align_rate.txt
```
**Overall alignment rate**: RNA_overall_align_rate.txt (mean rate: 77.14%)
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
### run BRAKER first time
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
### run BRAKER second time
### prepare the input OrthoDB proteins  
**download Vertebrata proteins**: ~/genome/Gene_annotation  
```bash
mkdir OrthoDB_Vertebrata
cd OrthoDB_Vertebrata
wget https://v100.orthodb.org/download/odb10_vertebrata_fasta.tar.gz
tar xvf odb10_vertebrata_fasta.tar.gz
cat vertebrate/Rawdata/* >proteins.fasta
```
### run BRAKER
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 \
--species Labroides_dimidiatus_2 \
--cores 20 \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta\
--workingdir ./braker_2\
--email jlkang@hku.hk
```
**Result files:** ~/genome/Gene_annotation/braker_2  
***
## 3. Using RNA-seq data to predict genes
### run BRAKER third time
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 \
--UTR=on \
--species Labroides_dimidiatus_3 \
--cores 20 \
--bam=LD10FB.sorted.bam,LD10HB.sorted.bam,LD10MB.sorted.bam,LD11FB.sorted.bam,LD11HB.sorted.bam,LD11MB.sorted.bam,LD12FB.sorted.bam,LD12HB.sorted.bam,LD12MB.sorted.bam,LD13FB.sorted.bam,LD13HB.sorted.bam,LD13MB.sorted.bam,LD14FB.sorted.bam,LD14HB.sorted.bam,LD14MB.sorted.bam,LD15FB.sorted.bam,LD15HB.sorted.bam,LD15MB.sorted.bam,LD16FB.sorted.bam,LD16HB.sorted.bam,LD16MB.sorted.bam,LD17FB.sorted.bam,LD17HB.sorted.bam,LD17MB.sorted.bam,LD18FB.sorted.bam,LD18HB.sorted.bam,LD18MB.sorted.bam,LD19FB.sorted.bam,LD19HB.sorted.bam,LD19MB.sorted.bam,LD1FB.sorted.bam,LD1HB.sorted.bam,LD1MB.sorted.bam,LD20FB.sorted.bam,LD20HB.sorted.bam,LD20MB.sorted.bam,LD21FB.sorted.bam,LD21HB.sorted.bam,LD21MB.sorted.bam,LD22FB.sorted.bam,LD22HB.sorted.bam,LD22MB.sorted.bam,LD23FB.sorted.bam,LD23HB.sorted.bam,LD23MB.sorted.bam,LD24FB.sorted.bam,LD24HB.sorted.bam,LD24MB.sorted.bam,LD25FB.sorted.bam,LD25HB.sorted.bam,LD25MB.sorted.bam,LD26FB.sorted.bam,LD26HB.sorted.bam,LD26MB.sorted.bam,LD27FB.sorted.bam,LD27HB.sorted.bam,LD27MB.sorted.bam,LD28FB.sorted.bam,LD28HB.sorted.bam,LD28MB.sorted.bam,LD29FB.sorted.bam,LD29HB.sorted.bam,LD29MB.sorted.bam,LD2FB.sorted.bam,LD2HB.sorted.bam,LD2MB.sorted.bam,LD30FB.sorted.bam,LD30HB.sorted.bam,LD30MB.sorted.bam,LD3FB.sorted.bam,LD3HB.sorted.bam,LD3MB.sorted.bam,LD4FB.sorted.bam,LD4HB.sorted.bam,LD4MB.sorted.bam,LD5FB.sorted.bam,LD5HB.sorted.bam,LD5MB.sorted.bam,LD6FB.sorted.bam,LD6HB.sorted.bam,LD6MB.sorted.bam,LD7FB.sorted.bam,LD7HB.sorted.bam,LD7MB.sorted.bam,LD8FB.sorted.bam,LD8HB.sorted.bam,LD8MB.sorted.bam,LD9FB.sorted.bam,LD9HB.sorted.bam,LD9MB.sorted.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_3 \
--email jlkang@hku.hk
```

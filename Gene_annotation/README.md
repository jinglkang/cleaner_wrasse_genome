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
--bam=RNA-seq/RNA-align/LD10FB.sorted.bam,RNA-seq/RNA-align/LD10HB.sorted.bam,RNA-seq/RNA-align/LD10MB.sorted.bam,RNA-seq/RNA-align/LD11FB.sorted.bam,RNA-seq/RNA-align/LD11HB.sorted.bam,RNA-seq/RNA-align/LD11MB.sorted.bam,RNA-seq/RNA-align/LD12FB.sorted.bam,RNA-seq/RNA-align/LD12HB.sorted.bam,RNA-seq/RNA-align/LD12MB.sorted.bam,RNA-seq/RNA-align/LD13FB.sorted.bam,RNA-seq/RNA-align/LD13HB.sorted.bam,RNA-seq/RNA-align/LD13MB.sorted.bam,RNA-seq/RNA-align/LD14FB.sorted.bam,RNA-seq/RNA-align/LD14HB.sorted.bam,RNA-seq/RNA-align/LD14MB.sorted.bam,RNA-seq/RNA-align/LD15FB.sorted.bam,RNA-seq/RNA-align/LD15HB.sorted.bam,RNA-seq/RNA-align/LD15MB.sorted.bam,RNA-seq/RNA-align/LD16FB.sorted.bam,RNA-seq/RNA-align/LD16HB.sorted.bam,RNA-seq/RNA-align/LD16MB.sorted.bam,RNA-seq/RNA-align/LD17FB.sorted.bam,RNA-seq/RNA-align/LD17HB.sorted.bam,RNA-seq/RNA-align/LD17MB.sorted.bam,RNA-seq/RNA-align/LD18FB.sorted.bam,RNA-seq/RNA-align/LD18HB.sorted.bam,RNA-seq/RNA-align/LD18MB.sorted.bam,RNA-seq/RNA-align/LD19FB.sorted.bam,RNA-seq/RNA-align/LD19HB.sorted.bam,RNA-seq/RNA-align/LD19MB.sorted.bam,RNA-seq/RNA-align/LD1FB.sorted.bam,RNA-seq/RNA-align/LD1HB.sorted.bam,RNA-seq/RNA-align/LD1MB.sorted.bam,RNA-seq/RNA-align/LD20FB.sorted.bam,RNA-seq/RNA-align/LD20HB.sorted.bam,RNA-seq/RNA-align/LD20MB.sorted.bam,RNA-seq/RNA-align/LD21FB.sorted.bam,RNA-seq/RNA-align/LD21HB.sorted.bam,RNA-seq/RNA-align/LD21MB.sorted.bam,RNA-seq/RNA-align/LD22FB.sorted.bam,RNA-seq/RNA-align/LD22HB.sorted.bam,RNA-seq/RNA-align/LD22MB.sorted.bam,RNA-seq/RNA-align/LD23FB.sorted.bam,RNA-seq/RNA-align/LD23HB.sorted.bam,RNA-seq/RNA-align/LD23MB.sorted.bam,RNA-seq/RNA-align/LD24FB.sorted.bam,RNA-seq/RNA-align/LD24HB.sorted.bam,RNA-seq/RNA-align/LD24MB.sorted.bam,RNA-seq/RNA-align/LD25FB.sorted.bam,RNA-seq/RNA-align/LD25HB.sorted.bam,RNA-seq/RNA-align/LD25MB.sorted.bam,RNA-seq/RNA-align/LD26FB.sorted.bam,RNA-seq/RNA-align/LD26HB.sorted.bam,RNA-seq/RNA-align/LD26MB.sorted.bam,RNA-seq/RNA-align/LD27FB.sorted.bam,RNA-seq/RNA-align/LD27HB.sorted.bam,RNA-seq/RNA-align/LD27MB.sorted.bam,RNA-seq/RNA-align/LD28FB.sorted.bam,RNA-seq/RNA-align/LD28HB.sorted.bam,RNA-seq/RNA-align/LD28MB.sorted.bam,RNA-seq/RNA-align/LD29FB.sorted.bam,RNA-seq/RNA-align/LD29HB.sorted.bam,RNA-seq/RNA-align/LD29MB.sorted.bam,RNA-seq/RNA-align/LD2FB.sorted.bam,RNA-seq/RNA-align/LD2HB.sorted.bam,RNA-seq/RNA-align/LD2MB.sorted.bam,RNA-seq/RNA-align/LD30FB.sorted.bam,RNA-seq/RNA-align/LD30HB.sorted.bam,RNA-seq/RNA-align/LD30MB.sorted.bam,RNA-seq/RNA-align/LD3FB.sorted.bam,RNA-seq/RNA-align/LD3HB.sorted.bam,RNA-seq/RNA-align/LD3MB.sorted.bam,RNA-seq/RNA-align/LD4FB.sorted.bam,RNA-seq/RNA-align/LD4HB.sorted.bam,RNA-seq/RNA-align/LD4MB.sorted.bam,RNA-seq/RNA-align/LD5FB.sorted.bam,RNA-seq/RNA-align/LD5HB.sorted.bam,RNA-seq/RNA-align/LD5MB.sorted.bam,RNA-seq/RNA-align/LD6FB.sorted.bam,RNA-seq/RNA-align/LD6HB.sorted.bam,RNA-seq/RNA-align/LD6MB.sorted.bam,RNA-seq/RNA-align/LD7FB.sorted.bam,RNA-seq/RNA-align/LD7HB.sorted.bam,RNA-seq/RNA-align/LD7MB.sorted.bam,RNA-seq/RNA-align/LD8FB.sorted.bam,RNA-seq/RNA-align/LD8HB.sorted.bam,RNA-seq/RNA-align/LD8MB.sorted.bam,RNA-seq/RNA-align/LD9FB.sorted.bam,RNA-seq/RNA-align/LD9HB.sorted.bam,RNA-seq/RNA-align/LD9MB.sorted.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_3 \
--email jlkang@hku.hk
```
**error in the running of bin2hint2: core dumped** (because i installed Augustus twice time (whole SNORLAX and my own account))
replace "/home/kang1234/software/Augustus/bin/bam2hints" to "usr/bin/bam2hint2"
in "**~/.bashrc**" 
"**export AUGUSTUS_BIN_PATH=/home/kang1234/software/Augustus/bin/**" change to "**export AUGUSTUS_BIN_PATH=/usr/bin**"  

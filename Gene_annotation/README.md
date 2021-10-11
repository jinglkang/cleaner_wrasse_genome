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
### c. estimate the length of scaffolds   
```bash
falen Cleaner_wrasse_softmasked_ChaHeader.fasta | sort -k2,2nr |less
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
**Result**: GenePrediction_Augustus_Cleaner_wrasse.gff3 (27874 genes)    
***
# BRAKER
## 1. genome file only
### run BRAKER first time
--esmode: In this mode, run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes predicted by GeneMark-ES. Final predictions are ab initio.  
```bash
braker.pl --softmasking --species Labroides_dimidiatus --esmode --cores 20 --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta
```
**Result files:**~/genome/Gene_annotation/braker  
```bash
less braker.gtf|perl -alne 'print $F[-1] if $F[2] eq "gene" && $F[1] eq "AUGUSTUS"; if ($F[2] eq "gene" && $F[1] eq "GeneMark.hmm3"){($ge)=$_=~/gene_id\s+\"(.*?)\"/;print $ge}'|sort -u|wc -l
```
|**File Name**|**File Description**|**Gene Nb**|
|:---:|:---:|:---:|
|augustus.ab_initio.gtf|Genes predicted by Augustus in *ab initio* mode in gtf-format (--esmode or --AUGUSTUS_ab_initio)|36730|
|GeneMark-ES/genemark.gtf|Genes predicted by GeneMark-EX predictions|40061|
|braker.gtf|The union of augustus.ab_initio.gtf and genemark.gtf|70575 (AUGUSTUS: 36730; GeneMark.hmm3: 33845)|
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
|**File Name**|**Gene Nub**|
|:---:|:---:|
|augustus.ab_initio.gtf; augustus.ab_initio.aa; augustus.ab_initio.codingseq|38521|
|augustus.hints.aa; augustus.hints.codingseq|39671|
|augustus.hints.gtf; braker.gtf|37023|
|GeneMark-EP/genemark.gtf|39159|
|GeneMark-ES/genemark.gtf|40061|
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
**error1:** in the running of bin2hint2: core dumped 
(because i installed Augustus twice time (whole SNORLAX and my own account))  
replace "/home/kang1234/software/Augustus/bin/bam2hints" to "usr/bin/bam2hint2"  
in "**~/.bashrc**"  
**export AUGUSTUS_BIN_PATH=/home/kang1234/software/Augustus/bin/** change to 
**export AUGUSTUS_BIN_PATH=/usr/bin**
***
**error2** before training AUGUSTUS
change the AUGUSTUS_BIN_PATH to "export AUGUSTUS_BIN_PATH=/home/kang1234/software/Augustus/bin/"  
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 \
--UTR=on \
--species Labroides_dimidiatus_4 \
--cores 20 \
--bam=RNA-seq/RNA-align/LD10FB.sorted.bam,RNA-seq/RNA-align/LD10HB.sorted.bam,RNA-seq/RNA-align/LD10MB.sorted.bam,RNA-seq/RNA-align/LD11FB.sorted.bam,RNA-seq/RNA-align/LD11HB.sorted.bam,RNA-seq/RNA-align/LD11MB.sorted.bam,RNA-seq/RNA-align/LD12FB.sorted.bam,RNA-seq/RNA-align/LD12HB.sorted.bam,RNA-seq/RNA-align/LD12MB.sorted.bam,RNA-seq/RNA-align/LD13FB.sorted.bam,RNA-seq/RNA-align/LD13HB.sorted.bam,RNA-seq/RNA-align/LD13MB.sorted.bam,RNA-seq/RNA-align/LD14FB.sorted.bam,RNA-seq/RNA-align/LD14HB.sorted.bam,RNA-seq/RNA-align/LD14MB.sorted.bam,RNA-seq/RNA-align/LD15FB.sorted.bam,RNA-seq/RNA-align/LD15HB.sorted.bam,RNA-seq/RNA-align/LD15MB.sorted.bam,RNA-seq/RNA-align/LD16FB.sorted.bam,RNA-seq/RNA-align/LD16HB.sorted.bam,RNA-seq/RNA-align/LD16MB.sorted.bam,RNA-seq/RNA-align/LD17FB.sorted.bam,RNA-seq/RNA-align/LD17HB.sorted.bam,RNA-seq/RNA-align/LD17MB.sorted.bam,RNA-seq/RNA-align/LD18FB.sorted.bam,RNA-seq/RNA-align/LD18HB.sorted.bam,RNA-seq/RNA-align/LD18MB.sorted.bam,RNA-seq/RNA-align/LD19FB.sorted.bam,RNA-seq/RNA-align/LD19HB.sorted.bam,RNA-seq/RNA-align/LD19MB.sorted.bam,RNA-seq/RNA-align/LD1FB.sorted.bam,RNA-seq/RNA-align/LD1HB.sorted.bam,RNA-seq/RNA-align/LD1MB.sorted.bam,RNA-seq/RNA-align/LD20FB.sorted.bam,RNA-seq/RNA-align/LD20HB.sorted.bam,RNA-seq/RNA-align/LD20MB.sorted.bam,RNA-seq/RNA-align/LD21FB.sorted.bam,RNA-seq/RNA-align/LD21HB.sorted.bam,RNA-seq/RNA-align/LD21MB.sorted.bam,RNA-seq/RNA-align/LD22FB.sorted.bam,RNA-seq/RNA-align/LD22HB.sorted.bam,RNA-seq/RNA-align/LD22MB.sorted.bam,RNA-seq/RNA-align/LD23FB.sorted.bam,RNA-seq/RNA-align/LD23HB.sorted.bam,RNA-seq/RNA-align/LD23MB.sorted.bam,RNA-seq/RNA-align/LD24FB.sorted.bam,RNA-seq/RNA-align/LD24HB.sorted.bam,RNA-seq/RNA-align/LD24MB.sorted.bam,RNA-seq/RNA-align/LD25FB.sorted.bam,RNA-seq/RNA-align/LD25HB.sorted.bam,RNA-seq/RNA-align/LD25MB.sorted.bam,RNA-seq/RNA-align/LD26FB.sorted.bam,RNA-seq/RNA-align/LD26HB.sorted.bam,RNA-seq/RNA-align/LD26MB.sorted.bam,RNA-seq/RNA-align/LD27FB.sorted.bam,RNA-seq/RNA-align/LD27HB.sorted.bam,RNA-seq/RNA-align/LD27MB.sorted.bam,RNA-seq/RNA-align/LD28FB.sorted.bam,RNA-seq/RNA-align/LD28HB.sorted.bam,RNA-seq/RNA-align/LD28MB.sorted.bam,RNA-seq/RNA-align/LD29FB.sorted.bam,RNA-seq/RNA-align/LD29HB.sorted.bam,RNA-seq/RNA-align/LD29MB.sorted.bam,RNA-seq/RNA-align/LD2FB.sorted.bam,RNA-seq/RNA-align/LD2HB.sorted.bam,RNA-seq/RNA-align/LD2MB.sorted.bam,RNA-seq/RNA-align/LD30FB.sorted.bam,RNA-seq/RNA-align/LD30HB.sorted.bam,RNA-seq/RNA-align/LD30MB.sorted.bam,RNA-seq/RNA-align/LD3FB.sorted.bam,RNA-seq/RNA-align/LD3HB.sorted.bam,RNA-seq/RNA-align/LD3MB.sorted.bam,RNA-seq/RNA-align/LD4FB.sorted.bam,RNA-seq/RNA-align/LD4HB.sorted.bam,RNA-seq/RNA-align/LD4MB.sorted.bam,RNA-seq/RNA-align/LD5FB.sorted.bam,RNA-seq/RNA-align/LD5HB.sorted.bam,RNA-seq/RNA-align/LD5MB.sorted.bam,RNA-seq/RNA-align/LD6FB.sorted.bam,RNA-seq/RNA-align/LD6HB.sorted.bam,RNA-seq/RNA-align/LD6MB.sorted.bam,RNA-seq/RNA-align/LD7FB.sorted.bam,RNA-seq/RNA-align/LD7HB.sorted.bam,RNA-seq/RNA-align/LD7MB.sorted.bam,RNA-seq/RNA-align/LD8FB.sorted.bam,RNA-seq/RNA-align/LD8HB.sorted.bam,RNA-seq/RNA-align/LD8MB.sorted.bam,RNA-seq/RNA-align/LD9FB.sorted.bam,RNA-seq/RNA-align/LD9HB.sorted.bam,RNA-seq/RNA-align/LD9MB.sorted.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_4 \
--email jlkang@hku.hk \
--hints ~/genome/Gene_annotation/braker_3/hintsfile.gff \
--geneMarkGtf ~/genome/Gene_annotation/braker_3/GeneMark-ET/genemark.gtf
```
**How to fix error1 and error2**  
copy the **bam2hint** in "/usr/bin" to "/home/kang1234/software/Augustus/bin/"  
***
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 \
--UTR=on \
--species Labroides_dimidiatus_4 \
--cores 20 \
--bam=RNA-seq/RNA-align/LD10FB.sorted.bam,RNA-seq/RNA-align/LD10HB.sorted.bam,RNA-seq/RNA-align/LD10MB.sorted.bam,RNA-seq/RNA-align/LD11FB.sorted.bam,RNA-seq/RNA-align/LD11HB.sorted.bam,RNA-seq/RNA-align/LD11MB.sorted.bam,RNA-seq/RNA-align/LD12FB.sorted.bam,RNA-seq/RNA-align/LD12HB.sorted.bam,RNA-seq/RNA-align/LD12MB.sorted.bam,RNA-seq/RNA-align/LD13FB.sorted.bam,RNA-seq/RNA-align/LD13HB.sorted.bam,RNA-seq/RNA-align/LD13MB.sorted.bam,RNA-seq/RNA-align/LD14FB.sorted.bam,RNA-seq/RNA-align/LD14HB.sorted.bam,RNA-seq/RNA-align/LD14MB.sorted.bam,RNA-seq/RNA-align/LD15FB.sorted.bam,RNA-seq/RNA-align/LD15HB.sorted.bam,RNA-seq/RNA-align/LD15MB.sorted.bam,RNA-seq/RNA-align/LD16FB.sorted.bam,RNA-seq/RNA-align/LD16HB.sorted.bam,RNA-seq/RNA-align/LD16MB.sorted.bam,RNA-seq/RNA-align/LD17FB.sorted.bam,RNA-seq/RNA-align/LD17HB.sorted.bam,RNA-seq/RNA-align/LD17MB.sorted.bam,RNA-seq/RNA-align/LD18FB.sorted.bam,RNA-seq/RNA-align/LD18HB.sorted.bam,RNA-seq/RNA-align/LD18MB.sorted.bam,RNA-seq/RNA-align/LD19FB.sorted.bam,RNA-seq/RNA-align/LD19HB.sorted.bam,RNA-seq/RNA-align/LD19MB.sorted.bam,RNA-seq/RNA-align/LD1FB.sorted.bam,RNA-seq/RNA-align/LD1HB.sorted.bam,RNA-seq/RNA-align/LD1MB.sorted.bam,RNA-seq/RNA-align/LD20FB.sorted.bam,RNA-seq/RNA-align/LD20HB.sorted.bam,RNA-seq/RNA-align/LD20MB.sorted.bam,RNA-seq/RNA-align/LD21FB.sorted.bam,RNA-seq/RNA-align/LD21HB.sorted.bam,RNA-seq/RNA-align/LD21MB.sorted.bam,RNA-seq/RNA-align/LD22FB.sorted.bam,RNA-seq/RNA-align/LD22HB.sorted.bam,RNA-seq/RNA-align/LD22MB.sorted.bam,RNA-seq/RNA-align/LD23FB.sorted.bam,RNA-seq/RNA-align/LD23HB.sorted.bam,RNA-seq/RNA-align/LD23MB.sorted.bam,RNA-seq/RNA-align/LD24FB.sorted.bam,RNA-seq/RNA-align/LD24HB.sorted.bam,RNA-seq/RNA-align/LD24MB.sorted.bam,RNA-seq/RNA-align/LD25FB.sorted.bam,RNA-seq/RNA-align/LD25HB.sorted.bam,RNA-seq/RNA-align/LD25MB.sorted.bam,RNA-seq/RNA-align/LD26FB.sorted.bam,RNA-seq/RNA-align/LD26HB.sorted.bam,RNA-seq/RNA-align/LD26MB.sorted.bam,RNA-seq/RNA-align/LD27FB.sorted.bam,RNA-seq/RNA-align/LD27HB.sorted.bam,RNA-seq/RNA-align/LD27MB.sorted.bam,RNA-seq/RNA-align/LD28FB.sorted.bam,RNA-seq/RNA-align/LD28HB.sorted.bam,RNA-seq/RNA-align/LD28MB.sorted.bam,RNA-seq/RNA-align/LD29FB.sorted.bam,RNA-seq/RNA-align/LD29HB.sorted.bam,RNA-seq/RNA-align/LD29MB.sorted.bam,RNA-seq/RNA-align/LD2FB.sorted.bam,RNA-seq/RNA-align/LD2HB.sorted.bam,RNA-seq/RNA-align/LD2MB.sorted.bam,RNA-seq/RNA-align/LD30FB.sorted.bam,RNA-seq/RNA-align/LD30HB.sorted.bam,RNA-seq/RNA-align/LD30MB.sorted.bam,RNA-seq/RNA-align/LD3FB.sorted.bam,RNA-seq/RNA-align/LD3HB.sorted.bam,RNA-seq/RNA-align/LD3MB.sorted.bam,RNA-seq/RNA-align/LD4FB.sorted.bam,RNA-seq/RNA-align/LD4HB.sorted.bam,RNA-seq/RNA-align/LD4MB.sorted.bam,RNA-seq/RNA-align/LD5FB.sorted.bam,RNA-seq/RNA-align/LD5HB.sorted.bam,RNA-seq/RNA-align/LD5MB.sorted.bam,RNA-seq/RNA-align/LD6FB.sorted.bam,RNA-seq/RNA-align/LD6HB.sorted.bam,RNA-seq/RNA-align/LD6MB.sorted.bam,RNA-seq/RNA-align/LD7FB.sorted.bam,RNA-seq/RNA-align/LD7HB.sorted.bam,RNA-seq/RNA-align/LD7MB.sorted.bam,RNA-seq/RNA-align/LD8FB.sorted.bam,RNA-seq/RNA-align/LD8HB.sorted.bam,RNA-seq/RNA-align/LD8MB.sorted.bam,RNA-seq/RNA-align/LD9FB.sorted.bam,RNA-seq/RNA-align/LD9HB.sorted.bam,RNA-seq/RNA-align/LD9MB.sorted.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_4 \
--email jlkang@hku.hk
```
**error3**: already finish **PROCESSING HINTS**; **RUNNING GENEMARK-EX**; **TRAIN AUGUSTUS**; **PREDICTING GENES WITH AUGUSTUS (NO UTRS)**    
error in  **TRAINING AUGUSTUS UTR PARAMETERS** (already finish **gushr.py**; **gff2gbSmallDNA.pl**; **bamtools merge**)  
detail error parts occured in **samtools sort**:
[bam_sort_core] merging from 2622 files and 19 in-memory blocks...  
[E::hts_open_format] Failed to open file /home/kang1234/genome/Gene_annotation/braker_4/merged.s.bam.tmp.1020.bam  
samtools sort: fail to open "/home/kang1234/genome/Gene_annotation/braker_4/merged.s.bam.tmp.1020.bam": Too many open files  
**solved**: with -m 2G when run **samtoos sort** 
***
**Run with only two bam files to get the command for the continue of last running in braker_4  
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 \
--UTR=on \
--species Labroides_dimidiatus_5 \
--cores 20 \
--bam=RNA-seq/RNA-align/LD10FB.sorted.bam,RNA-seq/RNA-align/LD10HB.sorted.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_5 \
--verbosity=4 \
--email jlkang@hku.hk
```
**error4**:  
Use of uninitialized value in print at /home/kang1234/software/BRAKER/scripts/braker.pl line 11481.  
ERROR in file /home/kang1234/software/BRAKER/scripts/braker.pl at line 11504  
Failed to execute: /home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/MakeHub/make_hub.py -g /home/kang1234/genome/Gene_annotation/braker_5/genome.fa -e jlkang@hku.hk -l hub_Lab -L Labroides_dimidiatus_5 -X /home/kang1234/genome/Gene_annotation/braker_5 -P  > /home/kang1234/genome/Gene_annotation/braker_5/makehub.log 2> /home/kang1234/genome/Gene_annotation/braker_5/errors/makehub.err  
continue running in the command:  
```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Sep 20 09:08:34 ~/genome/Gene_annotation/braker_5
$/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/MakeHub/make_hub.py -g /home/kang1234/genome/Gene_annotation/braker_5/genome.fa -e jlkang@hku.hk -l hub_Lab -L Labroides_dimidiatus_5 -X /home/kang1234/genome/Gene_annotation/braker_5 -P  > /home/kang1234/genome/Gene_annotation/braker_5/makehub.log 2> /home/kang1234/genome/Gene_annotation/braker_5/errors/makehub.err
# (base) kang1234@celia-PowerEdge-T640 Mon Sep 20 10:25:52 ~/genome/Gene_annotation
$perl clean_up.pl --softmasking --AUGUSTUS_ab_initio --makehub --gff3 --UTR=on --species Labroides_dimidiatus_5 --cores 20 --bam=RNA-seq/RNA-align/LD10FB.sorted.bam,RNA-seq/RNA-align/LD10HB.sorted.bam --workingdir ./braker_5 --verbosity=4 --email jlkang@hku.hk
```
**FINISH**
***
**Continue the running of braker_4**  
**The LAST finished running is**   
"samtools sort": add "-m 2G" in the running command  
```bash
/usr/bin/samtools sort -@ 19 -m 2G -o /home/kang1234/genome/Gene_annotation/braker_4/merged.s.bam /home/kang1234/genome/Gene_annotation/braker_4/merged.bam 1> /home/kang1234/genome/Gene_annotation/braker_4/samtools_sort_before_wig.stdout 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/samtools_sort_before_wig.stderr
```
**GET the command from "braker.log" in "~/genome/Gene_annotation/braker_5" to found what are still needed to continue the running of braker_4:**  
delete the command in running.sh that have already been finished in braker_4, and replace "braker_5" to "braker_4"   
```bash
less braker.log |perl -alne 'print unless /^#\s+.*2021.*/' >running.sh
```
***
## Too many errors, running again with merged bam file in braker_4
if you have many bam files, it's better to merge them before running BRAKER  
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--UTR=on \
--species Labroides_dimidiatus_6 \
--cores 20 \
--bam=braker_4/merged.s.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_6
```
***
error again in the step of 'samtools sort'; add '-m 2G' in 'samtools sort' of gushr.py
run again based on the hint gtf file and genemark gtf file in braker_6  
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--UTR=on \
--hints braker_6/hintsfile.gff \
--geneMarkGtf braker_6/GeneMark-ET/genemark.gtf \
--species Labroides_dimidiatus_7 \
--cores 20 \
--bam=braker_4/merged.s.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_7
```
***
error again, once more in "samtools sort"; change this in the source codes of braker.pl  
and "rm braker_3 braker_4 braker_6 braker_7"  
and run again!!!!!!!!
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--UTR=on \
--species Labroides_dimidiatus_3 \
--cores 20 \
--bam=merged.bam \
--genome=Cleaner_wrasse_softmasked_ChaHeader.fasta \
--workingdir ./braker_3
```
**Finished (~/genome/Gene_annotation/braker_3)
```bash
less braker.gtf|perl -alne '($na)=$_=~/gene_id\s\"(.*)?\"\;/ if /gene_id/;print $na if /gene_id/'|sort -u|wc -l
less braker_utr.gtf|perl -alne '($na)=$_=~/gene_id\s\"(.*)?\"\;/ if /gene_id/;print $na if /gene_id/'|sort -u|wc -l
```
|**File Name**|**Gene Nub**|
|:---:|:---:|
|braker.gtf|61565 genes|
|braker_utr.gtf|126576 genes|
|augustus.ab_initio.gtf|38761 genes|
|augustus.ab_initio_utr.gtf|21678 genes|
***
## 4. Combine the results in braker_2 and braker_3 with TSEBRA (the transcript select for braker)
### 4.1 maker sure that the gene and transcript IDs of the gene prediction files in order
#### ~/genome/Gene_annotation/braker_2    
```bash
fix_gtf_ids.py --gtf braker.gtf --out braker_2_fixed.gtf
```
#### ~/genome/Gene_annotation/braker_3
```bash
fix_gtf_ids.py --gtf braker.gtf --out braker_3_fixed.gtf
```
### 4.2 combine predictions with TSEBRA
working dir: ~/genome/Gene_annotation     
```bash
tsebra.py -g braker_2/braker_2_fixed.gtf,braker_3/braker_3_fixed.gtf \ 
-c ~/software/TSEBRA/config/default.cfg \
-e braker_2/hintsfile.gff,braker_3/hintsfile.gff \
-o braker2+3_combined.gtf
```
### 4.3 renaming the transcripts from the TSEBRA
working dir: ~/genome/Gene_annotation       
```bash
rename_gtf.py --gtf braker2+3_combined.gtf --prefix Ldim --out braker2+3_combined_renamed.gtf
```
### 4.4 move the combined and renamed gtf file to new dir (~/genome/Gene_annotation/combined)
```bash
mkdir combined
mv braker2+3_combined.gtf braker2+3_combined_renamed.gtf combined/
```
**protein sequences of each transcript (30440 transcripts, 28138 genes)**        
```bash
gffread -y braker2+3_combined_renamed.aa.fa -g ../Cleaner_wrasse_softmasked_ChaHeader.fasta braker2+3_combined_renamed.gtf
```
**extract the longest transcript per gene**     
```bash
perl extract_long_transcript.pl >braker2+3_combined_renamed.aa.long.fa
```
**blast to the swiss-prot database (blastp)**
remove dot (.) in the end of the sequences   
```bash
less braker2+3_combined_renamed.aa.long.fa|perl -alne 's/\.//;print' >braker2+3_combined_renamed.aa.long.new.fa
mv braker2+3_combined_renamed.aa.long.new.fa  braker2+3_combined_renamed.aa.long.fa
nohup blastp -query braker2+3_combined_renamed.aa.long.fa \
-db ~/swiss-prot/uniprot-filtered-reviewed_yes.fasta \
-outfmt 6 -num_threads 20 -evalue 1e-5 \
-out Ldim_blastp.result.txt > blastp.process 2>&1 &
```
**output format**:   
|**Query Seq-id**|**subject seq-id**|**percent identity**|**alignment length**|**number of mismatches**|**number of gap openings**|**query start**|**query end**|**subject start**|**subject end**|**Expect value**|**HSP bit score**|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Ldim_g1.t1|      sp\|P30626\|SORCN_HUMAN   |65.487  |113     |39      |0       |1       |113     |86      |198     |6.08e-51        |162|
|Ldim_g1.t1|      sp\|Q5R4U9\|SORCN_PONAB   |65.487  |113     |39      |0       |1       |113     |86      |198     |6.08e-51        |162|
|Ldim_g1.t1|      sp\|P05044\|SORCN_CRIGR   |63.717  |113     |41      |0       |1       |113     |86      |198     |4.07e-50        |160|
|Ldim_g1.t1|      sp\|Q6P069\|SORCN_MOUSE   |63.717  |113     |41      |0       |1       |113     |86      |198     |6.50e-50        |159|


**extract the best hit of each query**   
21674 genes have blast hits (blastp result: Ldim_blastp.result.txt)    
21666 genes have the best blast hit with percentage of identical matches > 20%    
```bash
perl extract_best_blastp.pl >Ldim_blastp.result.best.txt
```
**blast to the refseq database (blastp)**  
the results from Du Kang: ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.aa.long.fa.symbol   
download the protein of vertebrate_other (2021-09-12), and build blast database (protein) and diamond database      
```bash
nohup wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/vertebrate_other/*protein.faa.gz &
zcat *gz >vertebrate_other.fa
makeblastdb -in vertebrate_other.fa -dbtype prot -input_type fasta
diamond makedb --in vertebrate_other.fa -d vertebrate_other
diamond makedb --in uniprot-filtered-reviewed_yes.fasta -d uniprot-filtered-reviewed_yes.fasta
```
vertebrate_other.fa: 10,418,909 proteins   
**diamond map**   
```bash
nohup diamond blastp -q braker2+3_combined_renamed.aa.long.fa \
-e 1e-5 --sensitive -k 1 -d ~/refseq_vert_other/vertebrate_other \
--out Ldim_refseq_diamond.result.txt  > diamond.blastp.process 2>&1 &
```
**install REST::Client (perl)**  
```bash
sudo mkdir -p /home/kang1234/.cpanm
sudo touch /home/kang1234/.bash_history
sudo chown -R kang1234: /home/kang1234/
sudo cpanm REST::Client
```
**extract the swiss-prot info: Uniprot Accession; gene name; length**    
```bash
# ~/swiss-prot
perl extract_swiss_pro_info.pl >swiss_pro_info.txt
```
**extract the refseq info: Ref Accession; gene name; length**   
```bash
# ~/refseq_vert_other
perl extract_refseq_pro_info.pl >ref_pro_info.txt
```
**extract the blastp results; gene symbol; gene name**    
**qcov:** ((query end)-(query start)+1)/(query length)     
**scov:** ((subject end)-(subject start)+1)/(subject length)    
**identity**
**qlength:** query length   
**slength:** subject length 
```bash
# ~/genome/Gene_annotation/combined
perl assemble_blastp_result.pl >braker2+3_combined_renamed.aa.long.anno.txt
less braker2+3_combined_renamed.aa.long.anno.txt|perl -alne '($acc)=$_=~/db_accession="(.*?)"\;/; print $acc if /swiss-prot/' >swiss-prot_acc.txt
less braker2+3_combined_renamed.aa.long.anno.txt|perl -alne '($acc)=$_=~/db_accession="(.*?)"\;/; print $acc if /refseq/' >ref_acc.txt
bioDBNet_db2db.pl UniprotAccession genesymbol swiss-prot_acc.txt > swiss-prot_acc_symbol.txt
bioDBNet_db2db.pl RefSeqProteinAccession genesymbol ref_acc.txt > ref_acc_symbol.txt
# add gene symbol
perl add_gene_symbol.pl > braker2+3_combined_renamed.aa.long.anno.final.txt
```
**The final gene annotation file:** braker2+3_combined_renamed.aa.long.anno.final.txt    
### 4.5 annotate using swiss-prot and refseq (assemble all above step to a perl script)
annotate --fasta braker2+3_combined_renamed.aa.long.fa    
***
## 5. Mitochondrial genome assembly (MITObim)   
**From Du Kang**   
```bash
mkdir mito; cd mito
reformat.sh in1=../clean.1.fq.gz in2=../clean.2.fq.gz out=input.fastq samplerate=0.1    # sample 一部分reads即可
MITObim.pl -start 1 -end 30 -sample run -ref mito -readpool input.fastq --quick $mt
file=`ls */run-mito-it*`
perl -i -lape 's/>.*/>MT/' $file
mv $file ../mt.fa
cd ../
rm -rf mito
```
Install MITObim docker image (~/software)    
*Notolabrus celidotus* mitochondrial genome (Notolabrus_celidotus_mito.fa) as assemble reference   
```bash
docker pull chrishah/mitobim
# ~/genome
WORKING_DIR=/home/kang1234/genome
sudo docker run -i -t -v $WORKING_DIR/:/home/data chrishah/mitobim /bin/bash
cd data  # the files are in ~/data/ of the docker image
# ~/software
git clone https://github.com/BioInfoTools/BBMap.git
# sample reads
~/software/bbmap/reformat.sh in1=DTG-OmniC-105_R1_001.fastq.gz in2=DTG-OmniC-105_R2_001.fastq.gz out=input.fastq samplerate=0.1
# docker
MITObim.pl -start 1 -end 30 -sample run -ref mito -readpool input.fastq -quick Labridae_genome/Notolabrus_celidotus_mito.fa --platform pacbio
```
**restart**   
because DTG-OmniC-105_R1_001.fastq.gz and DTG-OmniC-105_R2_001.fastq.gz are not pacbio data (They are Ominic data)    
change to use XDOVE_20210610_S64049_PL100183019-1_D01.ccs.fastq.gz
working dir: ~/genome/mito_genome
```bash
MITObim.pl -start 1 -end 30 -sample run -ref mito -readpool ../XDOVE_20210610_S64049_PL100183019-1_D01.ccs.fastq.gz -quick ../Labridae_genome/Notolabrus_celidotus_mito.fa --platform pacbio
```
**RUN error**   
**Use the original method: DO not add --platform pacbio; and use DTG-OmniC-105_R1_001.fastq.gz and DTG-OmniC-105_R2_001.fastq.gz**   
working dir: ~/genome/mito_genome
```bash
~/software/bbmap/reformat.sh in1=../DTG-OmniC-105_R1_001.fastq.gz in2=../DTG-OmniC-105_R2_001.fastq.gz out=input.fastq samplerate=0.1
MITObim.pl -start 1 -end 30 -sample run -ref mito -readpool input.fastq -quick ../Labridae_genome/Notolabrus_celidotus_mito.fa
```
MITObim has reached a stationary read number after 30 iterations!!      
Final assembly result will be written to file: /home/data/mito_genome/iteration30/run-mito-it30_noIUPAC.fasta     
contig length: 17140      
if you found MITObim useful, please cite:    
Hahn C, Bachmann L and Chevreux B. (2013) Reconstructing mitochondrial genomes directly from genomic next-generation sequencing reads -
a baiting and iterative mapping approach. Nucl. Acids Res. 41(13):e129. doi: 10.1093/nar/gkt371   
***
### Check mito-genome location in genome
#### genome as reference
working dir: ~/genome/Gene_annotation
```bash
makeblastdb -in Cleaner_wrasse_hardmasked_ChaHeader.fasta -dbtype nucl -input_type fasta
# working dir: ~/genome/mito_genome
nohup blastn -query Ldim-mito.fasta -db ~/genome/Gene_annotation/Cleaner_wrasse_hardmasked_ChaHeader.fasta -outfmt 6 -num_threads 20 -out Ldim-mito-genome_blastn.result -max_target_seqs 1  > blastn-1.process 2>&1 &
```
#### mito-genome as reference
working dir: ~/genome/mito_genome    
```bash
makeblastdb -in Ldim-mito.fasta -dbtype nucl -input_type fasta
nohup blastn -query ~/genome/Gene_annotation/Cleaner_wrasse_hardmasked_ChaHeader.fasta -db Ldim-mito.fasta -outfmt 6 -num_threads 20 -out Ldim-genome-mito_blastn.result -max_target_seqs 1  > blastn-2.process 2>&1 &
```
#### Result
all mito-genome (length: 17140) were mapped to Scx22uW_26 (length: 23658)          
but Scx22uW_26 did not get annotated by BRAKER    
sort according to query start    
```bash
less Ldim-mito-genome_blastn.result|sort -k7,7n
```
Check the scaffolds without annotated    
working dir: ~/genome/Gene_annotation/combined   
```bash
falen ../Cleaner_wrasse_hardmasked_ChaHeader.fasta|sort -k2,2nr >scaffold_length.txt
cut -f 1 braker2+3_combined.gtf|sort -u >scaffold_annotate.txt
perl temp3.pl >scaffold_annotate_info.txt
```
temp3.pl  
```perl
#!/usr/bin/perl
use strict;
use warnings;

my (%hash1, %hash2);
open FIL1, "scaffold_length.txt";
while (<FIL1>) {
	chomp;
	my @a=split;
	$hash1{$a[0]}=$a[1];
}

open FIL2, "scaffold_annotate.txt";
while (<FIL2>) {
	chomp;
	$hash2{$_}=$_;
}

foreach my $key (sort {$hash1{$b} <=> $hash1{$a}} keys %hash1) {
	if ($hash2{$key}) {
		print "$key\t$hash1{$key}\tAnnotated\n";
	} else {
		print "$key\t$hash1{$key}\tNon-annotated\n";	
	}
}
```
Result: ~/genome/Gene_annotation/combined/scaffold_annotate_info.txt, **16 scaffold did not get annotated**      

## 6. BUSCO on predicted protein sequeces
working dir (my own workstation): /media/HDD/cleaner_fish_genome    
```bash
nohup python ~/software/Busco/scripts/run_BUSCO.py -m prot -i braker2+3_combined_renamed.aa.long.fa -o Ldim -l ~/software/Busco/lineage/actinopterygii_odb9 -c 20 -t Ldim-tmp >Busco_Ldim.process 2>&1 &
```
***
## 7. Annotate non-coding RNAs
Use the method in Ensembl (http://asia.ensembl.org/info/genome/genebuild/ncrna.html)   
working dir: ~/genome/ncRNA   
### 7.1 tRANs: tRNAscan
#### search for mitochondrial tRNAs: based on the mitochondrial assembly
```bash
tRNAscan-SE -M vert -o mito_tRNA.txt -f mito_tRNA_sec_str.txt -m mito_tRNA_summary.txt ../mito_genome/Ldim-mito.fasta
```
**Results** (22 tRNAs): mito_tRNA.txt; mito_tRNA_sec_str.txt; mito_tRNA_summary.txt    
#### based on whole genome assembly
```bash
tRNAscan-SE -E -o whole_genome_tRNA.txt -f whole_genome_tRNA_sec_str.txt -m whole_genome_tRNA_summary.txt ../Gene_annotation/Cleaner_wrasse_softmasked.fasta
```
**Results** (2859 tRNAs): whole_genome_tRNA.txt; whole_genome_tRNA_sec_str.txt; whole_genome_tRNA_summary.txt     
***
### 7.2 ribosomal RNAs: RNAmmer
```bash
rnammer -S euk -m tsu,lsu,ssu -f ../Gene_annotation/Cleaner_wrasse_softmasked.fasta >ribosomal_RNA.txt
```
***
### 7.3 the rest of the ncRNAs: using infernal and Rfam

***

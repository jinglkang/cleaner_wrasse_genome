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


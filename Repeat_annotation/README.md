Repeat_Annotation
-----------------
use the docker: https://github.com/Dfam-consortium/TETools  
## RepeatModeler
### 1. create a database for RepeatModeler  
### 2. Run RepeatModeler  
```bash
./dfam-tetools.sh 
BuildDatabase -name Cleaner_wrasse jordan-the2300-mb-hirise-ht8d1__08-26-2021__hic_output.fasta
nohup RepeatModeler -database Cleaner_wrasse -pa 20 -LTRStruct >& RepeatModeler.run.out &
```
**RepeatModeler output:**  
RM_16.WedSep11334412021/  #  Temporary files   
After the successful completion of run, two files are generated:  
Cleaner_wrasse-families.fa   # consensus sequences  of  Elements (TEs) familes  
Cleaner_wrasse-families.stk # Seed alignment
***
### 3. Run RepeatMasker 
#### 3.1 Hard mask: replace a repeat to an "N" 
```bash
RepeatMasker -lib Cleaner_wrasse-families.fa -pa 20 jordan-the2300-mb-hirise-ht8d1__08-26-2021__hic_output.fasta
```
results: ~/genome/Repeat_annotation/Cleaner_wrasse_hardmasked.fasta    
#### 3.2 Soft mask: -lcambig
Outputs ambiguous DNA transposon fragments using a lower case name. All other repeats are listed in upper case. Ambiguous fragments  match multiple repeat elements and can only be called based on flanking repeat information.  
```
RepeatMasker -lib Cleaner_wrasse-families.fa -pa 20 -xsmall jordan-the2300-mb-hirise-ht8d1__08-26-2021__hic_output.fasta
```
result: ~/genome/Repeat_annotation/Cleaner_wrasse_softmasked.fasta  
#### 3.3 The other output
The annotation file: Cleaner_wrasse_masked.fasta.out  
The summary file: Cleaner_wrasse_masked.fasta.tbl  
#### 3.4 convert RepeatMasker output to gff3 format
```bash
rmOutToGFF3.pl Cleaner_wrasse_masked.fasta.out >Cleaner_wrasse_masked.fasta.out.gff3
```

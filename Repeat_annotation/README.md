Repeat_Annotation
-----------------
use the docker: https://github.com/Dfam-consortium/TETools  
## RepeatModeler
1. create a database for RepeatModeler  
2. Run RepeatModeler  
```bash
./dfam-tetools.sh 
BuildDatabase -name Cleaner_wrasse jordan-the2300-mb-hirise-ht8d1__08-26-2021__hic_output.fasta
nohup RepeatModeler -database Cleaner_wrasse -pa 20 -LTRStruct >& RepeatModeler.run.out &
```
3. Run RepeatMasker  
```bash
RepeatMasker -lib Cleaner_wrasse-families.fa jordan-the2300-mb-hirise-ht8d1__08-26-2021__hic_output.fasta
```
# Olfactory receptors or other gene family
## 1. Olfactory receptors
## 2. Other gene family
### 2.2 Crystallin
```bash
# Kang@fishlab3 Tue Jun 21 10:16:56 /media/HDD/cleaner_fish/genome/Crystallin_detection_2
./Gmfm_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader_final.fasta --species Cleaner_wrasse --keyword Crystallin --query /media/HDD/cleaner_fish/genome/Crystallin_detection_2/Crystallin_query.fasta --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
## 3. Cadherin gene family
### 3.1 Type I classical cadherins   
```bash
# Kang@fishlab3 Mon Jul 04 16:04:53 ~/Desktop/Annotation_database/swiss-prot
less CDH_type1.id
# P12830
# P19022
# P22223
# P55283
# P55291
# Kang@fishlab3 Fri Jul 01 16:01:33 /media/HDD/cleaner_fish/genome/Cadherin_type1
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CDH_type1.id --keyword Cadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Cadherin_detection/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 1340
```
### 3.2 Type II classical cadherins   
```bash
# Kang@fishlab3 Mon Jul 04 16:07:14 /media/HDD/cleaner_fish/genome
mkdir Cadherin_type2
# Kang@fishlab3 Mon Jul 04 16:11:36 /media/HDD/cleaner_fish/genome/Cadherin_type2
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CDH_type2.id --keyword Cadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Cadherin_type2/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [2] 5605
find . -name "*_final_gmfm"|perl -alne 'system("wc -l $_")'
``` 
### 3.3 7D cadherins   
```bash
# Kang@fishlab3 Mon Jul 04 16:49:24 /media/HDD/cleaner_fish/genome/Cadherin_7D
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CDH_7D.id --keyword Cadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Cadherin_7D/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [2] 1728
```
### 3.4 Desmosomal cadherins   
```bash
# Kang@fishlab3 Tue Jul 05 09:58:00 /media/HDD/cleaner_fish/genome/Cadherin_Desmo
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CDH_Desmo.id --keyword Desmo --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
cp ../Cadherin_7D/run_Gmfm_detect.pl* ./
# Kang@fishlab3 Tue Jul 05 09:59:24 /media/HDD/cleaner_fish/genome/Cadherin_Desmo
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Cadherin_Desmo/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 18731
```
### 3.5 Protocadherin alpha cluster
```bash
# Kang@fishlab3 Tue Jul 05 10:40:13 /media/HDD/cleaner_fish/genome/Protocadherin_alpha
cp ../Cadherin_7D/run_Gmfm_detect.pl* ./
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Protocadherin_alpha.id --keyword Protocadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Protocadherin_alpha/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 14004
```
### 3.6 protocadherin beta cluster   
```bash
# Kang@fishlab3 Tue Jul 05 11:31:36 /media/HDD/cleaner_fish/genome/Protocadherin_beta
cp ../Cadherin_7D/run_Gmfm_detect.pl* ./
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Protocadherin_beta.id --keyword Protocadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Protocadherin_beta/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 12028
```
### 3.7 protocadherin gamma cluster
```bash
# Kang@fishlab3 Tue Jul 05 13:12:48 /media/HDD/cleaner_fish/genome/Protocadherin_gamma
cp ../Cadherin_7D/run_Gmfm_detect.pl* ./
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Protocadherin_gamma.id --keyword Protocadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Protocadherin_gamma/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 11192
```
### 3.8 Non-clustered protocadherins   
```bash
# Kang@fishlab3 Tue Jul 05 14:42:47 /media/HDD/cleaner_fish/genome/Protocadherin_non
cp ../Cadherin_7D/run_Gmfm_detect.pl* ./
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Protocadherin_non.id --keyword Protocadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Protocadherin_non/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
# [1] 10110
find . -name "*_final_gmfm"|perl -alne 'my $info=$_;open FIL, $_;my $i;while(<FIL>){chomp;@a=split;$i++ if $a[-1]>=0.7};close FIL;print "$i $info"'
```
## Cadherin once again (use **Fmdetect**)  



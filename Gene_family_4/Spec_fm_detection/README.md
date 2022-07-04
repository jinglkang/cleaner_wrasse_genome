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

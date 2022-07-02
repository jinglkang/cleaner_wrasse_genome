# Olfactory receptors or other gene family
## 1. Olfactory receptors
## 2. Other gene family
### 2.2 Crystallin
```bash
# Kang@fishlab3 Tue Jun 21 10:16:56 /media/HDD/cleaner_fish/genome/Crystallin_detection_2
./Gmfm_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader_final.fasta --species Cleaner_wrasse --keyword Crystallin --query /media/HDD/cleaner_fish/genome/Crystallin_detection_2/Crystallin_query.fasta --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
## 3. Cadherin gene family
### 3.3 Type I classical cadherins   
```bash
# Kang@fishlab3 Fri Jul 01 16:01:33 /media/HDD/cleaner_fish/genome/Cadherin_detection
./Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CDH_type1.id --keyword Cadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Gmfm_detect.pl /media/HDD/cleaner_fish/genome/Cadherin_detection/query_protein.fasta >run_Gmfm_detect.process 2>&1 &
```

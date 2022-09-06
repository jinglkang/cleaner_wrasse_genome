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
### Cadherin_7D
```bash
# Check the length
# Kang@fishlab3 Tue Aug 23 16:19:07 /media/HDD/cleaner_fish/genome/Cadherin_7D
less query_protein.fasta|perl -alne 'next if />/;$a=length($_);print "$a"'|sort -n # 827*0.7=579
# 827
# 827
# 829
# 829
# 830
# 832
```

```print_run_Fmdetect.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
	'Cheilinus_undulatus'  =>  'Cund',
	'Fugu'  =>  'Fugu',
	'Labroides_dimidiatus' =>  'Ldim',
	'Labrus_bergylta'  =>  'Lber',
	'Medaka'  =>  'Medaka',
	'Notolabrus_celidotus' =>  'Ncel',
	'Platyfish'  =>  'Platyfish',
	'Semicossyphus_pulcher' =>  'Spul',
	'Spottedgar'  =>  'Spottedgar',
	'Stickleback' =>  'Stickleback',
	'Symphodus_melops' =>  'Smel',
	'Tautogolabrus_adspersus'=> 'Tads',
	'Thalassoma_bifasciatum' => 'Tbif',
	'Zebrafish'  =>  'Zebrafish'
	);

my @species=qw(Cheilinus_undulatus Fugu Labroides_dimidiatus Labrus_bergylta Medaka Notolabrus_celidotus Platyfish Semicossyphus_pulcher Spottedgar Stickleback Symphodus_melops Tautogolabrus_adspersus Thalassoma_bifasciatum Zebrafish);
my $swiss="~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta";
my $query=$ARGV[0]; # /media/HDD/cleaner_fish/genome/Protocadherin_gamma/query_protein.fasta
my $len=$ARGV[1]; # 579
foreach my $spe (sort keys %species) {
    my $dir  ="/media/HDD/cleaner_fish/genome/All_genomes";
    my $short=$species{$spe};
    my $fasta="$spe.fasta";
    my $genom="$dir/$fasta";
    my $pep  ="$dir/longest_pep/$fasta";
    print("Fmdetect --genome $genom --species $spe --query $query --len $len --uniprot $swiss --shortnm $short\n");
}
```

```bash
# Kang@fishlab3 Tue Aug 23 16:56:37 /media/HDD/cleaner_fish/genome/Cadherin_7D
perl print_run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Cadherin_7D/query_protein.fasta 413 # 827*0.5=413
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Cadherin_7D/query_protein.fasta 413 >run_Fmdetect.process 2>&1 &
# [3] 2736
```
### Cadherin_Desmo
```bash
# Kang@fishlab3 Tue Aug 23 17:16:20 /media/HDD/cleaner_fish/genome/Cadherin_Desmo
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # length=863*0.5=431
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Cadherin_Desmo/query_protein.fasta 431 >run_Fmdetect.process 2>&1 &
# [1] 1921
find . -name '3_phy.bla'|perl -alne 'my $info=$_;open FIL, $_;my $i;while(<FIL>){chomp;@a=split;$i++};close FIL;($i>0)?($i=$i):($i=0);print "$i $info"'
# 0 ./Labrus_bergylta/filtering/3_phy.bla
# 0 ./Semicossyphus_pulcher/filtering/3_phy.bla
# 0 ./Medaka/filtering/3_phy.bla
# 0 ./Fugu/filtering/3_phy.bla
# 0 ./Notolabrus_celidotus/filtering/3_phy.bla
# 0 ./Platyfish/filtering/3_phy.bla
# 0 ./Thalassoma_bifasciatum/filtering/3_phy.bla
# 0 ./Symphodus_melops/filtering/3_phy.bla
# 0 ./Labroides_dimidiatus/filtering/3_phy.bla
# 0 ./Cheilinus_undulatus/filtering/3_phy.bla
```
### Protocadherin_gamma
```bash
# Kang@fishlab3 Tue Aug 23 17:37:26 /media/HDD/cleaner_fish/genome/Protocadherin_gamma
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # length 461 (50%)
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Protocadherin_gamma/query_protein.fasta 461 >run_Fmdetect.process 2>&1 &
# [2] 2197
```
### Protocadherin_beta
```bash
# Kang@fishlab3 Tue Aug 23 19:36:59 /media/HDD/cleaner_fish/genome/Protocadherin_beta
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # 772*0.5=386
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Protocadherin_beta/query_protein.fasta 386 >run_Fmdetect.process 2>&1 &
# [2] 2096
```
### Protocadherin_alpha
```bash
# Kang@fishlab3 Tue Aug 23 19:58:03 /media/HDD/cleaner_fish/genome/Protocadherin_alpha
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # 655
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Protocadherin_alpha/query_protein.fasta 655 >run_Fmdetect.process 2>&1 &
# [2] 21279
```
### Protocadherin_non
```bash
# Kang@fishlab3 Tue Aug 23 21:44:48 /media/HDD/cleaner_fish/genome/Protocadherin_non
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # 950*0.7=655
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Protocadherin_non/query_protein.fasta 655 >run_Fmdetect.process 2>&1 &
# [1] 6187
```
### Cadherin_type2
```bash
# Kang@fishlab3 Tue Aug 23 21:51:10 /media/HDD/cleaner_fish/genome/Cadherin_type2
cp ../Cadherin_7D/*run_Fmdetect.pl ./
less query_protein.fasta|perl -alne 'next if />/;$a=length($_);print "$a"'|sort -n|head # 772*0.7=540
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Cadherin_type2/query_protein.fasta 540 >run_Fmdetect.process 2>&1 &
# [2] 6824
```
### Cadherin_type1
```bash
# Kang@fishlab3 Tue Aug 23 21:56:47 /media/HDD/cleaner_fish/genome/Cadherin_type1
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # 102
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Cadherin_type1/query_protein.fasta 102 >run_Fmdetect.process 2>&1 &
# [3] 8674
```
### CELSR_Cadherins
```bash
# Kang@fishlab3 Wed Aug 24 08:21:53 ~/Desktop/Annotation_database/swiss-prot
vi CELSR_Cadherins.id
# Kang@fishlab3 Wed Aug 24 10:52:24 /media/HDD/cleaner_fish/genome/CELSR_Cadherins
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/CELSR_Cadherins.id --keyword Cadherin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
cp ../Cadherin_7D/*run_Fmdetect.pl ./ # set length as 1072 (50%), intron gap 10000, filter (50%)
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/CELSR_Cadherins/query_protein.fasta 1072 >run_Fmdetect.process 2>&1 &
# [1] 31845
```
## Immunolobulin heavy
```bash
# Kang@fishlab3 Fri Aug 26 13:29:42 /media/HDD/cleaner_fish/genome/Immu_heavy
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Immu_heavy.id --keyword Desmo --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
cp ../Cadherin_7D/*run_Fmdetect.pl ./
# cCc 10000
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Immu_heavy/query_protein.fasta 58 >run_Fmdetect.process 2>&1 &
# [1] 20232
```
## Immunoglobulin kappa
```bash
# Kang@fishlab3 Sat Aug 27 11:33:24 /media/HDD/cleaner_fish/genome
mkdir Immu_kappa
# Kang@fishlab3 Sat Aug 27 11:37:14 /media/HDD/cleaner_fish/genome/Immu_kappa
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Immu_kappa.id --keyword Immunoglobulin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Immu_kappa/query_protein.fasta 59 >run_Fmdetect.process 2>&1 &
```
## Immunoglobulin lambda
```bash
# Kang@fishlab3 Sat Aug 27 12:14:40 /media/HDD/cleaner_fish/genome
mkdir Immu_lambda
# Kang@fishlab3 Sat Aug 27 12:18:43 /media/HDD/cleaner_fish/genome/Immu_lambda
Create_query --ide ~/Desktop/Annotation_database/swiss-prot/Immu_lambda.id --keyword Immunoglobulin --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
cp ../Cadherin_7D/*run_Fmdetect.pl ./
nohup perl run_Fmdetect.pl /media/HDD/cleaner_fish/genome/Immu_lambda/query_protein.fasta 59 >run_Fmdetect.process 2>&1 &
```
## use IgDetective to detect Immunolobulin heavy
```bash
python run_iterative_igdetective.py /media/HDD/cleaner_fish/genome/All_genomes/Labroides_dimidiatus.fasta ./Igv_Ldim
python run_iterative_igdetective.py /media/HDD/cleaner_fish/genome/All_genomes/Labrus_bergylta.fasta ./Igv_Lber
```

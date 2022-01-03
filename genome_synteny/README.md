# Genome synteny with Zebrafish
Zebrafish genome gtf downloaded from Ensembl (my workstation: /media/HDD/cleaner_fish/genome/synteny/Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf)         
## Get the bed file of Cleaner wrasses
SNORALAX: ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.gtf      
```bash
less braker2+3_combined_renamed.gtf|perl -alne 'if ($F[2] eq "gene"){$F[0]=~s/Scx22uW_/LD/;($F[4]>$F[3])?(print "$F[0]\t$F[3]\t$F[4]\t$F[-1]"):(print "$F[0]\t$F[4]\t$F[3]\t$F[-1]")} ' >Ldim.bed
```
my workstation: /media/HDD/cleaner_fish/genome/synteny       
Longest_Zebrafish_pep.fasta as the database, and Longest_Labroides_dimidiatus_pep.fasta as query            
```bash
cp ../OR_detection/Zebrafish_genome.ncbi.fa ./
cp ../gene_family/Longest_Labroides_dimidiatus_pep.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/combined/Ldim.bed ./
mv /media/HDD/cleaner_fish/genome/OR_detection/Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf ./
less Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf|grep -v '^#'|perl -alne 'if ($F[2] eq "gene"){my $chr="DR$F[0]";(my $gene)=$_=~/gene_id\s+\"(.*?)\"/;$F[0]=~s/Scx22uW_/LD/;($F[4]>$F[3])?(print "$chr\t$F[3]\t$F[4]\t$gene"):(print "$chr\t$F[4]\t$F[3]\t$gene")}' >Zebrafish.bed
cp ../gene_family/Longest_Zebrafish_pep.fasta ./
diamond makedb --in Longest_Zebrafish_pep.fasta -d Zebrafish_pep
diamond blastp -q Longest_Labroides_dimidiatus_pep.fasta --sensitive -k 5 -d Zebrafish_pep -e 1e-10 --out Ldim_Zebra.blast
```
***
## Circos
install perl module     
```bash
sudo cpanm Math::Bezier Regexp::Common Math::Round Math::VecStat Set::IntSpan Text::Format Statistics::Basic
```
***
***
# Orthofinder
```bash
# Kang@fishlab3 Sat Jan 01 13:25:40 /media/HDD/cleaner_fish/genome/gene_family_2
mkdir longest_pep; cd longest_pep
# Kang@fishlab3 Sat Jan 01 14:05:34 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep
cp ../Longest_*_pep.fasta ./;mv Longest_Spotted_gar_pep.fasta Longest_Spottedgar_pep.fasta;mv Longest_Japanese_Medaka_pep.fasta Longest_Medaka_pep.fasta
# change the fasta file name and add the species name in the header of sequences
perl Change_name.pl; rm Change_name.pl
cd ../
# Kang@fishlab3 Sat Jan 01 14:06:00 /media/HDD/cleaner_fish/genome/gene_family_2
nohup orthofinder -f longest_pep -a 32 >Orthofinder.process 2>&1 &
# [1] 14786
```
***
# Genome synteny with Stickleback
select the orthogroups including genes in at least six species   
```bash
# Kang@fishlab3 Sun Jan 02 16:20:32 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/Orthogroups
perl orth_select.pl --spe Stickleback Ldim --nb 6 >Stickleback_Ldim_orthogroup.txt
cp Stickleback_Ldim_orthogroup.txt /media/HDD/cleaner_fish/genome/synteny
# Kang@fishlab3 Sun Jan 02 16:27:13 /media/HDD/cleaner_fish/genome/synteny
scp kang1234@147.8.76.155:~/genome/Gene_annotation/combined/Ldim_gene_location.txt ./
# kangjingliang@kangjingliangdeMacBook-Pro 日  1 02 16:30:43 ~/Downloads
scp Stickleback_gene_chr.txt Kang@147.8.76.231:/media/HDD/cleaner_fish/genome/synteny
```
## Create the karyotype file to plot the gene synteny between Ldim and Stickleback
### Extract the info of longest pep in Ldim and Stickleback
Cleaner related fish: $ARGV\[1\]=0; Other: $ARGV\[1\]=1   
```bash
# jlkang@hpc2021 Sun Jan 02 19:19:32 ~/orthologous_detection
perl Extract_longest_pep_info.pl Labroides_dimidiatus_all_pep.fa 0 >Ldim_longest_pep_info.txt
perl Extract_longest_pep_info.pl Stickleback_all_pep.fa 1 >Stickleback_longest_pep_info.txt
# Kang@fishlab3 Sun Jan 02 19:22:48 /media/HDD/cleaner_fish/genome/synteny
scp jlkang@hpc2021-io1.hku.hk:~/orthologous_detection/*_longest_pep_info.txt ./
# result file: Stickleback_Ldim_synteny.txt
perl Create_Stickleback_Ldim_synteny.pl
```

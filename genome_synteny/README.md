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
wc -l Stickleback_Ldim_synteny.txt # 11847 links
less Stickleback_Ldim_synteny.txt|perl -alne 'print if /group/ && /chr/' > Stickleback_Ldim_synteny_chr.txt # 10850 link (in chr of Stickleback and Ldim)
```
## Circos plot
```bash
# Kang@fishlab3 Tue Jan 04 14:56:12 ~/Desktop/circos_test
mkdir Link; cd Link
# Kang@fishlab3 Tue Jan 04 14:59:07 ~/Desktop/circos_test/Link
mkdir data etc; cd etc
# copy from http://www.circos.ca/documentation/tutorials/links/basic_links/configuration
# Kang@fishlab3 Tue Jan 04 15:02:19 ~/Desktop/circos_test/Link/etc
vi circos.conf; vi bands.conf; vi ideogram.conf; vi ideogram.conf
vi ideogram.position.conf; vi ticks.conf
# create karyotype file of Ldim and Stickleback (in the same karyotype file)
# Kang@fishlab3 Tue Jan 04 15:37:47 /media/HDD/cleaner_fish/genome/OR_detection
falen Gasterosteus_aculeatus.BROADS1.dna_sm.toplevel.fa|perl -alne '$i++;$name="Stickleback".$i;print "chr - $name $F[0] 0 $F[1] $F[0]" if /group/i' >Stickleback_karyotype.txt
cp Stickleback_karyotype.txt /media/HDD/cleaner_fish/genome/synteny

# karyotype file: chr - ID LABEL START END COLOR
# (base) kang1234@celia-PowerEdge-T640 Tue Jan 04 15:41:58 ~/genome/Gene_annotation
falen Cleaner_wrasse_softmasked_ChaHeader_final.fasta|sort -k2,2nr |perl -alne '$i++;$name="Ldim".$i;print "chr - $name $F[0] 0 $F[1] $F[0]" if /chr/i' >Ldim_karyotype.txt
# Kang@fishlab3 Tue Jan 04 15:43:40 /media/HDD/cleaner_fish/genome/synteny
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Ldim_karyotype.txt ./
cat Stickleback_karyotype.txt Ldim_karyotype.txt >total_Stickleback_Ldim_karyotype.txt
# Kang@fishlab3 Tue Jan 04 15:48:55 /media/HDD/cleaner_fish/genome/synteny
cat Stickleback_karyotype.txt Ldim_karyotype.txt >~/Desktop/circos_test/Link/data/total_Stickleback_Ldim_karyotype.txt
```

vi temp1.pl   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my %hash;
open FIL1, "total_Stickleback_Ldim_karyotype.txt";
while (<FIL1>) {
	chomp; my @a=split;
	$hash{$a[3]}=$a[2];
}

open FIL2, "Stickleback_Ldim_synteny_chr.txt";
while (<FIL2>) {
	chomp;
	my @a=split;
	my $i=$hash{$a[0]}; my $j=$hash{$a[3]};
	print "$i $a[1] $a[2] $j $a[4] $a[5]\n";
}
```
vi circos.conf (\~/Desktop/circos_test/Link/etc)   
```bash
# karyotype   = data/total_Stickleback_Ldim_karyotype.txt
# Kang@fishlab3 Tue Jan 04 15:58:52 ~/Desktop/circos_test/Link/data
less total_Stickleback_Ldim_karyotype.txt|perl -alne '$i.=$F[2].";";END{$i=~s/\;$//;print $i}' # add the print
less total_Stickleback_Ldim_karyotype.txt|perl -alne 's/group//g;print' >total_Stickleback_Ldim_karyotype.txt.1
mv total_Stickleback_Ldim_karyotype.txt.1 total_Stickleback_Ldim_karyotype.txt
# chromosomes       = Stickleback1;Stickleback2;Stickleback3;Stickleback4;Stickleback5;Stickleback6;Stickleback7;Stickleback8;Stickleback9;Stickleback10;Stickleback11;Stickleback12;Stickleback13;Stickleback14;Stickleback15;Stickleback16;Stickleback17;Stickleback18;Stickleback19;Stickleback20;Stickleback21;Ldim1;Ldim2;Ldim3;Ldim4;Ldim5;Ldim6;Ldim7;Ldim8;Ldim9;Ldim10;Ldim11;Ldim12;Ldim13;Ldim14;Ldim15;Ldim16;Ldim17;Ldim18;Ldim19;Ldim20;Ldim21;Ldim22;Ldim23;Ldim24
# Kang@fishlab3 Tue Jan 04 16:07:07 ~/Desktop/circos_test/Link/data
cp /media/HDD/cleaner_fish/genome/synteny/Stickleback_Ldim_synteny_chr.txt ./
perl temp1.pl >segdup.txt
# add color in segdup.txt to make the color same with chromosome
# Kang@fishlab3 Tue Jan 04 19:56:57 ~/Desktop/circos_test/Link/data
less segdup.txt |perl -alne '(my $i)=$F[3]=~/Ldim(\d+)/;$n="color=chr".$i;print "$_ $n"' >segdup.txt.1
# file          = data/segdup.txt.1
# record_limit  = 200000
```

vi ideogram.label.conf   
```bash
# remove: label_format     = eval(sprintf("chr%s",var(label)))
```

vi etc/ideogram.position.conf (chromosome width)  
```bash
# thickness        = 30p
```

## RUN Circos
```bash
# Kang@fishlab3 Tue Jan 04 16:21:51 ~/Desktop/circos_test/Link
circos
```

## Gene density by Circos
### Create the input for heatmap in Circos
```bash
# (base) kang1234@celia-PowerEdge-T640 Wed Jan 05 13:38:38 ~/genome/Gene_annotation/combined
perl gene_density.pl >Ldim_gene_density.txt
# Kang@fishlab3 Wed Jan 05 13:40:30 ~/Desktop/circos_test
mkdir Heatmap; cd Heatmap
# Kang@fishlab3 Wed Jan 05 13:41:01 ~/Desktop/circos_test/Heatmap
mkdir data etc
# Kang@fishlab3 Wed Jan 05 13:42:40 ~/Desktop/circos_test/Heatmap/data
scp kang1234@147.8.76.155:~/genome/Gene_annotation/combined/Ldim_gene_density.txt ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/karyotype.Ldim.txt ./
```

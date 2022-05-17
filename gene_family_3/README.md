## Detect gene family based on orthofinder   
```bash
# Kang@fishlab3 Sun May 08 20:31:46 /media/HDD/cleaner_fish/genome
mkdir gene_family_3; cd gene_family_3;
```
### Blastp the protein sequences of all species with high-quality genome to swiss-prot
```bash
# Kang@fishlab3 Sun May 08 23:01:35 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep
cat Zebrafish.fasta Stickleback.fasta Spottedgar.fasta Platyfish.fasta Medaka.fasta Fugu.fasta >ref.fasta
scp ref.fasta kang1234@147.8.76.177:~/genome/Gene_annotation/
# (base) kang1234@celia-PowerEdge-T640 Sun May 08 23:07:29 ~/genome/Gene_annotation
nohup diamond blastp -q ref.fasta -e 1e-5 --sensitive -k 1 -d /home/kang1234/swiss-prot/uniprot-filtered-reviewed_yes.fasta --out swis-blastp.result >ref.process 2>&1 &
# [1] 24222
```
**uniq the blastp result**   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my $blast="swis-blastp.result";
my ($gene, $score); 
my @genes;
my (%bla, %nb);
open BLAST, $blast or die "can not open $blast\n";
while (<BLAST>) {
	chomp;
	my @a=split /\t/;
	my ($gene, $score)=($a[0], $a[-1]);
	$nb{$gene}++;
	push @genes, $gene if $nb{$gene}==1;
	if ($bla{$gene}) {
		my $old_score=$bla{$gene}->{'score'};
		my $new_score=$score;
		if ($old_score < $new_score) {
			$bla{$gene}={
				'info' => $_,
				'score' => $score
			};
		}
	} else {
		$bla{$gene}={
			'info' => $_,
			'score' => $score
		};
	}
}

foreach my $gene (@genes) {
	my $info=$bla{$gene}->{'info'};
	print "$info\n";
}
```

```bash
# (base) kang1234@celia-PowerEdge-T640 Sun May 08 23:33:12 ~/genome/Gene_annotation
perl temp1.pl >ref-swis-blastp.uniq.result
```
### all wrasse annotation
```bash
# (base) kang1234@celia-PowerEdge-T640 Sun May 08 23:42:29 ~/genome/Gene_annotation
cat combined/braker2+3_combined_renamed.aa.long.anno.final.txt \
Cheilinus_undulatus/Cheilinus_undulatus.pep.all.1.conca.long.fasta.ano.final \
Labrus_bergylta/Labrus_bergylta.pep.all.1.conca.long.fasta.ano.final \
Notolabrus_celidotus/Notolabrus_celidotus.pep.all.1.conca.long.fasta.ano.final \
Semicossyphus_pulcher/Semicossyphus_pulcher.pep.all.1.conca.long.fasta.ano.final \
Symphodus_melops/Symphodus_melops.pep.all.1.conca.long.fasta.ano.final \
Tautogolabrus_adspersus/Tautogolabrus_adspersus.pep.all.1.conca.long.fasta.ano.final \
Thalassoma_bifasciatum/Thalassoma_bifasciatum.pep.all.1.conca.long.fasta.ano.final > Total_wrasse.ano.final

# (base) kang1234@celia-PowerEdge-T640 Sun May 08 22:46:45 ~/genome/Gene_annotation
grep '>' /home/kang1234/swiss-prot/uniprot-filtered-reviewed_yes.fasta|perl -alne '@a=split /\|/,$F[0];($nm)=$a[2]=~/(.*)\_/;($des)=$_=~/\s+(.*)\s+OS\=/;print "$a[1]\t$a[2]\t$nm\t$des"' > uniprot-filtered-reviewed_yes.name.txt
```
### swiss-prot annotation result for all species
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my $swis="uniprot-filtered-reviewed_yes.name.txt";
my %swiss;
open SWIS, $swis or die "can not open $swis\n";
while (<SWIS>) {
	chomp;
	my @a=split /\t/;
	$swiss{$a[0]}=$_;
}

my $blast="ref-swis-blastp.uniq.result";
open BLAST, $blast or die "can not open $blast\n";
while (<BLAST>) {
	chomp;
	my @a=split /\t/;
	(my $entry)=$a[1]=~/\|(.*)\|/;
	print "$a[0]\t$swiss{$entry}\n";
}

my $ano="Total_wrasse.ano.final";
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
	chomp;
	my @a=split /\t/;
	if (/swiss-prot/) {
		(my $entry)=$a[1]=~/db_accession\=\"(.*?)\"\;/;
		print "$a[0]\t$swiss{$entry}\n";
	}
}
```

```bash
# (base) kang1234@celia-PowerEdge-T640 Mon May 09 00:03:59 ~/genome/Gene_annotation
perl temp2.pl >all_species_swiss_ano.txt
# Kang@fishlab3 Mon May 09 00:09:36 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep
scp kang1234@147.8.76.177:~/genome/Gene_annotation/all_species_swiss_ano.txt ./
```
### Remove genes that have shorter than 30 amino acids or have early stop codons in the coding regions
**filter_genes.pl**   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my $ano="/media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/all_species_swiss_ano.txt";
my %anno;
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
	chomp;
	my @a=split /\t/;
	$anno{$a[0]}=$_;
}


my @fas=</media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/*.fasta>;
foreach my $fas (@fas) {
	my ($fasta)=basename($fas);
	open FASTA, $fas or die "can not open $fas\n";
	my %seq; my $gene; my @genes;
	while (<FASTA>) {
		chomp;
		if (/>/) {
			s/>//;
			$gene=$_;
			push @genes, $gene;
		} else {
			$seq{$gene}.=$_;
		}
	}
	close FASTA;

	open FILE, ">$fasta" or die "can not create $fasta\n";
	foreach my $gene (@genes) {
		my $len=length($seq{$gene});
		if ($len>=30 && $seq{$gene} !~ /\*\S/ && $anno{$gene}) {
			print FILE ">$gene\n$seq{$gene}\n";
		}
	}
	close FILE;
}
```
```bash
# Kang@fishlab3 Sun May 08 20:48:31 /media/HDD/cleaner_fish/genome/gene_family_3
perl filter_genes.pl
# Kang@fishlab3 Mon May 09 00:36:43 /media/HDD/cleaner_fish/genome
nohup orthofinder -f gene_family_3 -a 32 >Orthofinder.process 2>&1 &
#[1] 23935
```
***   
### divid the orthogroups into small orthogroups (**will not use this result**)   
```bash
# Kang@fishlab3 Mon May 09 14:41:17 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09
conda activate possvm
export DISPLAY=:0.0
# (possvm) Kang@fishlab3 Mon May 09 15:00:38 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09
nohup perl build_sub_orth.pl > build_sub_orth.process 2>&1 &
# [1] 14800
```
***   
## two methods to detect the gene family  
### 1. keep the genes in each gene family with the same gene family
```bash
# Kang@fishlab3 Tue May 10 11:11:01 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
perl build_fm_same_name.pl >fm_same_name.txt # divid the orthogroup into gene family
perl count_nb_fm_same_name1.pl >fm_same_name_nb_ano.txt
perl count_nb_fm_same_name2.pl >fm_same_name_nb.txt
python clade_and_size_filter.py -i fm_same_name_nb.txt -o fm_same_name_nb_filtered.txt -s
# contract the phylogenetic tree based on one copy single genes; 2720 single copy genes
# Kang@fishlab3 Tue May 10 13:24:42 /media/HDD/cleaner_fish/genome/gene_family_3
cat *.fasta >all.fasta
perl fm_same_name_single_copy.pl # put single copy genes into "fm_same_name_single_copy/" and align
perl concatenate_single_copy.pl fm_same_name_single_copy >fm_same_name_single_copy_concatenated.fasta
fasta2phy.pl fm_same_name_single_copy_concatenated.fasta >fm_same_name_single_copy_concatenated.phy
# scp to SNORLAX for the phylogenetic tree
# Kang@fishlab3 Tue May 10 14:36:31 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
scp fm_same_name_single_copy_concatenated.phy kang1234@147.8.76.177:~/genome/gene_family
nohup raxmlHPC -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 1000 -s fm_same_name_single_copy_concatenated.phy -o Spottedgar -n fm_same_name_single_copy_concatenated > raxml.process 2>&1 &
#[1] 15930
```
### 2. No care about gene families including genes with different name
**2.1 Resulted Orthogroups as the gene family**   
```bash
# Kang@fishlab3 Tue May 10 11:20:23 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
perl build_fm_no_care1.pl >fm_no_care_nb_ano.txt

# keep the gene name that showed with maximum times in the gene family
less fm_no_care_nb_ano.txt|perl -alne 'my @F=split /\t/;my $info;for ($i=0;$i<=15;$i++){$info.=$F[$i]."\t";}$info=~s/\s+$//;if (/^Family_id/){print"$info\t$F[-2]\tgene_description\t$F[-1]"}else{my @a=split /\;/, $F[-2];my ($nb, $name, $dec); ($nb, $name, $dec)=$a[-1]=~/(\d+)\:\s(.*)\s\((.*)\)/;print "$info\t$name\t$dec\t$F[-1]"}' >fm_no_care_nb_ano_max_name.txt

perl build_fm_no_care2.pl >fm_no_care_nb.txt
python clade_and_size_filter.py -i fm_no_care_nb.txt -o fm_no_care_nb_filtered.txt -s
# keep the conserved gene family
# conserved gene families must exist in Zebrafish and at least four out of the five remaining species in the 6ref-species
less fm_no_care_nb_filtered.txt|perl -alne 'if (/Desc/){print}else{my $j;for ($i=3;$i<=7;$i++){$j++ if $F[$i]>0};print if $F[2]>0 && $j>=4}' >fm_no_care_nb_filtered_conserved.txt # 13862 conserved gene families
```
**2.2 Estimate the F-index of the 13862 conserved gene families**  
```bash
perl estimate_F-index.pl >all_spe_F_index_plot.txt
perl change_nm_F_index.pl >all_spe_F_index_plot_wrasse.txt
```
**2.3 Build the phylogenetic tree**   
```bash
perl fm_no_care_single_copy.pl # put single copy genes into "fm_no_care_single_copy/" and align
perl concatenate_single_copy.pl fm_no_care_single_copy > fm_no_care_single_copy_concatenated.fasta
fasta2phy.pl fm_no_care_single_copy_concatenated.fasta > fm_no_care_single_copy_concatenated.phy
# scp to HPC for the phylogenetic tree
# Kang@fishlab3 Tue May 10 15:26:28 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
scp fm_no_care_single_copy_concatenated.phy jlkang@hpc2021-io1.hku.hk:~/
# scp to SNORLAX for the phylogenetic tree
scp fm_no_care_single_copy_concatenated.phy kang1234@147.8.76.177:~/genome/gene_family
nohup raxmlHPC -T 22 -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 1000 -s fm_no_care_single_copy_concatenated.phy -o Spottedgar -n fm_no_care_single_copy_concatenated > raxml.process 2>&1 &
# [1] 8707
```
**2.3 Estimate the calibrated tree**   
```bash
# set the calibration point: D. rerio - G. aculeatus (149.85-165.2 Mya), get the mid point as the calibration point (156.53)
# Kang@fishlab3 Fri May 13 21:47:39 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
scp kang1234@147.8.76.177:~/genome/gene_family/RAxML_bestTree.fm_no_care_single_copy_concatenated ./
python cafetutorial_prep_r8s.py -i RAxML_bestTree.fm_no_care_single_copy_concatenated -o r8s_ctl_file.txt -s 638853 -p 'Zebrafish,Stickleback' -c '156.53'
r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt
tail -n 1 r8s_tmp.txt | cut -c 16- > r8s_ultrametric.txt
# r8s_ultrametric.txt
# ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000)ishack:94.757281,Spottedgar:251.287281);
```
**2.4 Run CAFE**   
fm_no_care_nb_filtered_conserved.txt as the input   
```bash
# Kang@fishlab3 Fri May 13 22:02:08 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
scp fm_no_care_nb_filtered_conserved.txt kang1234@147.8.76.177:~/genome/gene_family
```
**2.4.1 run CAFE first time**   
**run1_gf3.sh**   
```bash
#! cafe
load -i fm_no_care_nb_filtered_conserved.txt -t 20 -l reports_gf3/log_run1.txt -p 0.01 -r 10000
tree ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000):94.757281,Spottedgar:251.287281)
lambda -s -t ((((((((((1,1)1,1)1,1)1,((1,1)1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_gf3/report_run1
```

```bash
chmod +x run1_gf3.sh
mkdir reports_gf3
cafe run1_gf3.sh
python2 report_analysis.py -i reports_gf3/report_run1.cafe -o reports_gf3/summary_run1
# Plot the result: Rapid, Expansions, Contractions
python2 draw_tree.py -i reports_gf3/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run1_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports_gf3/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run1_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports_gf3/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run1_tree_Contractions.png -y Contractions
```
**2.4.2 run CAFE second time**   
Setting λ (0.00127716209291) to a previously estimated value to deal with families with large numbers of gene copies   
λ: 0.00127716   
**run2_gf3.sh**   
```bash
#! cafe
load -i fm_no_care_nb_filtered_conserved.txt -t 20 -l reports_gf3/log_run2.txt -p 0.01 -r 10000
tree ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000):94.757281,Spottedgar:251.287281)
lambda -l 0.00127716 -t ((((((((((1,1)1,1)1,1)1,((1,1)1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_gf3/report_run2
```

```bash
chmod +x run2_gf3.sh
cafe run2_gf3.sh
python2 report_analysis.py -i reports_gf3/report_run2.cafe -o reports_gf3/summary_run2
# Plot the result: Rapid, Expansions, Contractions
python2 draw_tree.py -i reports_gf3/summary_run2_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run2_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports_gf3/summary_run2_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run2_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports_gf3/summary_run2_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_gf3/summary_run2_tree_Contractions.png -y Contractions
```
***



**Run on HKU HPC (two slow: quit)**   
```bash(script.cmd)
#!/bin/bash
#SBATCH --job-name=raxmlHPC        # 1. Job name
#SBATCH --mail-type=BEGIN,END,FAIL    # 2. Send email upon events (Options: NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jlkang@hku.hk     #    Email address to receive notification
#SBATCH --partition=amd               # 3. Request a partition
#SBATCH --qos=normal                  # 4. Request a QoS
#SBATCH --nodes=1                     #    Request number of node(s)
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-10:00:00             # 7. Job execution duration limit day-hour:min:sec
#SBATCH --output=%x_%j.out            # 8. Standard output log as $job_name_$job_id.out
#SBATCH --error=%x_%j.err             #    Standard error log as $job_name_$job_id.err

# print the start time
date
module load raxml
raxmlHPC -T 64 -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 1000 -s fm_no_care_single_copy_concatenated.phy -o Spottedgar -n fm_no_care_single_copy_concatenated
# print the end time
date
```

```bash
# jlkang@hpc2021 Tue May 10 15:32:38 ~
sbatch script.cmd
# Submitted batch job 379793
```

***   
## Divergence time estimation
Get the cds sequences of longest transcript per gene for each species   
```bash
# Tautogolabrus_adspersus
# (base) kang1234@celia-PowerEdge-T640 Tue May 10 16:12:45 ~/genome/Gene_annotation/Tautogolabrus_adspersus
gffread -x Tautogolabrus_adspersus.cds.all.fasta -g ../Tautogolabrus_adspersus_softmasked_ChaHeader.fasta braker_renamed.gtf
perl ../Cheilinus_undulatus/change_fasta_header.pl Tautogolabrus_adspersus.cds.all.fasta >Tautogolabrus_adspersus_cds.fasta

# Semicossyphus_pulcher
# (base) kang1234@celia-PowerEdge-T640 Tue May 10 16:17:31 ~/genome/Gene_annotation/Semicossyphus_pulcher
gffread -x Semicossyphus_pulcher.cds.all.fasta -g ../Semicossyphus_pulcher_softmasked_ChaHeader.fasta braker_renamed.gtf
perl ../Cheilinus_undulatus/change_fasta_header.pl Semicossyphus_pulcher.cds.all.fasta >Semicossyphus_pulcher_cds.fasta

# Kang@fishlab3 Tue May 10 16:20:19 /media/HDD/cleaner_fish/genome/gene_family_3
mkdir longest_cds; cd longest_cds
# Kang@fishlab3 Tue May 10 16:21:41 /media/HDD/cleaner_fish/genome/gene_family_3/longest_cds
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Tautogolabrus_adspersus/Tautogolabrus_adspersus_cds.fasta ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/Ensemble_longest_pep.pl ./
perl Ensemble_longest_pep.pl --fasta *.fasta
rm Semicossyphus_pulcher_cds.fasta Tautogolabrus_adspersus_cds.fasta
cp /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/Longest_*_cds.fasta ./
# longest cds sequences per gene per species in "/media/HDD/cleaner_fish/genome/gene_family_3/longest_cds"
```

***   
## Positive selection for single copy genes
### 1. prepare nucleotide sequences of cds
```bash
# Kang@fishlab3 Tue May 17 08:23:19 /media/HDD/cleaner_fish/genome/gene_family_3/longest_cds

# Zebrafish
less Longest_Zebrafish_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Zebrafish_$_";print ">$name"}else{print}' >Longest_Zebrafish_cds.fasta.1
mv Longest_Zebrafish_cds.fasta.1 Longest_Zebrafish_cds.fasta

# Medaka
less Longest_Medaka_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Medaka_$_";print ">$name"}else{print}' >Longest_Medaka_cds.fasta.1
mv Longest_Medaka_cds.fasta.1 Longest_Medaka_cds.fasta

# Fugu
less Longest_Fugu_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Fugu_$_";print ">$name"}else{print}' >Longest_Fugu_cds.fasta.1
mv Longest_Fugu_cds.fasta.1 Longest_Fugu_cds.fasta

# Platyfish
less Longest_Platyfish_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Platyfish_$_";print ">$name"}else{print}' >Longest_Platyfish_cds.fasta.1
mv Longest_Platyfish_cds.fasta.1 Longest_Platyfish_cds.fasta

# Spottedgar
less Longest_Spottedgar_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Spottedgar_$_";print ">$name"}else{print}' >Longest_Spottedgar_cds.fasta.1
mv Longest_Spottedgar_cds.fasta.1 Longest_Spottedgar_cds.fasta

# Stickleback
less Longest_Stickleback_cds.fasta|perl -alne 'if (/>/){s/>//;$name="Stickleback_$_";print ">$name"}else{print}' >Longest_Stickleback_cds.fasta.1
mv Longest_Stickleback_cds.fasta.1 Longest_Stickleback_cds.fasta
```
**mkdir a new dir to run paml**   
```bash
# Kang@fishlab3 Tue May 17 08:33:21 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09
cd paml_input
# Kang@fishlab3 Tue May 17 08:33:25 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/paml_input
cp /media/HDD/cleaner_fish/genome/gene_family_3/longest_cds/Longest_*_cds.fasta ./
cp /media/HDD/cleaner_fish/genome/gene_family_3/*.fasta ./
vi correlation.txt
# Zebrafish	Zebrafish.fasta	Longest_Zebrafish_cds.fasta
# Stickleback	Stickleback.fasta	Longest_Stickleback_cds.fasta
# Spottedgar	Spottedgar.fasta	Longest_Spottedgar_cds.fasta
# Platyfish	Platyfish.fasta	Longest_Platyfish_cds.fasta
# Medaka	Medaka.fasta	Longest_Medaka_cds.fasta
# Fugu	Fugu.fasta	Longest_Fugu_cds.fasta
# Cund	Cheilinus_undulatus.fasta	Longest_Cheilinus_undulatus_cds.fasta
# Lber	Labrus_bergylta.fasta	Longest_Labrus_bergylta_cds.fasta
# Ncel	Notolabrus_celidotus.fasta	Longest_Notolabrus_celidotus_cds.fasta
# Smel	Symphodus_melops.fasta	Longest_Symphodus_melops_cds.fasta
# Tads	Tautogolabrus_adspersus.fasta	Longest_Tautogolabrus_adspersus_cds.fasta
# Spul	Semicossyphus_pulcher.fasta	Longest_Semicossyphus_pulcher_cds.fasta
# Tbif	Thalassoma_bifasciatum.fasta	Longest_Thalassoma_bifasciatum_cds.fasta
# Ldim	Labroides_dimidiatus.fasta	Longest_Labroides_dimidiatus_cds.fasta
```
**get the single copy genes list**   
```bash
# Kang@fishlab3 Tue May 17 09:13:13 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
vi temp2.pl
```
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my @spe=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Tads Spul Tbif Ldim);
my $fm="fm_no_care_nb_ano_max_name_filtered_conserved.txt";
open FM, $fm or die "can not open $fm\n";
while (<FM>) {
	chomp;
	my @a=split /\t/;
	next if /^Family_id/;
	my %hash; my $j; my $info;
	for (my $i = 2; $i <= 15; $i++) {
		if ($a[$i]==1) {
			$j++;
		}
	}
	if ($j && $j==14) {
		my @b=split /\,/, $a[-1];
		foreach my $gene (@b) {
			(my $spe)=$gene=~/(.*?)\_/;
			$hash{$spe}=$gene;
		}

		foreach my $spe (@spe) {
			$info.=$hash{$spe}."\t";
		}
		$info=~s/\s+$//;
		print "$a[0]\t$info\n";
	}
}
```
```bash
# Kang@fishlab3 Tue May 17 09:13:29 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
perl temp2.pl >single_copy_genes_list.txt
# Kang@fishlab3 Tue May 17 09:16:21 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/paml_input
cp ../Orthogroups/single_copy_genes_list.txt ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/prepare_input_paml.pl ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/prepare_input_paml_parallel.pl ./
nohup perl prepare_input_paml_parallel.pl single_copy_genes_list.txt >prepare_input_paml.process 2>&1 &
# [1] 4569
```
## Start to detect positive selected genes
**2.1 Set Ldim as forebranch**   
**species tree**   
```bash
vi spe_Ldim.tre
# ((((Fugu,(Stickleback,(Spul,((Cund,((Smel,Tads),Lber)),(Ncel,(Ldim #1,Tbif)))))),(Platyfish,Medaka)),Zebrafish),Spottedgar);
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/codeml.pl ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/codeml_parallel.pl ./
nohup perl codeml_parallel.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 10443
```
**2.2 Set all wrasses as forebranch**   
in SNORLAX   
```bash
# Kang@fishlab3 Tue May 17 21:47:41 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09
nohup scp -r paml_input/  kang1234@147.8.76.177:~/genome/gene_family/reports_gf3
# ctrl+z
bg
# [2]+ nohup scp -r paml_input/ kang1234@147.8.76.177:~/genome/gene_family/reports_gf3 &
# (base) kang1234@celia-PowerEdge-T640 Tue May 17 21:55:49 ~/genome/gene_family/reports_gf3/paml_input
vi Ancestor_wrasses.tre
# ((((Fugu,(Stickleback,(Spul,((Cund,((Smel,Tads),Lber)),(Ncel,(Ldim,Tbif)))) #1)),(Platyfish,Medaka)),Zebrafish),Spottedgar);
nohup perl codeml_parallel_wrasses.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 30600
```


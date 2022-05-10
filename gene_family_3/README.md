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
## two method to detect the gene family  
### 1. keep the genes in each gene family with the same gene family
```bash
# Kang@fishlab3 Tue May 10 11:11:01 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
perl build_fm_same_name.pl >fm_same_name.txt # divid the orthogroup into gene family
perl count_nb_fm_same_name1.pl >fm_same_name_nb_ano.txt
perl count_nb_fm_same_name2.pl >fm_same_name_nb.txt
```
### 2. No care about gene families including genes with different name
Resulted Orthogroups as the gene family   
```bash
# Kang@fishlab3 Tue May 10 11:20:23 /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups
perl build_fm_no_care1.pl >fm_no_care_nb_ano.txt
perl build_fm_no_care2.pl >fm_no_care_nb.txt
```




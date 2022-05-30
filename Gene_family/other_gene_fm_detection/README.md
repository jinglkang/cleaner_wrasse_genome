# BLASTN for the details of some specific gene families
## 1. Neurexin gene family (aa >= 50)   
### 1.1 Find the protein sequences of Zebrafish as query   
```bash
# Kang@fishlab3 Mon May 30 11:04:47 /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation
less Zebrafish_gene.txt|grep -i 'Neurexin' >Zebrafish_neurexin.txt
# Kang@fishlab3 Mon May 30 11:20:10 /media/HDD/cleaner_fish/genome
mkdir Neurexin_detection; cd Neurexin_detection
# Kang@fishlab3 Mon May 30 11:21:16 /media/HDD/cleaner_fish/genome/Neurexin_detection
vi temp1.pl
perl temp1.pl /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation/Zebrafish_neurexin.txt >neurexin_query.fasta
```

```temp1.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $pepseq="/media/HDD/cleaner_fish/genome/gene_family_2/Zebrafish_pep.fasta";
my %pep; my $pro;
open PEP, $pepseq or die "can not open $pepseq\n";
while (<PEP>) {
	chomp;
	if (/>/) {
		s/>//;
		s/\|\d+$//;
		$pro=$_;
	} else {
		$pep{$pro}.=$_;
	}
}

open TAR, $ARGV[0] or die "can not open $ARGV[0]\n";
while (<TAR>) {
	chomp;
	my @a=split /\t/;
	my ($gene, $name)=($a[0], $a[1]);
	my $len=length($pep{$a[0]});
	print ">$gene|$name|$len\n$pep{$a[0]}\n";
}
```

### 2.1  *L. dimidiatus*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader.fasta \
--species Cleaner_wrasse \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.2 *Thalassoma_bifasciatum*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/Thalassoma_bifasciatum.fasta \
--species Thalassoma_bifasciatum \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.3 *Notolabrus_celidotus*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/Notolabrus_celidotus.fasta \
--species Notolabrus_celidotus \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.4 *Cheilinus_undulatus*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/cheilinus_undulatus.fasta \
--species Cheilinus_undulatus \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.5 *Symphodus_melops*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/smel_genome/Symphodus_melops_softmasked.fasta \
--species Symphodus_melops \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.6 *emicossyphus_pulcher*    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Semicossyphus_pulcher_softmasked_ChaHeader.fasta \
--species Semicossyphus_pulcher \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.7 *Tautogolabrus_adspersus*
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Tautogolabrus_adspersus_softmasked_ChaHeader.fasta \
--species Tautogolabrus_adspersus \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.8 *Labrus_bergylta*    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/Labrus_bergylta.fasta \
--species Labrus_bergylta \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.9 Fugu   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Fugu.dna_sm.toplevel.fa \
--species Fugu \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.10 Japanese Medake    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Japanese_medaka_hsok.dna_sm.toplevel.fa \
--species Medake \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.11 Stickleback    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Gasterosteus_aculeatus.BROADS1.dna_sm.toplevel.fa \
--species Stickleback \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.12 Zebrafish    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Zebrafish_genome.ncbi.fa \
--species Zebrafish \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.13 Platyfish    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Platyfish-male.dna_sm.toplevel.fa \
--species Platyfish \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.14 Spottedgar    
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Spottedgar.dna_sm.toplevel.fa \
--species Spottedgar \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
## Summary   
```temp2.pl
#!/usr/bin/perl -w
use strict;
use warnings;


my @results=<*/filtering/filter.out.1>;
my (%hash1, %hash2); my (@spes, @names);
foreach my $result (@results) {
	my ($spe)=$result=~/(.*)\/filtering\/filter\.out\.1/;
	push @spes, $spe;
	open FIL, $result or die "$!\n";
	while (<FIL>) {
		chomp;
		my @a=split /\t/;
		my ($name)=$a[1]=~/(.*)\_/;
		$hash1{$name}++;
		push @names, $name if $hash1{$name}==1;
		$hash2{$spe}->{$name}++;
	}
	close FIL;
}

my $i;
my @new_spes=qw(Cleaner_wrasse Thalassoma_bifasciatum Symphodus_melops Tautogolabrus_adspersus Labrus_bergylta Semicossyphus_pulcher Notolabrus_celidotus Cheilinus_undulatus Stickleback Fugu Platyfish Medake Zebrafish Spottedgar);
foreach my $spe (@new_spes) {
	$i++;
	my ($head, $nums);
	foreach my $name (@names) {
		$head.=$name."\t";
		my $num;
		$hash2{$spe}->{$name}?($num=$hash2{$spe}->{$name}):($num=0);
		$nums.=$num."\t";
	}
	$head=~s/\s+$//;
	$nums=~s/\s+$//;
	$head="Species\t".$head;
	print "$head\n" if $i==1;
	print "$spe\t$nums\n";
}
```
```bash
# Kang@fishlab3 Mon May 30 14:58:39 /media/HDD/cleaner_fish/genome/Neurexin_detection
perl temp2.pl >Neurexin_summary.txt
```

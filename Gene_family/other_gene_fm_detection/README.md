# BLASTN for the details of some specific gene families
## 1. Neurexin gene family   
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

### 2.1 *L. dimidiatus*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader.fasta \
--species Cleaner_wrasse \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### 2.2 *Thalassoma bifasciatum*   
```bash
./Neurexin_detect --genome /media/HDD/cleaner_fish/genome/Thalassoma_bifasciatum.fasta \
--species Thalassoma_bifasciatum \
--query /media/HDD/cleaner_fish/genome/Neurexin_detection/neurexin_query.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```

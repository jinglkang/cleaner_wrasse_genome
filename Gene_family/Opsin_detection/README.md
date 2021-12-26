# visual genes detection: two photoreceptor types (rods and cones)
## query protein
```bash
# Kang@fishlab3 Wed Dec 22 15:36:04 /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation
less Zebrafish_gene.txt|grep -i 'opsin'|grep -i 'cone' >photoreceptors_gene_zebrafish.txt # cone photoreceptors
less Zebrafish_gene.txt|grep -i 'opsin'|perl -alne '$na=lc($F[1]);print if $na eq "rho"'>>photoreceptors_gene_zebrafish.txt # rod photoreceptors
```

vi temp1.pl   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my $gene; my %hash;
open FIL1, "../Longest_Zebrafish_pep.fasta" or die "$!\n";
while (<FIL1>) {
	chomp;
	if (/>/) {
		s/>//;
		$gene=$_;
	} else {
		$hash{$gene}.=$_;
	}
}

open FIL2, "photoreceptors_gene_zebrafish.txt" or die "$!\n";
while (<FIL2>) {
	chomp;
	my @a=split;
	my $header=$a[0]."|".$a[1];
	my $seq=$hash{$a[0]};
	if ($seq) {
		print ">$header\n$seq\n";
	} else {
		die "There is no sequence of $a[0]\n";
	}
}
```
extract the pep sequences of these photoreceptors in zebrafish (13 photoreceptors)   
```bash
# Kang@fishlab3 Thu Dec 23 09:01:40 /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation
perl temp1.pl >photoreceptors_gene_zebrafish_pep.fasta
mv photoreceptors_gene_zebrafish_pep.fasta /media/HDD/cleaner_fish/genome/Opsin_detection
```
detect photoreceptors   
soloar: intron length (1000)   
### Cleaner_wrasse
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader.fasta \
--species Cleaner_wrasse \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Zebrafish
```bash
nohup ./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Zebrafish_genome.ncbi.fa \
--species Zebrafish \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta &
```
### ***Labrus bergylta*** (ballan wrasse)
```bash
nohup ./Opsin_detect --genome /media/HDD/cleaner_fish/genome/Labrus_bergylta.fasta \
--species Labrus_bergylta \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta &
```
***
### ***Cheilinus undulatus*** (humphead wrasse)
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/cheilinus_undulatus.fasta \
--species Cheilinus_undulatus \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Fugu
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Fugu.dna_sm.toplevel.fa \
--species Fugu \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Stickleback
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Gasterosteus_aculeatus.BROADS1.dna_sm.toplevel.fa \
--species Stickleback \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Medaka
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Japanese_medaka_hsok.dna_sm.toplevel.fa \
--species Medaka \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### ***Notolabrus celidotus*** (New Zealand spotty)
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/Notolabrus_celidotus.fasta \
--species Notolabrus_celidotus \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Platyfish
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Platyfish-male.dna_sm.toplevel.fa \
--species Platyfish \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### Spottedgar
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Spottedgar.dna_sm.toplevel.fa \
--species Spottedgar \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### ***Symphodus melops*** (corkwing wrasse)
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/smel_genome/Symphodus_melops_softmasked.fasta \
--species Symphodus_melops \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
### ***Thalassoma bifasciatum*** (bluehead)
```bash
./Opsin_detect --genome /media/HDD/cleaner_fish/genome/Thalassoma_bifasciatum.fasta \
--species Thalassoma_bifasciatum \
--query /media/HDD/cleaner_fish/genome/Opsin_detection/photoreceptors_gene_zebrafish_pep.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```

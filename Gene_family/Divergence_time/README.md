# MCMCtree estimate divergence time
## Extract the nucleotide cds sequence of cds per single copy gene
get the gene id in /media/HDD/cleaner_fish/genome/gene_family_2/single_copy   
working dir: /media/HDD/cleaner_fish/genome/gene_family_2   
```bash
# Kang@fishlab3 Wed Dec 29 16:41:24 /media/HDD/cleaner_fish/genome/gene_family_2
perl extract_single_copy_id.pl
```

## get the nucleotide cds sequences from ensembl   

## Extract the nucleotide cds sequences of other six fish species from their genome
change_fasta_header.pl: add the length info (e.g., Smel_g1|1435)   
```perl
#!/usr/bin/perl
use strict;
use warnings;

my %hash; my $tran; my @trans;
open FIL, "$ARGV[0]";
while (<FIL>) {
        chomp;
        if (/>/) {
                s/>//;
                $tran=$_;
                push @trans, $tran;
        } else {
                $hash{$tran}.=$_;
        }
}

foreach my $tran (@trans) {
        (my $na)=$tran=~/(.*)\./;
        my $seq=$hash{$tran};
        my $len=length($seq);
        print ">$na|$len\n$seq\n";
}
```

```bash
# Symphodus_melops
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:25:53 ~/genome/Gene_annotation/Symphodus_melops
gffread -x Symphodus_melops.cds.all.fasta -g ../Symphodus_melops_softmasked.fasta braker_renamed.gtf
perl change_fasta_header.pl Symphodus_melops.cds.all.fasta >Symphodus_melops_cds.fasta

# Labroides_dimidiatus
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:09:57 ~/genome/Gene_annotation/combined
gffread -x Cleaner_wrasse.cds.all.fasta -g ../Cleaner_wrasse_softmasked_ChaHeader.fasta braker2+3_combined_renamed.gtf
perl change_fasta_header.pl Cleaner_wrasse.cds.all.fasta >Cleaner_wrasse_cds.fasta

# Labrus_bergylta
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:37:24 ~/genome/Gene_annotation/Labrus_bergylta
gffread -x Labrus_bergylta.cds.all.fasta -g ../Labrus_bergylta_softmasked_ChaHeader.fasta braker_renamed.gtf
perl change_fasta_header.pl Labrus_bergylta.cds.all.fasta >Labrus_bergylta_cds.fasta

# Thalassoma_bifasciatum
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:38:57 ~/genome/Gene_annotation/Thalassoma_bifasciatum
gffread -x Thalassoma_bifasciatum.cds.all.fasta -g ../Thalassoma_bifasciatum_ChaHeader.fasta braker_renamed.gtf
perl change_fasta_header.pl Thalassoma_bifasciatum.cds.all.fasta >Thalassoma_bifasciatum_cds.fasta

# Cheilinus_undulatus
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:43:52 ~/genome/Gene_annotation/Cheilinus_undulatus
gffread -x Cheilinus_undulatus.cds.all.fasta -g ../Cheilinus_undulatus_softmasked_ChaHeader.fasta braker_renamed.gtf
perl change_fasta_header.pl Cheilinus_undulatus.cds.all.fasta >Cheilinus_undulatus_cds.fasta

# Notolabrus_celidotus
# (base) kang1234@celia-PowerEdge-T640 Wed Dec 29 20:47:35 ~/genome/Gene_annotation/Notolabrus_celidotus
gffread -x Notolabrus_celidotus.cds.all.fasta -g ../Notolabrus_celidotus_softmasked_ChaHeader.fasta braker_renamed.gtf
perl change_fasta_header.pl Notolabrus_celidotus.cds.all.fasta >Notolabrus_celidotus_cds.fasta
```

## Extract the longest cds sequences per species
```bash
#Kang@fishlab3 Wed Dec 29 21:24:00 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
perl Ensemble_longest_pep.pl --fasta *.fasta
nohup perl extract_single_copy_cds_align_trim.pl &
# [1] 31514
```

## concatenate the cds sequences of single copy genes
working dir: /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id   
vi temp1.pl   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

# concatenate the cds sequences
my @fasta=<single_copy_cds/*.fasta>;

my %spes; my ($spe, $i); my @species;
foreach my $fas (@fasta) {
	$i++;
	open FAS, "$fas" or die "can not open $fas\n";
	while (<FAS>) {
		chomp;
		if (/>/) {
			($spe)=$_=~/>(.*)_/;
			push @species, $spe if $i==1;
		} else {
			$spes{$spe}.=$_;
		}
	}
}

foreach my $spe (@species) {
	my $seq=$spes{$spe};
	print ">$spe\n$seq\n";
}
```

```bash
# Kang@fishlab3 Thu Dec 30 11:08:52 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
perl temp1.pl >single_copy.cds.concatenated.fasta
fasta2phy.pl single_copy.cds.concatenated.fasta >single_copy.cds.concatenated.phy
```
single_copy.cds.concatenated.phy (1,554,989) will be used as mcmctree input sequence file   

## Estimate the best nucleotide module
```bash
# Kang@fishlab3 Thu Dec 30 11:14:34 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
nohup java -jar ~/software/jmodeltest-2.1.10/jModelTest.jar -d single_copy.cds.concatenated.fasta -g 4 -i -f -AIC -BIC -a >jmodeltest.process 2>&1 &
# [1] 17100
```

```bash
::Best Models::

	Model 		f(a) 	f(c) 	f(g) 	f(t) 	kappa 	titv 	Ra	Rb	Rc	Rd	Re	Rf	pInv 	gamma
----------------------------------------------------------------------------------------------------------------------------------------
AIC 	GTR+I+G		0.25	0.27	0.27	0.21	0.00	0.00	  1.256   3.318   1.252   1.006   4.821   1.000    0.26	   1.01
BIC 	GTR+I+G		0.25	0.27	0.27	0.21	0.00	0.00	  1.256   3.318   1.252   1.006   4.821   1.000    0.26	   1.01
```
***
## RUN MCMCtree
```bash
# Kang@fishlab3 Thu Dec 30 16:39:00 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
mkdir mcmctree;cd mcmctree
# Kang@fishlab3 Thu Dec 30 17:04:23 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree
cp ../../RAxML_bestTree.single_copy.concatenated ./
mkdir baseml; cd baseml
cp ~/Desktop/PapueNewGuinea-new/longest_pep_sec/input_pep/mcmctree/baseml/baseml.ctl ./
# Kang@fishlab3 Thu Dec 30 17:09:01 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree
cp ../single_copy.cds.concatenated.phy ./
```
### reivse the tree
#### baseml: Rough estimation of the substitution rate
remove the branch length info in RAxML_bestTree.single_copy.concatenated   
add the time of fossil calibrations   
```bash
# Kang@fishlab3 Thu Dec 30 17:28:39 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree
less RAxML_bestTree.single_copy.concatenated|perl -alne 's/\:\d+\.\d+//g;print' >mcmc.tree
cat mcmc.tree
# 12 2
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif,Ldim)))))'B(.969,1.509)')'B(1.4885,1.652)',Spottedgar);
cp mcmc.tree baseml.tree
# Kang@fishlab3 Thu Dec 30 17:53:14 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree
cat baseml.tree
# 12 1
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif,Ldim)))))'@(.969,1.509)')'@(1.4885,1.652)',Spottedgar);
# Kang@fishlab3 Thu Dec 30 17:55:00 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree/baseml
baseml
# Substitution rate is per time unit: 0.005424 (m=0.005424; s=0.005424)
# a = (m/s)^2 and b = m/s^2
# a = 1 && b = 184.3
# mcmctree1.ctl: rgene_gamma = 1 184.3
```
#### Estimation of the gradient and Hessian
##### mcmctree1.ctl: usedata = 3; ndata = 1; rgene_gamma = 1 184.3
```bash
# Kang@fishlab3 Thu Dec 30 19:02:54 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree/baseml
cp ~/Desktop/PapueNewGuinea-new/longest_pep_sec/input_pep/mcmctree/baseml/mcmctree*.ctl ./
nohup ~/software/paml4.9j/src/mcmctree mcmctree1.ctl > mcmctree1.process 2>&1 &
# [1] 28145
mv out.BV in.BV
cat in.BV rst2 > 1.txt
mv 1.txt in.BV
```
##### mcmctree2.ctl: usedata = 2; ndata = 1; rgene_gamma = 1 184.3
remember change the "rgene_gamma" (same with mcmctree1.ctl) in mcmctree2.ctl   
```bash
# Kang@fishlab3 Thu Dec 30 19:54:29 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id/mcmctree/baseml
nohup ~/software/paml4.9j/src/mcmctree mcmctree2.ctl >mcmctree2.process 2>&1 &
# [1] 28597
```

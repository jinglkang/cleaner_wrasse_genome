## lintre estimate the evolutionary rate: two-cluster test
### Two-cluster test
1.1 prepare the input sequence file   
```bash
# 1. prepare a phylip format seuqence file (without the number of sequences and the number of sites, but sequence names and actual data should be separated by at least one space.)
# Kang@fishlab3 Thu May 05 15:01:08 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/paml_input/OG0010345
cp final_alignment.phy 1.phy; vi 1.phy;
less 1.phy|perl -alne '$a=uc($F[1]);print "$F[0]\t$a"' >2.phy
```
***   
1.2 construct the neighbor-joinig (NJ) tree   
```bash
# an NJ tree constructed by Kimura's two parameter distance
njboot 2.phy -d1 > 2.nj1

```
***   
1.4 Two-cluster test   
```bash
tpcv 2.phy -t1.nj1 -d2 -o3 > 1.tc
# 1.tv gives the result of the two-cluster test at each interior node
```

```bash
# Kang@fishlab3 Thu May 05 19:25:53 /media/HDD/cleaner_fish/genome/gene_family
# protein sequences; 6 amino p-distance
njboot single_copy.concatenated.two_cluster -d6 > single_copy.concatenated.nj6
tpcv single_copy.concatenated.two_cluster -tsingle_copy.concatenated.nj6 -d3 -o2 > single_copy.concatenated.tc
```
***   
### use spottedgar as outgroup, and Ldim as reference (and also need add zebrafish to do the cluster analysis)   
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

my $zebra="Zebrafish";
my $outgroup="Spottedgar";
my $ref="Ldim";

my $input=$ARGV[0];
my @spe; my %seq;
my $foreseq;
open FIL, $input or die "can not open $input\n";
while (<FIL>) {
	chomp;
	my @a=split;
	$seq{$a[0]}=$a[1];
	if ($a[0]=~/Zebrafish|Spottedgar|Ldim/) {
		$foreseq.=$a[0]."\t".$a[1]."\n";
	} else {
		push @spe, $a[0];
	}
}

foreach my $spe (@spe) {
	my $seqs=$seq{$spe};
	my $file=$spe.".phy";
	my $nj=$spe.".nj6";
	my $rate=$spe.".tc";
	open FILE, ">$file" or die "can not create $file\n";
	print FILE "$foreseq$spe\t$seqs\n";
	system("njboot $file -d6 > $nj");
	system("tpcv $file -t$nj -d3 -o 1 > $rate");
}
```

```bash
# Kang@fishlab3 Fri May 06 15:21:13 /media/HDD/cleaner_fish/genome/gene_family/evolutionary_rate
perl temp1.pl single_copy.concatenated.two_cluster
```
**then check the file suffix ".tc"**    
***   
## Tajima’s relative rate test
MEGA --> File --> --> CLOCK --> Tajima's Relative Rate Test (Taxon A: ; Taxon B: Ldim; Outgroup: Spottedgar)    

### scale the value
```R
a1<-c("-0.031668", "-0.035006", "-0.015687", "0.020205", "-0.020904", "-0.02948", "-0.00579", "-0.023723", "-0.012843", "-0.046734", "-0.035031", "-0.012663", "-0.017452", "0.029613", "0.001144")
a1<-as.numeric(a1)
scale(a1,center=T,scale=F)
```

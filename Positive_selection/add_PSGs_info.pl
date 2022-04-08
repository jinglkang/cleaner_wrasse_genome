#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my $ano=$ARGV[0]; # the annotation file
my %anno;
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
	chomp;
	my ($gene, $name, $info);
	my @a=split /\t/;
	$gene=$a[0];
	($name)=$_=~/symbol=\"(.*?)\"/;
	($info)=$_=~/Name=\"(.*?)\"/;
	$anno{$gene}=$name."\t".$info;
}

my $orth=$ARGV[1]; # Gene list in orthogoups
my %ortho;
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
	chomp;
	my @a=split;
	my $orth_id=$a[0];
	for (my $i = 1; $i < @a; $i++) {
		if ($a[$i]=~/\_/) {
			my ($spe)=$a[$i]=~/(.*)\_/;
			my $gene=$a[$i];
			$ortho{$orth_id}->{$spe}=$gene;
		}
	}
}

my @txt=<postively_selected_genes/*.txt>;
foreach my $txt (@txt) {
	my ($spe, $orth_id)=basename($txt)=~/(.*?)-psg-(.*?)\.txt/;
	open TXT, $txt or die "can not open $txt\n";
	while (<TXT>) {
		chomp;
		my @a=split;
		my ($orth_id)=$a[0];
		my $gene=$ortho{$orth_id}->{$spe};
		my $ano=$anno{$gene};
		print "$_\t$spe\t$gene\t$ano\n";
	}
}

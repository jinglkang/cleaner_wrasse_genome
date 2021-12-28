#!/usr/bin/perl -w
use strict;
use warnings;

# pwd: /media/HDD/cleaner_fish/genome/gene_family_2
# gene id in each family: dump.blast_output.mci.I30
# based on the filtered gene family file: filtered_cafe_input.final.txt
# annotation file: all_annotation/ (e.g., Ldim.anno.final.txt)

my @species=qw(Ldim Lber Cund Ncel Smel Tbif);

my $cmd1="cat all_annotation/*.anno.final.txt >species.anno"; # put the six species annotation info to one file
system($cmd1);
my %ANNO;
open ANNO, "species.anno" or die "$!\n"; # build hash for annotation info
while (<ANNO>) {
	chomp;
	my @a=split;
	if (/symbol\=\"(.*?)\"/) {
		my $id=$a[0];
		my $name=uc($1);
		$ANNO{$id}=$name;
	}
}

my $k; my %FAMILY;
open FAMILY, "dump.blast_output.mci.I30" or die "$!\n"; # this file instore gene id in each family
while (<FAMILY>) {
	chomp;
	my @a=split;
	my $ano;
	$k++;
	my $j;
	my $flag;
	for (my $i = 0; $i < @a; $i++) {
		next if /_ENS/;
		$j++;
		$ano=$ANNO{$a[$i]} if $j==1;
		if ($ano ne $ANNO{$a[$i]}) {
			$flag=1;
			last;
		}
	}
	unless ($flag) {
		$FAMILY{$k}++;
	}
}

open FILTER, "filtered_cafe_input.final.txt" or die "$!\n";
while (<FILTER>) {
	chomp;
	my @a=split;
	if (/^Desc/) {
		print "$_\n";
	} else {
		my $id=$a[1];
		my $zebra=$a[-7]; # zebrafish gene number in this gene family
		if ($FAMILY{$id} && $zebra>0) {
			print "$_\n";
		}
	}
}

system("rm species.anno");

#!/usr/bin/perl -w
use strict;
use warnings;

# Ldim gene annotation: ~/genome/Gene_annotation/combined/Gene_annotation.final.txt
# DEGs id list: $ARGV[0]
# gene family content: 
# gene family assigned name: 

my %zebra;
my $zebra_ano="Zebrafish_gene.txt";
open ZEBRA, "$zebra_ano" or die "There is no $zebra_ano\n";
while (<ZEBRA>) {
	chomp;
    my @a=split /\t/;
    next if /^Gene/;
    my $id="Zebrafish_".$a[0];
    my $info;
    for (my $i = 1; $i < @a; $i++) {
            $info.=$a[$i]."\t";
    }
    $info=~s/\s+$//;
    $zebra{$id}=$info;
}

my $Ldim_ano="Gene_annotation.final.txt"; my %Ldim;
open LDIM_ANO, $Ldim_ano or die "can not open $Ldim_ano\n";
while (<LDIM_ANO>) {
	chomp; my @a=split /\t/;
	my $id=$a[0];
	$Ldim{$id}="$a[0]; $a[-2] \($a[3]\)";
}

my $DEGs=$ARGV[0]; my %DEGs;
open DEG, $ARGV[0] or die "can not open $ARGV[0]\n";
while (<DEG>) {
	chomp; $DEGs{$_}++;
}

my (%family, %fm_Ldim);
my $fam="dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
    chomp;
    $k++;
    my @a=split;
    next if ! /Zebrafish/i;
    for (my $i = 0; $i < @a; $i++) {
    	if ($a[$i]=~/Zebrafish/i) {
    		$family{$k}=$zebra{$a[$i]};
            last;
        }
    }
}

my $m;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
	chomp;
	$m++;
	my @a=split;
	next if ! /Ldim/i;
	next if ! /Zebrafish/i;
	my $fm_id="Family_".$m;
	my $fm_an=$family{$m};
	my $info1=$fm_id."\t".$fm_an;
	my ($info2, $j);
	# Get Ldim gene id in this gene family
    for (my $i = 0; $i < @a; $i++) {
    	if ($a[$i]=~/Ldim/i) {
    		if ($DEGs{$a[$i]}) {
    			$j++;
    			my $id =$a[$i];
    			my $ano=$Ldim{$id};
    			$info2 .=$ano."\t";
    		}
        }
    }
    if ($j && $j>=1) {
    	$info2=~s/\s+$//;
    	print "$info1\t$j\t$info2\n";
    }
}

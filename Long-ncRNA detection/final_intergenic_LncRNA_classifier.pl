#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;
use Getopt::Long 'HelpMessage';
use Parallel::ForkManager;

my (%hash1, %hash2);
my $reads   =$ARGV[0];
open FIL0, $reads or die "can not open $reads\n";
while (<FIL0>) {
    chomp;
    my @a=split /\t/;
    if (/^Geneid/) {
        next;
    } else {
    	$hash1{$a[0]}++;
    }
}

my $anno    =$ARGV[1];
open FIL1, $anno or die "can not open $anno\n";
while (<FIL1>) {
	chomp;
	my @a=split /\t/;
	$hash2{$a[0]}=$a[2]."\t".$a[3];
}

my $classify=$ARGV[2];
open FIL2, $classify or die "can not open $classify\n";
while (<FIL2>) {
	chomp;
	s/\s+$//;
	s/\r$//;
	my @a=split /\t/;
	my $info;
	for (my $i = 1; $i < @a; $i++) {
		$info.=$a[$i]."\t";
	}
	$info=~s/\s+$//;
    if (/^isBest/){
    	print "$info\tpartnerRNA_gene_name\tpartnerRNA_gene_name_description\n";
    } elsif ($a[0]==1 && $a[6] eq "intergenic" && $hash1{$a[1]}) {
    	print "$info\t$hash2{$a[3]}\n";
    }
}

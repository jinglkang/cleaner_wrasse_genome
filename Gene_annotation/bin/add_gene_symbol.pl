#!/usr/bin/perl
use strict;
use warnings;

my $swis="swiss-prot_acc_symbol.txt";
my %swis_symbol;
open SWIS, $swis or die "can not open $swis\n";
while (<SWIS>) {
        chomp;
        my @a=split;
        my $swis_acc=$a[0];
        $swis_symbol{$swis_acc}=$a[1];
}

my $ref="ref_acc_symbol.txt";
my %ref_symbol;
open REF, $ref or die "can not open $ref\n";
while (<REF>) {
        chomp;
        my @a=split;
        my $ref_acc=$a[0];
        $ref_symbol{$ref_acc}=$a[1];
}

my $ano="braker2+3_combined_renamed.aa.long.anno.txt";
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
        chomp;
        my @a=split /\t/;
        if (/swiss-prot/) {
                (my $swis_acc)=$_=~/db_accession=\"(.*)?\";/;
                my $symbol=$swis_symbol{$swis_acc};
                print "$a[0]\t$a[1]\tsymbol=\"$symbol\"\t$a[2]\n";
        } elsif (/refseq/) {
                (my $ref_acc)=$_=~/db_accession=\"(.*)?\.\d+\"/;
                my $symbol=$ref_symbol{$ref_acc};
                print "$a[0]\t$a[1]\tsymbol=\"$symbol\"\t$a[2]\n";
        } else {
                print "$a[0]\t$a[1]\tsymbol=\"-\"\t$a[2]\n";
        }
}

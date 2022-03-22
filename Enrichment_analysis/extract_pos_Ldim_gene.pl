#!/usr/bin/perl -w
use strict;
use warnings;

my $fm="pos_gene_fm.txt";
my %family;
open FM, $fm or die "can not open $fm\n";
while (<FM>) {
        chomp;
        $family{$_}++;
}


my $fam="Rep_gene_fm.txt";
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        my @a=split;
        if ($family{$a[0]}) {
                for (my $i = 1; $i < @a; $i++) {
                        if ($a[$i]=~/Ldim/i) {
                                print "$a[0]\t$a[$i]\n";
                                last;
                        }
                }
        }
}

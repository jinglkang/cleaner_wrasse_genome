#!/usr/bin/perl -w
use strict;
use warnings;

my $fm=$ARGV[0];
my %family;
open FM, $fm or die "can not open $fm\n";
while (<FM>) {
        chomp;
        $family{$_}++;
}


my $fam="/media/HDD/cleaner_fish/genome/gene_family_2/dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        $k++;
        my @a=split;
        my $fm="Family_".$k;
        if ($family{$fm}) {
                for (my $i = 0; $i < @a; $i++) {
                        if ($a[$i]=~/Ldim/i) {
                                print "$fm\t$a[$i]\n";
                                last;
                        }
                }
        }
}

#!/usr/bin/perl -w
use strict;
use warnings;

my (%hash1, %hash2);
open FIL1, "Ldim_ano_swissprot_detail.2.human.string.tab";
while (<FIL1>) {
        chomp;
        next if /^From/;
        my @a=split;
        $hash1{$a[0]}=$a[1];
}

open FIL2, "Ldim_ano_swissprot_detail.2.txt";
while (<FIL2>) {
        chomp;
        my @a=split;
        $hash2{$a[0]}=$a[1]."\t".$a[2];
}

open FIL3, "Ldim_ano_swissprot.txt";
while (<FIL3>) {
        chomp;
        my @a=split;
        my $nm1;
        if ($hash2{$a[1]}) {
                my $nm1=$hash2{$a[1]};
                my @b=split /\t/, $nm1;
                my $nm2;
                $hash1{$b[1]}?($nm2=$hash1{$b[1]}):($nm2="---");
                print "$_\t$nm1\t$nm2\n";
        } else {
                print "$_\n";
        }
}

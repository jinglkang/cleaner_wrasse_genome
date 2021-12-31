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

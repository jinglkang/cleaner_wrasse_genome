#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open LncR, "$ARGV[0]";
while (<LncR>) {
        chomp;
        my @a=split;
        $hash{$a[0]}++;
}

open FIL, "$ARGV[1]" or die "can not open $ARGV[1]\n";
while (<FIL>) {
        chomp;
        if (/^\# stringtie/) {
                next;
        } elsif (/^\# StringTie/) {
                print "$_\n";
        } elsif (/gene_id \"(.*?)"/) {
                print "$_\n" if $hash{$1};
                        #       print "$1\n";
        }
}

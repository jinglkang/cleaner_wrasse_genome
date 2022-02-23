#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;
use Getopt::Long 'HelpMessage';
use Parallel::ForkManager;

my $file="LncRNA_gene_read_nb.txt";
open FIL, $file or die "can not open $file\n";
while (<FIL>) {
        chomp;
        next if /^#/;
        my @a=split;
        if (/^Geneid/) {
                s/\.sorted\.bam//g;
                print "$_\n";
        } else {
                my $j;
                for (my $i = 6; $i < @a; $i++) {
                        if ($a[$i]>=10) {
                                $j++;
                        }
                }
                print "$_\n" if $j && $j>=80;
        }
}

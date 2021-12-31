#!/usr/bin/perl -w
use strict;
use warnings;

system("mkdir single_copy_id") if ! -e "single_copy_id";
my @fas=<single_copy/*.fasta>;
foreach my $fas (@fas) {
        open FAS, "$fas" or die "can not open $fas\n";
        while (<FAS>) {
                chomp;
                if (/>/) {
                        s/>//;
                        (my $spe)=$_=~/(\D+)\_/;
                        my $output=$spe.".single_copy_id.txt";
                        open OUTPUT, ">>single_copy_id/$output" or die "can not create $output\n";
                        if (/ENS/) {
                                (my $id)=$_=~/_(.*)/;
                                print OUTPUT "$id\n";
                        } else {
                                print OUTPUT "$_\n";
                        }
                }
        }
}

#!/usr/bin/perl
use strict;
use warnings;

my (%seq, %hash);
my $spe; my @spes;
my @fasta=<$ARGV[0]/*.fasta>;
foreach my $fasta (@fasta) {
        my $new=$fasta."trimal";
        system("trimal -in $fasta -out $new -gt 0.8 -st 0.001 -cons 60");
        open FIL, "$new" or die "can not open $new\n";
        while (<FIL>) {
                chomp;
                if (/>(.*?)(_|-)/) {
                        $spe=$1;
                        $hash{$spe}++;
                        push @spes, $spe if $hash{$spe}==1;
                } else {
                        $seq{$spe}.=$_;
                }
        }
        system("rm $new");
}

foreach my $spe (@spes) {
        print ">$spe\n$seq{$spe}\n";
}

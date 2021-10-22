#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
        'fasta:s{1,}', \my @fasta,      # the overall reads number matrix
        'out:s', \my $out # prefix name of the output
        );

if (! @fasta || (! $out) ) {
        die "pls give me some fasta file with required names, or did you forget the output name\n";
}

my %hash;
my (@spe);
my $j;
foreach my $fa (@fasta) {
        $j++;
        open FA, "$fa" or die "can not open $fa\n";
        (my $gene)=$fa=~/(.*?)_align.*\.fasta/;
        my ($spe, $seq);
        my $i;
        while (<FA>) {
                chomp;
                if (/>/) {
                        s/>//;
                        $i++;
                        $spe=$_;
                        push @spe, $spe if $j==1;
                } elsif ($hash{$spe}) {
                        $hash{$spe} .= $_;
                        my $len=length($_);
                        print "$gene\t$len\n" if $i==1;
                } else {
                        $hash{$spe} = $_;
                        my $len=length($_);
                        print "$gene\t$len\n" if $i==1;
                }
        }
        close FA;
}

my $output=$out.".fasta";
open OUTPUT, ">$output" or die "can not create $output";

foreach my $spe (@spe) {
        print OUTPUT ">$spe\n$hash{$spe}\n";
}
close OUTPUT;

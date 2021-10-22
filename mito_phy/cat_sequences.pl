#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
        'fasta:s{1,}', \my @fasta,      # the overall reads number matrix
        );

if (! @fasta) {
        die "pls give me some fasta file with required names\n";
}

foreach my $fa (@fasta) {
        open FA, "$fa" or die "can not open $fa\n";
        (my $spe)=$fa=~/(.*?)\..*\.fasta/;
        my $seq;
        while (<FA>) {
                chomp;
                next if /^\>/ || /^\s+/;
                $seq.=uc($_);
        }
        $seq=~s/^\s+//;
        print ">$spe\n$seq\n";
}

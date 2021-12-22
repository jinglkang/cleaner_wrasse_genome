#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
                'fasta:s{1,}', \my @fasta,# the overall reads number matrix
                );

foreach my $fas (@fasta) {
        my ($genes, $hash1, $hash2)=extract_info_fasta($fas);
        my ($name)=$fas=~/(.*?)\./;
        my $output=$name."_pep.fasta";
        open OUTPUT, ">$output" or die "can not open $output\n";
        foreach my $gene (@{$genes}) {
                my $time=${$hash1}{$gene};
                for (my $i = 1; $i < $time+1; $i++) {
                        my $len=${$hash2}{$gene}->{$i}->{'len'};
                        my $seq=${$hash2}{$gene}->{$i}->{'seq'};
                        print OUTPUT ">$gene|$len\n$seq\n";
                }
        }
        close OUTPUT;
}


sub extract_info_fasta {
        my ($fasta)=@_;
        my @genes;
        my ($gene, $len);
        my (%hash1, %hash2, %hash3);
        open FASTA, "$fasta" or die "can not open $fasta\n";
        while (<FASTA>) {
                chomp;
                if (/>/) {
                        ($gene)=$_=~/gene\:(.*?)\./;
                        $hash1{$gene}++;
                        push @genes, $gene;
                } else {
                        my $time=$hash1{$gene};
                        $hash2{$gene}->{$time} .= $_;
                        my $seq=$hash2{$gene}->{$time};
                        my $len=length($seq);
                        $hash3{$gene}->{$time}={
                                len => $len,
                                seq => $seq
                        };
                }
        }
        return(\@genes, \%hash1, \%hash3);
}

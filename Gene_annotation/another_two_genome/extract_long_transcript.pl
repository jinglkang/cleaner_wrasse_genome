#!/usr/bin/perl
use strict;
use warnings;

# Extract the longest transcript for each gene based on sequences

# concatenate the sequences
my @names;
my $name;
my %hash;
(my $name1)=$ARGV[0]=~/(.*)\./;
#open FIL, "braker2+3_combined_renamed.aa.fa" or die "$!\n";
open FIL, "$ARGV[0]" or die "$!\n";
while (<FIL>) {
        chomp;
        if (/>/) {
                $name=$_;
                push @names, $name;
        } else {
                $hash{$name}.=$_;
        }
}
close FIL;

my $conca=$name1.".conca.fasta";
#open FIL1, ">braker2+3_combined_renamed.aa.conca.fa" or die "$!\n";
open FIL1, ">$conca" or die "$!\n";
foreach my $name (@names) {
        print FIL1 "$name\n$hash{$name}\n";
}
close FIL1;

my %hash1;
my ($gene, $tran);
my @genes;
#open FIL2, "braker2+3_combined_renamed.aa.conca.fa" or die "$!\n";
open FIL2, "$conca" or die "$!\n";
while (<FIL2>) {
        chomp;
        if (/>/) {
                s/>//;
                my @a=split;
                $tran=$a[0];
                ($gene)=$a[1]=~/gene=(.*)/;
                push @genes, $gene;
        } else {
                if ($hash1{$gene}) {
                        my $len_new=length $_;
                        my $len_old=$hash1{$gene}->{'length'};
                        if ($len_new >= $len_old) {
                                $hash1{$gene}={
                                        tran => $tran,
                                        seq  => $_,
                                        length => $len_new
                                };
                        }
                } else {
                        my $len=length $_;
                        $hash1{$gene}={
                                tran => $tran,
                                seq  => $_,
                                length => $len
                        };
                }
        }
}
close FIL2;

my $long=$name1.".conca.long.fasta";
my %hash2;
open FIL3, ">$long" or die "$!\n";
@genes = grep { ++$hash2{$_} < 2 } @genes;
foreach my $gene (@genes) {
        my $tran=$hash1{$gene}->{'tran'};
        my $len=$hash1{$gene}->{'length'};
        my $seq=$hash1{$gene}->{'seq'};
        my $header=">".$tran." gene=".$gene;
        print FIL3 "$header\n$seq\n" unless $seq=~/\./;
}
close FIL3;

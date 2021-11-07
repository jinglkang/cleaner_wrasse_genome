#!/usr/bin/perl
use strict;
use warnings;

# extract single cope orthologues to construct a phylogenetic tree

# dump.blast_output.mci.I30: gene id per species per gene family
my $i; my %gene_family;
open FIL1, "dump.blast_output.mci.I30" or die "can not open dump.blast_output.mci.I30\n";
while (<FIL1>) {
        chomp;
        $i++;
        $gene_family{$i}=$_;
}

# makeblastdb_input.2.fa: the input fasta file of blastp
my $gene; my %seq;
open FIL2, "makeblastdb_input.2.fa" or die "can not open makeblastdb_input.2.fa\n";
while (<FIL2>) {
        chomp;
        if (/>/) {
                s/>//;
                $gene=$_;
        } else {
                $seq{$gene}.=$_;
        }
}

mkdir "single_copy";
# filtered_cafe_input.txt: gene family id and the numbers in each gene family
open FIL3, "filtered_cafe_input.txt" or die "can not open filtered_cafe_input.txt\n";
while (<FIL3>) {
        chomp;
        next if /^Desc/;
        my @b;
        my @a=split;
        for (my $j = 2; $j < @a; $j++) {
                push @b, $a[$j] if $a[$j]==1;
        }
        if (@b==12) {
                my $id=$a[1];
                my $name="single_copy/gene_family_".$id.".fasta";
                open FIL4, ">$name" or die "can not create $name\n";
                my @genes=split /\s+/, $gene_family{$id};
                foreach my $gene (@genes) {
                        print FIL4 ">$gene\n$seq{$gene}\n";
                }
                my $align="single_copy/gene_family_".$id.".align.fasta";
                system("muscle -in $name -out $align");
                system("mv $align $name");
        }
        close FIL4;
}

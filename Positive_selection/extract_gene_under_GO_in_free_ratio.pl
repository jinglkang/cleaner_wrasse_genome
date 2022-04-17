#!/usr/bin/perl -w
use strict;
use warnings;

my %gene;
open "fil0", "/Users/kangjingliang/Documents/2021/Cleaner_wrasse/gene_expression/Gene_annotation.final.txt";
while (<fil0>) {
        chomp;
        my @a=split /\t/;
        $gene{$a[0]}=$a[2]."\t".$a[3];
}

my (%GO,%num);
open "fil1", "/Users/kangjingliang/Documents/2022/Ldim_genome/PSGs/Ldim_kaks_enrichment.txt" or die "$!\n"; # the enrichment result file
while (<fil1>) {
        chomp;
        my @a=split /\t/;
        $GO{$a[2]}=$a[-1];
        $num{$a[2]}=$a[-2];
}

my %hash;
open "fil2", "$ARGV[0]" or die "$!\n"; # the GO function name that to be extracted the underlying genes
while (<fil2>) {
        chomp;
        my $go_name=$_;
#        my $gene_num=$num{$go_name};
#        print "$go_name\t$gene_num\n" if $GO{$go_name};
        if ($GO{$go_name}) {
                my $gene_set=$GO{$go_name};
                my @genes=split /;/, $gene_set;
                foreach my $gene (@genes) {
#                        my $ano_gene=$gene{$gene};
#                        print "$ano_gene\n";
                         $hash{$gene}=1;
                }
        }
#        print "\n";
}

my $orth="final_orth.txt.1";
my %ORTH;
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
    chomp;
    my @a=split;
    $ORTH{$a[0]}=$a[-1]; # get the gene id of Ldim
}

open "fil3", "/Users/kangjingliang/Documents/2022/Ldim_genome/PSGs/free_ratio_result_Labridae.txt";
while (<fil3>) {
        chomp;
        s/\r//g;
        s/Ldim/1Ldim/g;s/Tbif/2bTif/g;s/Smel/3Smel/g;s/Lber/4Lber/g;s/Cund/5Cund/g;s/Ncel/6Ncel/g;
        print "$_\tGene_name\tGene_description\n" if /^Orth_id/;
        next if /^Orth_id/;
        my @a=split;
        my $info;
        for (my $i = 0; $i < @a; $i++) {
                $info.=$a[$i]."\t";
        }
        $info=~s/\s+$//;
        my $gene=$ORTH{$a[0]};
        if ($hash{$gene}) {
                my $ano_gene=$gene{$gene};
                print "$info\t$ano_gene\n";
        }
}

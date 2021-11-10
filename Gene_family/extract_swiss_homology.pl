#! /usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

my $usage=<<_EOH_;;
------------------------------------------------------------------------------------------
This script is to remove gene families without homology in the swiss-prot and that were
annotated with different genes.

Usage:
extract_anno --anno braker2+3_combined_renamed.aa.long.anno.final.txt \
--gene_family dump.blast_output.mci.I30 \
--key_word Ldim

Input files:

1. --anno braker2+3_combined_renamed.aa.long.anno.final.txt
Ldim_g1 qcov="100.00";scov="57.07";identity="65.487";qlenth="113";slenth="198";db_accession="P30626";db="swiss-prot"    symbol="SRI"    Name="Sorcin [Homo sapiens]"

2. --gene_family dump.blast_output.mci.I30
Cund-LOC121506852       Lber-LOC109994149       Lber-LOC110002147       Lber-LOC109978744       Lber-LOC110003597       Lber-LOC109976905       Lber-LOC110002638       Lber-LOC110004470       Lber-LOC1099
94412       Lber-LOC109976086


                                                                                        Kang 2021-11-10
------------------------------------------------------------------------------------------
_EOH_
;

GetOptions(
        'anno:s', \ my $anno,   # the annotaion file, e.g., braker2+3_combined_renamed.aa.long.anno.final.txt
        'gene_family:s', \ my $family, # the gene family file includes what genes in each gene family, e.g., dump.blast_output.mci.I30
        'key_word:s', \my $word, # the word use to search the gene in gene family file
        'help', \ my $help
        );

if ($help || (! $family) || (! $anno)) {
        die $usage; # all of these options are mandatory requirements
}

my %annotation;
open ANNO, "$anno" or die "There is no $anno\n";
while (<ANNO>) {
        if (/db=\"swiss-prot\"/) {
                my @a=split;
                my $gene=$a[0];
                (my $symbol)=$a[2]=~/symbol=\"(.*?)\"/;
                $annotation{$gene}=$symbol;
        }
}

my $id;
open FAMILY, "$family" or die "There is no $family\n";
while (<FAMILY>) {
        chomp;
        $id++;
        my @a=split;
        my $symbol;
        my $j;
        my $flag=0;
        if (/${word}/i) {
                for (my $i = 0; $i < @a; $i++) {
                        if ($a[$i]=~/${word}/i) {
                                last if ! $annotation{$a[$i]};
                                $j++;
                                $symbol=$annotation{$a[$i]} if $j==1;
                                if ($symbol ne $annotation{$a[$i]}){
                                        last; $flag=0;
                                } else {
                                        $flag=1;
                                }
                        }
                }
                if ($flag) {
                        print "$id\t$_\n";
                }
        } else {
                print "$id\t$_\n";
        }
}

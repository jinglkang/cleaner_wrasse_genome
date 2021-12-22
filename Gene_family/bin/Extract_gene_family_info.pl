#! /usr/bin/perl
use strict;
use warnings;

my @cols; my $header="Family_ID"."\t";
my %hash;
open SUMMARY, "summary_run2_anc.txt" or die "can not open summary_run2_anc.txt\n";
while (<SUMMARY>) {
        chomp;
        my @a=split /\t/;
        if (/^Family/) {
                for (my $i = 0; $i < @a; $i++) {
                        if ($a[$i]=~/(\D+)\<\d+\>/) {
                                my $spe=$1;
                                push @cols, $i;
                                $header.=$spe."\t";
                        }
                }
                $header=~s/\s+$//;
        } else {
                my $info;
                my $id=$a[0];
                foreach my $col (@cols) {
                        $info.=$a[$col]."\t";
                }
                $info=~s/\s+$//;
                $hash{$id}=$info;
        }
}

my %annotation;
open ANNO, "$ARGV[0]" or die "There is no $ARGV[0]\n";
while (<ANNO>) {
        if (/db=\"swiss-prot\"/) {
                my @a=split;
        my $gene=$a[0];
        my $symbol;
        $symbol=$1."\t".$2 if $_=~/symbol=\"(.*?)\"\s+Name=\"(.*?)\"/;
        $annotation{$gene}=$symbol;
    }
}

my %family; my $id;
open FIL1, "$ARGV[1]" or die "There is no $ARGV[1]\n"; # Get the whole gene family id
while (<FIL1>) {
        chomp;
        $id++;
        my @a=split;
        if (/${ARGV[2]}/i) {
                for (my $i = 0; $i < @a; $i++) {
                        if ($a[$i]=~/${ARGV[2]}/i) {
                                my $symbol=$annotation{$a[$i]};
                                $family{$id}=$symbol;
                                last;
                        }
                }
        }
}

print "$header\tGene_Name\tDescription\n";
open FIL2, "$ARGV[3]" or die "There is no $ARGV[3]\n";
while (<FIL2>) {
        chomp;
        print "$_\t$hash{$_}\t$family{$_}\n" if $family{$_};
}

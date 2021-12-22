#! /usr/bin/perl
use strict;
use warnings;
use List::Util qw(min max);

my @cols; my $header="Family_ID"."\t";
my (%hash1, %hash2, %hash3);
my @spe=qw (Spottedgar Zebrafish Platyfish Medaka Stickleback Fugu Ncel Cund Smel Lber Tbif Ldim);
open RESULT, ">result";
open SUMMARY, "summary_run2_anc.txt" or die "can not open summary_run2_anc.txt\n";
while (<SUMMARY>) {
        chomp;
        my @a=split /\t/;
        if (/^Family/) {
                for (my $i = 0; $i < @a; $i++) {
                        if ($a[$i]=~/(\D+)\<\d+\>/) {
                                my $spe=$1;
                                $hash1{$spe}=$i;
                                #$header.=$spe."\t";
                        }
                }
                foreach my $spe (@spe) {
                        $header.=$spe."\t";
                }
                $header=~s/\s+$//;
#                print "$header\n";
        } else {
                my $info;
                my $id=$a[0];
                foreach my $spe (@spe) {
                        my $col=$hash1{$spe};
                        $hash3{$spe}=$a[$col];
                        $info.=$a[$col]."\t";
                }
                $info=~s/\s+$//;
                $hash2{$id}=$info;
                my $ob=$hash3{'Ldim'};
                my $ju=$hash3{'Tbif'};
                my @Fa;
                push @Fa, $hash3{'Smel'};
                push @Fa, $hash3{'Lber'};
                my @Nm;
                push @Nm, $hash3{'Ncel'};
                push @Nm, $hash3{'Cund'};
                my $zebra=$hash3{'Zebrafish'};
                my $fa=max(@Fa);
                my $nm=max(@Nm);
                if ($ob>=$ju && $ju>=$fa && $fa>$nm && $zebra>0 && $ob>=3) {
                        print RESULT "$id\t$hash2{$id}\n";
                }
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
close RESULT;
open FIL2, "result" or die "There is no result\n";
while (<FIL2>) {
        chomp;
        my @a=split;
        print "$_\t$family{$a[0]}\n" if $family{$a[0]};
}
`rm result`;

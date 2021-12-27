#! /usr/bin/perl
use strict;
use warnings;
use List::Util qw(min max);

my @cols; my $header="Family_ID"."\t";
my (%hash1, %hash2, %hash3);
my @cleaner=qw (Smel Lber Tbif Ldim);
my @noclean=qw (Spottedgar Zebrafish Platyfish Medaka Stickleback Fugu Ncel Cund);
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
                my @nums;
                foreach my $spe (@spe) {
                        my $col=$hash1{$spe};
                        $hash3{$spe}=$a[$col];
                        $info.=$a[$col]."\t";
                        unless ($spe eq $ARGV[2]) {
                                push @nums, $hash3{$spe};
                        }
                }
                $info=~s/\s+$//;
                $hash2{$id}=$info;

#                my $ob=$hash3{$ARGV[2]};

                my @nm_clean;
                foreach my $cleaner (@cleaner) {
                        my $nb=$hash3{$cleaner};
                        push @nm_clean, $nb;
                }
                my $nm_clean_min=min(@nm_clean);

                my @nm_nonclean;
                foreach my $noclean (@noclean) {
                        my $nb=$hash3{$noclean};
                        push @nm_nonclean, $nb;
                }
                my $nm_noclean_max=max(@nm_nonclean);

                my $zebra=$hash3{'Zebrafish'};
#                my $nm=max(@nums);
                if ($nm_clean_min>$nm_noclean_max && $zebra>0) {
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

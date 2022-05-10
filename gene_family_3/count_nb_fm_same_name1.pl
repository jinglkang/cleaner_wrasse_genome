#!/usr/bin/perl -w
use strict;
use warnings;

my $header="Family_id\tOrthogroup_id\t";
my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Spul Tads Tbif Ldim);
foreach my $spe (@spes) {
        $header.=$spe."\t";
}
$header=~s/\s+$//;
print "$header\tgene_name\tgene_description\n";

my $fm="fm_same_name.txt";
open FM, $fm or die "can not open $fm\n";
while (<FM>) {
        chomp;
        my %hash;
        my @a=split /\t/;
        my $fm=$a[0];
        my @genes=split /\,/, $a[-1];
        foreach my $gene (@genes) {
                my ($spe)=$gene=~/(.*?)\_/;
                $hash{$spe}++;
        }
        my $info;
        foreach my $spe (@spes) {
                my $nm;
                $hash{$spe}?($nm=$hash{$spe}):($nm=0);
                $info.=$nm."\t";
        }
        $info=~s/\s+$//;
        print "$fm\t$a[1]\t$info\t$a[-3]\t$a[-2]\n";
}

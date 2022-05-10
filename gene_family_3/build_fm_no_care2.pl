#!/usr/bin/perl -w
use strict;
use warnings;

my $ano="/media/HDD/cleaner_fish/genome/gene_family_3/all_species_swiss_ano.txt";
my %ano;
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
        chomp;
        my @a=split /\t/;
        $ano{$a[0]}=$a[-2]." (".$a[-1].")";
}

my $i=-1;
my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Spul Tads Tbif Ldim);
my $header="Family_id\t";
foreach my $spe (@spes) {
        $header.=$spe."\t";
}
$header=~s/\s+$//;
print "$header\n";

my $orth="/media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups/Orthogroups.tsv";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
        chomp;
        next if /^Orthogroup/;
        $i++;
        my $j=sprintf ("%05d", $i);
        my $fm="Family".$j;
        my @a=split /\t/;
        my $orth_id=$a[0];
        my $gene_id;
        my (%hash1, %hash2, %spe_nb);
        my $annot;
        for (my $i = 1; $i < @a; $i++) {
                $a[$i]=~s/\s+//g;
                my @genes;
                @genes=split /\,/, $a[$i];
                foreach my $gene (@genes) {
                        my ($spe)=$gene=~/(.*)\_/;
                        $spe_nb{$spe}++;
                        $annot=$ano{$gene};
                        $hash1{$annot}++;
                        $gene_id.=$gene.",";
#                       $hash2{$annot}.=$gene.",";
                }
        }
        $gene_id=~s/\,$//;
        my $info1;
        foreach my $spe (@spes) {
                my $nb;
                $spe_nb{$spe}?($nb=$spe_nb{$spe}):($nb=0);
#               my $nb=$spe_nb{$spe};
                $info1.=$nb."\t";
        }
        $info1=~s/\s+$//;
        my $info2;
        foreach my $key (sort {$hash1{$a} <=> $hash1{$b}} keys %hash1) {
#               $i++;
                my $value=$hash1{$key};
                $info2.=$value.": ".$key."; ";
#               my $genes=$hash2{$key};
#               $genes=~s/\,$//;
#               my $j=sprintf ("%04d", $i);
#               my $fm="Family".$j;
#               print "$fm\t$value\t$key\t$genes\n";
        }
        $info2=~s/\;\s+$//;
        print "$fm\t$info1\n";
}

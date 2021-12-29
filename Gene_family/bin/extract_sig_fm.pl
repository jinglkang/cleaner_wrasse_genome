#!/usr/bin/perl -w
use strict;
use warnings;
use List::MoreUtils qw(uniq);

# working dir: /media/HDD/cleaner_fish/genome/gene_family_2/reports_2

# get the anno info per gene family using Zebrafish anno info
# Zebrafish anno info: /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation/Zebrafish_gene.txt
# gene per family: /media/HDD/cleaner_fish/genome/gene_family_2/dump.blast_output.mci.I30

my %zebra;
my $zebra_ano="/media/HDD/cleaner_fish/genome/gene_family_2/all_annotation/Zebrafish_gene.txt";
open ZEBRA, "$zebra_ano" or die "There is no $zebra_ano\n";
while (<ZEBRA>) {
        chomp;
        my @a=split /\t/;
        next if /^Gene/;
        my $id="Zebrafish_".$a[0];
        my $info;
        for (my $i = 1; $i < @a; $i++) {
                $info.=$a[$i]."\t";
        }
        $info=~s/\s+$//;
        $zebra{$id}=$info;
}

my %family;
my $fam="/media/HDD/cleaner_fish/genome/gene_family_2/dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        $k++;
        my @a=split;
        next if ! /Zebrafish/i;
        for (my $i = 0; $i < @a; $i++) {
                if ($a[$i]=~/Zebrafish/i) {
                        $family{$k}=$zebra{$a[$i]};
#                       print "$k\t$family{$k}\n";
                        last;
                }
        }
}

# gene nb per gene family: /media/HDD/cleaner_fish/genome/gene_family_2/reports_2/summary_run2_anc.txt
my $header; my %nb;
my $nb_fm="/media/HDD/cleaner_fish/genome/gene_family_2/reports_2/summary_run2_anc.txt";
open NB, "$nb_fm" or die "There is no $nb_fm\n";
while (<NB>) {
        chomp;
        my @a=split;
        if (/^Family/) {
                $header=$_;
        } else {
                my $info;
                my $id=$a[0];
                for (my $i = 1; $i < @a; $i++) {
                        $info.=$a[$i]."\t";
                }
                $info=~s/\s+$//;
                $nb{$id}=$info;
        }
}

# sig. expansion and contraction gene family: /media/HDD/cleaner_fish/genome/gene_family_2/reports_2/summary_run2_fams.txt
my $sig_fm="/media/HDD/cleaner_fish/genome/gene_family_2/reports_2/summary_run2_fams.txt";
open SIG, "$sig_fm" or die "There is no $sig_fm\n";
while (<SIG>) {
        chomp;
        next if /^#|^Overall|^\</;
        my @a=split;
        (my $spe)=$a[0]=~/(\D+)\</;
        my $file=$spe.".sig.fm.txt";
        my $header_new=$header."\tFLAG\tCHANGE\tGene_name\tGene_description";
        open SPE, ">$file" or die "can not create $file\n";
        print SPE "$header_new\n";
        my @b=split /\,/, $a[1];
        for (my $i = 0; $i < @b; $i++) {
                if ($b[$i]=~/(\d+)\[(\+|\-)(\d+)\*\]/){
                        my ($id, $flag, $change)=($1, $2, $3);
                        my $ano=$family{$id};
                        my $nb=$nb{$id};
                        if ($flag eq "+") {
                                my $wd="expansion";
                                print SPE "$id\t$nb\t$wd\t+$change\t$ano\n";
                        } elsif ($flag eq "-") {
                                my $wd="contraction";
                                print SPE "$id\t$nb\t$wd\t-$change\t$ano\n";
                        }
                }
        }
        close SPE;
}

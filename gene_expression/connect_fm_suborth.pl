#!/usr/bin/perl -w
use strict;
use warnings;

my %family;
my $fam="dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
    chomp;
    $k++;
    my @a=split;
    my $id="Family_".$k;
    for (my $i = 0; $i < @a; $i++) {
        $family{$a[$i]}=$id;
    }
}

my %same; # make sure all of the genes in the sub-orthogroups were in the same gene family
my $orth="final_orth.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
        chomp;
        my %ids;
        my @a=split;
        my $orth_id=$a[0];
#       my $info.=$orth_id."\t";
        for (my $i = 1; $i < @a; $i++) {
                my $id;
                $family{$a[$i]}?($id=$family{$a[$i]}):($id="None");
                $ids{$id}++;
#               $info.=$id."\t";
        }
#       $info=~s/\s+$//;
        my $nb=keys %ids;
#       print "$info\n" if $nb > 1;
        my $Ldim=$a[-1]; # the gene id of Ldim
        if ($nb==1) {
                $same{$orth_id}={
                        'Ldim' => $Ldim,
                        'Fm'   => $family{$Ldim}
                };
        }
}

my $sub_orth="Positive_sub_orth.txt";
open SUB, $sub_orth or die "can not open $sub_orth\n";
while (<SUB>) {
        chomp;
        if ($same{$_}) {
                print "$same{$_}->{'Fm'}\n";
        }
}

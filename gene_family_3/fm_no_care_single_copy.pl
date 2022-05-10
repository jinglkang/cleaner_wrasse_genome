#!/usr/bin/perl -w
use strict;
use warnings;


my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Spul Tads Tbif Ldim);

my $fasta="/media/HDD/cleaner_fish/genome/gene_family_3/all.fasta";
my %seq; my $gene;
open FASTA, $fasta or die "can not open $fasta\n";
while (<FASTA>) {
        chomp;
        if (/>/) {
                s/>//;
                $gene=$_;
        } else {
                $seq{$gene}.=$_;
        }
}
close FASTA;

my $nb="fm_no_care_nb_ano.txt";
system("mkdir fm_no_care_single_copy") unless -e "fm_no_care_single_copy";
open NB, $nb or die "can not open $nb\n";
while (<NB>) {
        chomp;
        my @a=split /\t/;
        next if /^Family_id/;
        my $j;
        for (my $i = 2; $i <= 15; $i++) {
                $j++ if $a[$i]==1;
        }
        if ($j && $j==14) {
                my %spe_seq;
                my @genes=split /\,/, $a[-1];
                my $fasta1="fm_no_care_single_copy/$a[0].fasta";
                open FASTA1, ">$fasta1" or die "can not create $fasta1\n";
                foreach my $gene (@genes) {
                        (my $spe)=$gene=~/(.*)\_/;
                        (my $seq)=$seq{$gene};
                        $spe_seq{$spe}={
                                'gene' => $gene,
                                'seq'  => $seq
                        };
                }
                foreach my $spe (@spes) {
                my $gene=$spe_seq{$spe}->{'gene'};
                my $seq=$spe_seq{$spe}->{'seq'};
                print FASTA1 ">$gene\n$seq\n";
                }
                my $align="fm_same_name_single_copy/$a[0].align.fasta";
                system("muscle -in $fasta1 -out $align");
                system("mv $align $fasta1");
                close FASTA1;
        }
}
close NB;

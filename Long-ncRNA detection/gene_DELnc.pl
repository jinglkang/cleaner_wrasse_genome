#!/usr/bin/perl -w
use strict;
use warnings;

my $Lnc_RNA="final_intergenic_LncRNA_classifier.txt";
my (%Lnc_RNA, %RNA_Lnc, %DE_LncRNA_FB, %DE_LncRNA_HB, %DE_LncRNA_MB);
open Lnc_RNA, $Lnc_RNA or die "can not open $Lnc_RNA\n";
while (<Lnc_RNA>) {
        chomp; next if /^lncRNA_gene/;
        my @a=split /\t/;
        $a[0]=~s/\s+$//;
        $Lnc_RNA{$a[0]}.=$a[2]."\t";
        $RNA_Lnc{$a[2]}.=$a[0]."\t";
}

my $DE_LncRNA_FB="LncRNA_FB_Interaction_Solo.DEGs.txt";
my $DE_LncRNA_HB="LncRNA_HB_Interaction_Solo.DEGs.txt";
my $DE_LncRNA_MB="LncRNA_MB_Interaction_Solo.DEGs.txt";

my @genes;
open DE_LncRNA_FB, $DE_LncRNA_FB or die "can not open $DE_LncRNA_FB\n";
while (<DE_LncRNA_FB>) {
        chomp;
        $DE_LncRNA_HB{$_}="FB";
        if ($Lnc_RNA{$_}) {
                my $gene1=$Lnc_RNA{$_};
                $gene1=~s/\s+$//;
                my @gene1=split /\t/, $gene1;
                foreach my $gene (@gene1) {
                        push @genes, $gene;
                }
        }
}

open DE_LncRNA_HB, $DE_LncRNA_HB or die "can not open $DE_LncRNA_HB\n";
while (<DE_LncRNA_HB>) {
        chomp;
        $DE_LncRNA_HB{$_}="HB";
        if ($Lnc_RNA{$_}) {
                my $gene1=$Lnc_RNA{$_};
                $gene1=~s/\s+$//;
                my @gene1=split /\t/, $gene1;
                foreach my $gene (@gene1) {
                        push @genes, $gene;
                }
        }
}

open DE_LncRNA_MB, $DE_LncRNA_MB or die "can not open $DE_LncRNA_MB\n";
while (<DE_LncRNA_MB>) {
        chomp;
        $DE_LncRNA_MB{$_}="MB";
        if ($Lnc_RNA{$_}) {
                my $gene1=$Lnc_RNA{$_};
                $gene1=~s/\s+$//;
                my @gene1=split  /\t/, $gene1;
                foreach my $gene (@gene1) {
                        push @genes, $gene;
                }
        }
}

my %DEGs_nb;
foreach my $gene (@genes) {
        $DEGs_nb{$gene}++;
}

foreach my $gene (keys %DEGs_nb) {
        my $RNA_Lnc=$RNA_Lnc{$gene};
        $RNA_Lnc=~s/\s+$//;
        my @Lnc=split /\t/, $RNA_Lnc;
        my $nb=@Lnc;
        my $info;
        foreach my $Lnc (@Lnc) {
                my ($DE_LncRNA_HB, $DE_LncRNA_MB, $DE_LncRNA_FB);
                $DE_LncRNA_HB{$Lnc}?($DE_LncRNA_HB =$DE_LncRNA_HB{$Lnc}):($DE_LncRNA_HB="-");
                $DE_LncRNA_MB{$Lnc}?($DE_LncRNA_MB =$DE_LncRNA_MB{$Lnc}):($DE_LncRNA_MB="-");
                $DE_LncRNA_FB{$Lnc}?($DE_LncRNA_FB =$DE_LncRNA_FB{$Lnc}):($DE_LncRNA_FB="-");
                $info.=$DE_LncRNA_HB.", ".$DE_LncRNA_MB.", ".$DE_LncRNA_FB."; "
        }
        $info=~s/;\s+$//;
        print "$gene\t$nb\t$info\n";
}

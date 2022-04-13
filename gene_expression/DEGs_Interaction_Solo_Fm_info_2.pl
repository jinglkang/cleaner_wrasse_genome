#!/usr/bin/perl -w
use strict;
use warnings;

# this script is to extract the genes whether they are DEGs in FB, HB, MB
# or nearby LncRNAs with differential expression in FB, HB, MB
# or their gene family is expasion or contraction
# or their family showing positively selection

my %zebra;
my $zebra_ano="Zebrafish_gene.txt";
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
    $info.="\t-" if @a==2;
    $zebra{$id}=$info;
}

my $Ldim_ano="Gene_annotation.final.txt"; my %Ldim;
open LDIM_ANO, $Ldim_ano or die "can not open $Ldim_ano\n";
while (<LDIM_ANO>) {
        chomp; my @a=split /\t/;
        my $id=$a[0];
        $Ldim{$id}="$a[-2] \($a[3]\)";
}

my @genes;
my $DEGs_FB="gtf_FB_Interaction_Solo.DEGs.txt";
my $DEGs_HB="gtf_HB_Interaction_Solo.DEGs.txt";
my $DEGs_MB="gtf_MB_Interaction_Solo.DEGs.txt";

my (%DEGs_FB, %DEGs_HB, %DEGs_MB);
open DEGs_FB, $DEGs_FB or die "can not open $DEGs_FB\n";
while (<DEGs_FB>) {
        chomp;
        $DEGs_FB{$_}="FB";
        push @genes, $_;
}

open DEGs_HB, $DEGs_HB or die "can not open $DEGs_HB\n";
while (<DEGs_HB>) {
        chomp;
        $DEGs_HB{$_}="HB";
        push @genes, $_;
}

open DEGs_MB, $DEGs_MB or die "can not open $DEGs_MB\n";
while (<DEGs_MB>) {
        chomp;
        $DEGs_MB{$_}="MB";
        push @genes, $_;
}

my (%family, %fm_Ldim);
my $fam="dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
    chomp;
    $k++;
    my @a=split;
    next if ! /Zebrafish/i;
    for (my $i = 0; $i < @a; $i++) {
        if ($a[$i]=~/Zebrafish/i) {
                my $id="Family_".$k;
                $family{$id}=$zebra{$a[$i]};
            last;
        }
    }
    for (my $i = 0; $i < @a; $i++) {
        if ($a[$i]=~/Ldim/i) {
                $fm_Ldim{$a[$i]}="Family_".$k;
        }
    }
}

my %DEGs_nb;
foreach my $gene (@genes) {
        $DEGs_nb{$gene}++;
}

my $FM="Exp_cont_Fm_Ldim.txt";
my %FM;
open FM, $FM or die "can not open $FM\n";
while (<FM>) {
        chomp;
        my @a=split /\t/;
        $FM{$a[0]}=$a[1]."\t".$a[2];
}

my $pos="Positive_sub_orth_fm.txt";
my %POS;
open POS, $pos or die "can not open $pos\n";
while (<POS>) {
        chomp;
        $POS{$_}++;
}

print "Gene\tGene_ano\tDEG_nb\tDEG_Info\tFm_id\tFm_name\tFm_ano\tEp_Ct\tEp_Ct_nb\tPos\n";
foreach my $gene (keys %DEGs_nb) {
        my $gene_ano=$Ldim{$gene};
        my ($fm_id, $fm_ano);
        $fm_Ldim{$gene}?($fm_id   =$fm_Ldim{$gene}):($fm_id   ="-");
        ($fm_id !~ /-/)?($fm_ano  =$family{$fm_id}):($fm_ano  ="-\t-");
        my $DEG_nb  =$DEGs_nb{$gene};
        my ($DEGs_FB, $DEGs_HB, $DEGs_MB, $info, $fm, $pos);
        $FM{$fm_id}    ?($fm      =$FM{$fm_id}):($fm="-\t-");
        $POS{$fm_id}   ?($pos     ="Positive"):($pos="-");
        $DEGs_HB{$gene}?($DEGs_HB =$DEGs_HB{$gene}):($DEGs_HB="-");
        $DEGs_MB{$gene}?($DEGs_MB =$DEGs_MB{$gene}):($DEGs_MB="-");
        $DEGs_FB{$gene}?($DEGs_FB =$DEGs_FB{$gene}):($DEGs_FB="-");
        if ($DEGs_HB !~ /-/ || $DEGs_MB !~ /-/ || $DEGs_FB !~ /-/) {
                $info=$DEGs_HB."; ".$DEGs_MB."; ".$DEGs_FB;
        }
        print "$gene\t$gene_ano\t$DEG_nb\t$info\t$fm_id\t$fm_ano\t$fm\t$pos\n";
}

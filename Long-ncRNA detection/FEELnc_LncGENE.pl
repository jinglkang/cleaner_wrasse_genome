#!/usr/bin/perl
use strict;
use warnings;

my (%gene, %tran, %gene_info, %lnc, %pot);
my @genes;

open FEELNC, "Ldim.classifier.txt";
while (<FEELNC>) {
        chomp;
        next if /^isBest/ || /^0/;
        my @a=split;
        my $gene=uc($a[1]);
        my $tran=uc($a[2]);
        $lnc{$gene}.=$tran."\t";
}

open COD, "codpot/Ldim.codpot_RF.txt";
while (<COD>) {
        chomp;
        my @a=split;
        my $tran=uc($a[0]);
        $pot{$tran}=$a[-2];
}

open GTF, "all_inds.gtf" or die "can not open all_inds.gtf\n";
while (<GTF>) {
        chomp;
        my @a=split;
        if (/^#/) {
                next;
        } elsif ($a[2] eq "transcript") {
                (my $gene)=$_=~/gene_id\s+\"(.*?)\"/;
                $gene=uc($gene);
                (my $tran)=$_=~/transcript_id\s+\"(.*?)\"/;
                $tran=uc($tran);
                $gene{$gene}++; $tran{$tran}++;
                push @genes, $gene if $gene{$gene}==1;
                if ($gene_info{$gene}) {
                        my $tran_num_old=$gene_info{$gene}->{'tran_num'};
                        my $tran_old=$gene_info{$gene}->{'tran'};
                        my $tran_num_new=$tran_num_old + 1;
                        my $tran_new=$tran_old."\t".$tran;
                        $gene_info{$gene}={
                                'tran_num' => $tran_num_new,
                                'tran' => $tran_new
                        }
                } else {
                        $gene_info{$gene}={
                                'tran_num' => 1,
                                'tran' => $tran
                        }
                }
        }
}

my $gene_num=keys %gene;
my $tran_num=keys %tran;

# print "$gene_num\t$tran_num\n";

# open OUTPUT, ">CPAT_all_trans_nc.txt";
foreach my $gene (@genes) {
        my $num=$gene_info{$gene}->{'tran_num'};
        my $tran=$gene_info{$gene}->{'tran'};
        my @tran=split /\t/, $tran;
        if ($lnc{$gene}) {
                my @tran_new=split /\t/, $lnc{$gene};
                my $tran_num_old=@tran;
                my $tran_num_new=@tran_new;
                if ($tran_num_old == $tran_num_new) {
                        my $info;
                        foreach my $tra (@tran) {
                                my $cod_pot=$pot{$tra};
                                #                               die "no coding potential for $tra" if $cod_pot;
                $info.=$tra." ($cod_pot)"."; ";
            }
            $info=~s/\;\s+$//;
            print "$gene\t$num\t$num\t$info\n";
#                       print "$gene\t$tran_num_old\t$tran\n";
                }
        }
}

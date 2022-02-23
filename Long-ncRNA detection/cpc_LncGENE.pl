#!/usr/bin/perl
use strict;
use warnings;

my (%gene, %tran, %gene_info, %coding, %lable);
my @genes;

open CPC, "$ARGV[0]";
while (<CPC>) {
        chomp;
        my @a=split;
        next if /^ID/;
        my $tran=uc($a[0]);
        $coding{$a[0]}=$a[-2];
        $lable{$a[0]} =$a[-1];
}

open GTF, "$ARGV[1]" or die "can not open $ARGV[1]\n";
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

#print "$gene_num\t$tran_num\n";

#open OUTPUT, ">CPC_all_trans_nc.txt";
print "lncRNA_gene\tRNA_transcript_number_in_this_gene\tlncRNA_transcript_number_in_this_gene\tlncRNA_transcript (coding potential score)\n";
foreach my $gene (@genes) {
        my $num=$gene_info{$gene}->{'tran_num'};
        my $tran=$gene_info{$gene}->{'tran'};
        my @tran=split /\t/, $tran;
        my @tran_new;
        foreach my $tra (@tran) {
                my $cod_pot=$coding{$tra};
                if ($cod_pot && $lable{$tra} eq "noncoding") {
                        push @tran_new, $tra;
                }
        }
        my $tran_num_old=@tran;
        my $tran_num_new=@tran_new;
        if ($tran_num_old == $tran_num_new) {
                my $info;
                foreach my $tra (@tran) {
                        my $cod_pot=$coding{$tra};
                        $info.=$tra." ($cod_pot)"."; ";
                }
                        $info=~s/\;\s+$//;
                        print "$gene\t$num\t$num\t$info\n";
        }
}

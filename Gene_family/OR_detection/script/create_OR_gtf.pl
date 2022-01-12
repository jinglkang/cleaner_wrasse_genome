#!/usr/bin/perl -w
use strict;
use warnings;

# Putative OR genes: putative_OR_strand.txt
# Putative OR genes gff: putative_OR.gff
# Putative OR genes annotation: putative_OR.info
# genome gtf: braker2+3_combined_renamed.gtf

my $OR_ano="putative_OR.info";
my %info;
open OR_ANO, $OR_ano or die "can not open $OR_ano\n";
while (<OR_ANO>) {
    chomp; my @a=split /\t/;
    $a[0]=~s/\-/\:/;
    my @b=split /\:/, $a[0];
    my ($id, $start, $end, $strand, $gene, $anno, $str);
    $gene=$a[1]; $anno=$a[2]; $str=$b[3];
    if ($b[2] > $b[1]) {
        $strand="+";
        $start=$b[1]; $end=$b[2];
        $id   =$b[0]."\t".$start;
    } else {
        $strand="-";
        $start=$b[2]; $end=$b[1];
        $id   =$b[0]."\t".$start;
    }
    $gene=$a[1]; $anno=$a[2];
    $info{$id}={
            'gene'   => $gene,
            'start'  => $start,
            'end'    => $end,
            'strand' => $strand,
            'anno'   => $anno,
            'str'    => $str
    };
}

$/ = "\/\/";
# parse the gff file: putative_OR.gff
my $GFF="putative_OR.gff";
my $gene;
open GFF, $GFF or die "can not open $GFF\n";
while (<GFF>) {
    chomp;
    s/^\s+//; s/\s+$//;
    my @a=split /\n/;
    my ($strand, $id);
    if (@a>0) {
        for (my $i = 0; $i < @a; $i++) {
            my @b=split /\t/, $a[$i];
            my $info=$b[5]."\t".$b[6]."\t".$b[7];
            if ($i==0) {
                $strand=$b[6];
                ($strand eq "+")?($id=$b[0]."\t".$b[3]):($id=$b[0]."\t".$b[4]);
                last if ! $info{$id}->{'gene'} || $info{$id}->{'str'} ne "C";
                my $gene_id=$info{$id}->{'gene'};
                my $tran_id=$info{$id}->{'gene'}.".t1";
                my $anno      =$info{$id}->{'anno'};
                my $gene_info="gene_id \"$gene_id\"\; gene_description \"$anno\"\; gene_source \"Swiss-Prot\"\;";
                my $tran_info="transcript_id \"$tran_id\"\; gene_id \"$gene_id\"\;";
                if ($strand eq "+") {
                    print "$b[0]\tGeneWise\tgene\t$b[3]\t$b[4]\t$info\t$gene_info\n";
                    print "$b[0]\tGeneWise\ttranscript\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                    my $start=$b[3]; my $stop=$b[3]+2;
                    my $info1=".\t+\t0";
                    print "$b[0]\tGeneWise\tstart_codon\t$start\t$stop\t$info1\t$tran_info\n";
                    print "$b[0]\tGeneWise\tCDS\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                    print "$b[0]\tGeneWise\texon\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                    my $end_d=$b[4]; my $end_s=$b[4]-2;
                    print "$b[0]\tGeneWise\tstop_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                } else {
                    print "$b[0]\tGeneWise\tgene\t$b[4]\t$b[3]\t$info\t$gene_info\n";
                    print "$b[0]\tGeneWise\ttranscript\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                    my $start=$b[4]; my $stop=$b[4]+2;
                    my $info1=".\t-\t0";
                    print "$b[0]\tGeneWise\tstop_codon\t$start\t$stop\t$info1\t$tran_info\n";
                    print "$b[0]\tGeneWise\tCDS\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                    print "$b[0]\tGeneWise\texon\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                    my $end_d=$b[3]; my $end_s=$b[3]-2;
                    print "$b[0]\tGeneWise\tstart_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                }
            }
        }
    }
}

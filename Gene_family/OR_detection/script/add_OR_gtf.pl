#!/usr/bin/perl -w
use strict;
use warnings;

# Putative OR genes: putative_OR_strand.txt
# Putative OR genes gff: putative_OR.gff
# Putative OR genes annotation: putative_OR.info
# genome gtf: braker2+3_combined_renamed.gtf

my %Total_info;
my $GTF="braker2+3_combined_renamed.gtf";
open GTF, $GTF or die "can not open $GTF\n";
while (<GTF>) {
    chomp; my @a=split;
    if ($a[2] eq "gene") {
            my $id=$a[0]."\t".$a[3]."\t".$a[4];
            my $gene=$a[-1]; my $strand=$a[6];
            $Total_info{$id}={
                    'gene'   => $gene,
                    'strand' => $strand
            };
    }
}

my $OR="putative_OR_strand.txt";
my %info;
open OR, $OR or die "can not open $OR\n";
while (<OR>) {
    chomp; my @a=split;
    my @b=split /\:/, $a[0];
    my $id;
    my $strand=$b[3];
    my $struct=$b[4];
    ($strand eq "+")?($id=$b[0]."\t".$b[1]."\t".$b[2]):($id=$b[0]."\t".$b[2]."\t".$b[1]);
    my $gene=""; my $anno="";
    $info{$id}={
            'strand' => $strand,
            'struct' => $struct,
            'gene'   => $gene,
            'anno'   => $anno
    };
}

my $OR_ano="putative_OR.info";
open OR_ANO, $OR_ano or die "can not open $OR_ano\n";
while (<OR_ANO>) {
    chomp; my @a=split /\t/;
    $a[0]=~s/\-\D+//;
    my @b=split /\:/, $a[0];
#       my $id=$b[0]."\t".$b[1]."\t".$b[2];
    my $id;
    ($b[2] > $b[1])?($id=$b[0]."\t".$b[1]."\t".$b[2]):($id=$b[0]."\t".$b[2]."\t".$b[1]);
#       $info{$id}->{'gene'}=$a[1];
    my $gene=$a[1];
#       $info{$id}->{'anno'}=$a[2];
    my $anno=$a[2];
    my $gene_strand=$info{$id}->{'strand'};
    my $gene_str=$info{$id}->{'struct'};
     if ($Total_info{$id}) {
            my $gtf_gene=$Total_info{$id}->{'gene'};
            my $gtf_strand=$Total_info{$id}->{'strand'};
            die "It's not complete\n" if $gene_strand ne $gtf_strand;
#               print TXT "##EXIST\t$id\t$gtf_gene\t$gtf_strand\t$gene\t$gene_strand\t$gene_str\t$anno\n";
            if ($gene_str eq "C") {
                    $info{$id}->{'gene'}=$gtf_gene."|".$gene;
            }
    } else {
#               print TXT "##NONEX\t$id\tNon\tNon\t$gene\t$gene_strand\t$gene_str\t$anno\n";
            if ($gene_str eq "C") {
                    $info{$id}->{'gene'}=$gene;
                    $info{$id}->{'anno'}=$anno;
            }
    }
}

$/ = "\/\/";
# parse the gff file: putative_OR.gff
my $GFF="putative_OR.gff";
my $gene; my $j=28138;
open GFF, $GFF or die "can not open $GFF\n";
while (<GFF>) {
    chomp;
    s/^\s+//; s/\s+$//;
    my @a=split /\n/;
    my ($strand, $id);
    if (@a>0) {
            for (my $i = 0; $i < @a; $i++) {
#                       print "$a[$i]\t$i##\n";
                    my @b=split /\t/, $a[$i];
                    my $info=$b[5]."\t".$b[6]."\t".$b[7];
                    if ($i==0) {
                            $strand=$b[6];
                            ($strand eq "+")?($id=$b[0]."\t".$b[3]."\t".$b[4]):($id=$b[0]."\t".$b[4]."\t".$b[3]);
                            last if $Total_info{$id}->{'gene'};
                            last if ! $info{$id}->{'gene'};
                            $j++; my $gene_id="Ldim_g".$j;
                            my $tran_id="Ldim_g".$j.".t1";
                            my $gene_name=$info{$id}->{'gene'};
                          # $gene=$info{$id}->{'gene'};
                            my $anno      =$info{$id}->{'anno'};
                            my $gene_info="gene_id \"$gene_id\"\; gene_name \"$gene_name\"\; gene_description \"$anno\"\; gene_source \"Swiss-Prot\"\;";
                            my $tran_info="gene_id \"$gene_id\"\; transcript_id \"$tran_id\"\;";
                             if ($strand eq "+") {
                                    print "$b[0]\tGeneWise\tgene\t$b[3]\t$b[4]\t$info\t$gene_info\n";
                                    #my $tran=$gene.".t1";
                                    print "$b[0]\tGeneWise\ttranscript\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                                    my $start=$b[3]; my $stop=$b[3]+2;
                                    my $info1=".\t+\t0"; #my $info2="transcript_id \"$tran\"\; gene_id \"$gene\"\;";
                                    print "$b[0]\tGeneWise\tstart_codon\t$start\t$stop\t$info1\t$tran_info\n";
                                    print "$b[0]\tGeneWise\tCDS\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                                    print "$b[0]\tGeneWise\texon\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                                    my $end_d=$b[4]; my $end_s=$b[4]-2;
                                    print "$b[0]\tGeneWise\tstop_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                            } else {
                                    print "$b[0]\tGeneWise\tgene\t$b[4]\t$b[3]\t$info\t$gene_info\n";
                                    #my $tran=$gene.".t1";
                                    print "$b[0]\tGeneWise\ttranscript\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                                    my $start=$b[4]; my $stop=$b[4]+2;
                                    my $info1=".\t-\t0"; #my $info2="transcript_id \"$tran\"\; gene_id \"$gene\"\;";
                                    print "$b[0]\tGeneWise\tstop_codon\t$start\t$stop\t$info1\t$tran_info\n";
                                    print "$b[0]\tGeneWise\tCDS\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                                    print "$b[0]\tGeneWise\texon\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                                    my $end_d=$b[3]; my $end_s=$b[3]-2;
                                    print "$b[0]\tGeneWise\tstart_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                            }
                    }
            }
#            print "\n" if $info{$id}->{'gene'};
    }
}

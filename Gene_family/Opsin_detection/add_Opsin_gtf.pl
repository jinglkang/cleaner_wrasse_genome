#!/usr/bin/perl -w
use strict;
use warnings;

# Putative opsin genes: putative_opsin.txt
# Putative opsin gff: putative_Opsin.gff
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

# gene id start from 28169
my $opsin="putative_opsin.txt";
my $i=28169; my %opsin;
open OPSIN, $opsin or die "can not open $opsin\n";
while (<OPSIN>) {
        chomp; my @a=split /\t/;
        my @b=split /\:/, $a[0];
        my $id; my $gtf_geneid;
        ($b[2] > $b[1])?($id=$b[0]."\t".$b[1]."\t".$b[2]):($id=$b[0]."\t".$b[2]."\t".$b[1]);
        my $gene=$a[1]; my $anno=$a[2]; my $gene_strand=$b[3];
        last if $b[4] ne "C";
        unless ($Total_info{$id}) {
                $i++; my $gtf_geneid="Ldim_g".$i;
                my $gtf_tranid=$gtf_geneid.".t1";
                my $gtf_strand=$gene_strand;
                $opsin{$id}={
                        'gtf_geneid' => $gtf_geneid,
                        'gtf_strand' => $gtf_strand,
                        'gtf_tranid' => $gtf_tranid,
                        'gene'       => $gene,
                        'anno'       => $anno
                };
        }
}

$/ = "\/\/";
# parse the gff file: putative_Opsin.gff
my $GFF="putative_Opsin.gff";
open GFF, $GFF or die "can not open $GFF\n";
while (<GFF>) {
    chomp;
    s/^\s+//; s/\s+$//;
    my @a=split /\n/;my $nb=@a;
    my ($id, $strand, $gtf_geneid, $gtf_strand, $gtf_tranid, $gene, $gene_info, $tran_info);
    if (@a == 2) {
        for (my $i = 0; $i < @a; $i++) {
                my @b=split /\t/, $a[$i];
                my $info=$b[5]."\t".$b[6]."\t".$b[7];
                if ($i==0) {
                        ($b[4] > $b[3])?($strand = "+"):($strand = "-");
                        ($b[4] > $b[3])?($id=$b[0]."\t".$b[3]."\t".$b[4]):($id=$b[0]."\t".$b[4]."\t".$b[3]);
                        ($gtf_geneid, $gtf_strand, $gtf_tranid, $gene, $gene_info, $tran_info)=&Parase($b[0], $b[3], $b[4], $strand, $id);
                        last if ! $opsin{$id};
                        if ($strand eq "+") {
                                &Print_start($b[0], $b[3], $b[4], "+", $info, $gene_info, $tran_info, $nb);
                            } else {
                                &Print_start($b[0], $b[3], $b[4], "-",  $info, $gene_info, $tran_info, $nb);
                        }
                }
        }
    } else {
        for (my $i = 0; $i < @a; $i++) {
                my @b=split /\t/, $a[$i];
                my $block=$b[2];
                my $info=$b[5]."\t".$b[6]."\t".$b[7];
                if ($i==0) {
                        ($b[4] > $b[3])?($strand = "+"):($strand = "-");
                        ($b[4] > $b[3])?($id=$b[0]."\t".$b[3]."\t".$b[4]):($id=$b[0]."\t".$b[4]."\t".$b[3]);
                        ($gtf_geneid, $gtf_strand, $gtf_tranid, $gene, $gene_info, $tran_info)=&Parase($b[0], $b[3], $b[4], $strand, $id);
                        last if ! $opsin{$id};
                        if ($strand eq "+") {
                                &Print_start($b[0], $b[3], $b[4], "+", $info, $gene_info, $tran_info, $nb);
                            } else {
                                &Print_start($b[0], $b[3], $b[4], "-",  $info, $gene_info, $tran_info, $nb);
                        }
                } elsif ($i<@a-1) {
                        if ($strand eq "+") {
                                print "$b[0]\tGeneWise\t$block\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                        } else {
                                print "$b[0]\tGeneWise\t$block\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                        }
                } elsif ($i==@a-1) {
                        if ($strand eq "+") {
                                print "$b[0]\tGeneWise\t$block\t$b[3]\t$b[4]\t$info\t$tran_info\n";
                                my $end_d=$b[4]; my $end_s=$b[4]-2;
                                print "$b[0]\tGeneWise\tstop_codon\t$end_s\t$end_d\t$info\t$tran_info\n";
                        } else {
                                print "$b[0]\tGeneWise\t$block\t$b[4]\t$b[3]\t$info\t$tran_info\n";
                                my $end_d=$b[3]; my $end_s=$b[3]-2;
                                print "$b[0]\tGeneWise\tstart_codon\t$end_s\t$end_d\t$info\t$tran_info\n";
                        }
                }
        }
    }
}

sub Parase {
        my ($a0, $a3, $a4, $strand, $id)=@_;
        if ($opsin{$id}) {
                my $gtf_geneid=$opsin{$id}->{'gtf_geneid'};
                my $gtf_strand=$opsin{$id}->{'gtf_strand'};
                my $gtf_tranid=$opsin{$id}->{'gtf_tranid'};
                my $gene      =$opsin{$id}->{'gene'};
                my $anno      =$opsin{$id}->{'anno'};

#                my $gene_info="gene_id \"$gtf_geneid\"\; gene_name \"$gene\"\; gene_source \"Swiss-Prot\"\; gene_biotype \"protein_coding\"\;";
                my $gene_info="gene_id \"$gtf_geneid\"\; gene_name \"$gene\"\; gene_description \"$anno\"\; gene_source \"Swiss-Prot\"\;";
#                my $tran_info="gene_id \"$gtf_geneid\"\; transcript_id \"$gtf_tranid\"\; gene_name \"$gene\"\; gene_source \"Swiss-Prot\"\; gene_biotype \"protein_coding\"\; transcript_biotype \"protein_coding\"\;";
                my $tran_info="gene_id \"$gtf_geneid\"\; transcript_id \"$gtf_tranid\"\;";
                return($gtf_geneid, $gtf_strand, $gtf_tranid, $gene, $gene_info, $tran_info);
        }
}

sub Print_start {
        my ($a0, $a3, $a4, $strand, $info, $gene_info, $tran_info, $nb)=@_;
        if ($strand eq "+") {
                print "$a0\tGeneWise\tgene\t$a3\t$a4\t$info\t$gene_info\n";
                print "$a0\tGeneWise\ttranscript\t$a3\t$a4\t$info\t$tran_info\n";
                my $start=$a3;
                my $stop=$a3+2;
                my $info1=".\t+\t0";
                print "$a0\tGeneWise\tstart_codon\t$start\t$stop\t$info1\t$tran_info\n";
                if ($nb==2) {
                        print "$a0\tGeneWise\tCDS\t$a3\t$a4\t$info\t$tran_info\n";
                        print "$a0\tGeneWise\texon\t$a3\t$a4\t$info\t$tran_info\n";
                        my $end_d=$a4; my $end_s=$a4-2;
                        print "$a0\tGeneWise\tstop_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                }
        } else {
                print "$a0\tGeneWise\tgene\t$a4\t$a3\t$info\t$gene_info\n";
                print "$a0\tGeneWise\ttranscript\t$a4\t$a3\t$info\t$tran_info\n";
                my $start=$a4;
                my $stop=$a4+2;
                my $info1=".\t-\t0";
                print "$a0\tGeneWise\tstop_codon\t$start\t$stop\t$info1\t$tran_info\n";
                if ($nb==2) {
                        print "$a0\tGeneWise\tCDS\t$a4\t$a3\t$info\t$tran_info\n";
                        print "$a0\tGeneWise\texon\t$a4\t$a3\t$info\t$tran_info\n";
                        my $end_d=$a3; my $end_s=$a3-2;
                        print "$a0\tGeneWise\tstart_codon\t$end_s\t$end_d\t$info1\t$tran_info\n";
                }
        }
}

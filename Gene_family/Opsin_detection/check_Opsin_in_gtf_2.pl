#!/usr/bin/perl -w
use strict;
use warnings;

# Putative opsin genes: putative_opsin.txt
# genome gtf: braker2+3_combined_renamed.gtf

my %Total_info;
my $GTF="braker2+3_combined_renamed.gtf";
open GTF, $GTF or die "can not open $GTF\n";
while (<GTF>) {
        chomp; my @a=split;
        if ($a[2] eq "gene") {
                my $id=$a[0]."\t".$a[3];
                my $gene=$a[-1]; my $strand=$a[6]; my $start=$a[3];
                $Total_info{$id}={
                        'start'  => $a[3],
                        'end'    => $a[4],
                        'gene'   => $gene,
                        'strand' => $strand
                };
        }
}

my $opsin="putative_opsin.txt"; my ($i, $j);
open TXT, ">Opsin_in_gtf.txt" or die "can not create Opsin_in_gtf.txt\n";
open OPSIN, $opsin or die "can not open $opsin\n";
while (<OPSIN>) {
        chomp; my @a=split /\t/;
        my @b=split /\:/, $a[0];
#        my $id;
#        ($b[2] > $b[1])?($id=$b[0]."\t".$b[1]."\t".$b[2]):($id=$b[0]."\t".$b[2]."\t".$b[1]);
        my ($id, $start, $end, $strand, $gene, $anno);
        $gene=$a[1]; $anno=$a[2]; $strand=$b[3];
        if ($strand eq "+") {
                $start=$b[1]; $end=$b[2];
                $id   =$b[0]."\t".$start;
        } else {
                $start=$b[2]; $end=$b[1];
                $id   =$b[0]."\t".$start;
        }
#        my $gene=$a[1]; my $anno=$a[2]; my $gene_strand=$b[3];
        last if $b[4] ne "C";
        if ($Total_info{$id}) {
                my $gtf_gene=$Total_info{$id}->{'gene'};
                my $gtf_strand=$Total_info{$id}->{'strand'};
                my $gtf_start =$Total_info{$id}->{'start'};
                my $gtf_end   =$Total_info{$id}->{'end'};
                if ($gtf_strand eq $strand) {
                        $i++;
                        print TXT "##EXIST\t$id\t$gtf_gene\t$gtf_strand\t$gtf_start\t$gtf_end\t$gene\t$strand\t$start\t$end\t$anno\n";
                } else {
                        die "There is unconsistent: $gtf_gene && $gene\n";
                }
        } else {
                print TXT "##NONEX\t$id\tNon\tNon\tNon\tNon\t$gene\t$strand\t$start\t$end\t$anno\n";
                $j++;
        }
}
print "In_gtf\tC\t$i\n";
print "No_gtf\tC\t$j\n";

#!/usr/bin/perl -w
use strict;
use warnings;

# Opsin_in_gtf.txt; OR_in_gtf.txt;
# braker2+3_combined_renamed.aa.long.anno.final.txt;
# braker2+3_combined_renamed.gtf

system("cat Opsin_in_gtf.txt OR_in_gtf.txt > Change.txt");
my $add="Change.txt";
my %anno_info;
open ADD, "$add" or die "can not open $add\n";
while (<ADD>) {
        chomp;
#       if (/^##EXIST/) {
                my @a=split /\t/;
                my $gtf_id=$a[4];
                my $gene  =$a[6];
                my $anno  =$a[-1];
                my $source="Swiss-Prot";
                $anno_info{$gtf_id}={
                        'gene'   => $gene,
                        'anno'   => $anno,
                        'source' => $source
                };
#       }
}
system("rm Change.txt");

my $anno="braker2+3_combined_renamed.aa.long.anno.final.txt";
open ANNO, $anno or die "can not open $anno\n";
while (<ANNO>) {
        chomp;
        my @a=split /\t/;
        my $gtf_id    =$a[0];
        my ($gene, $anno, $source);
        if ($a[1]=~/db=\"\-\"/) {
                $gene   ="-";
                $anno   ="-";
                $source ="-";
        } else {
                ($gene)    =$a[2]=~/symbol=\"(.*?)\"/;
                ($anno)    =$a[3]=~/Name=\"(.*)\s+\[.*\]\"/;
                ($source)  =$a[1]=~/db=\"(.*?)\"/;
        }
        unless ($anno_info{$gtf_id}) {
                $anno_info{$gtf_id}={
                        'gene'   => $gene,
                        'anno'   => $anno,
                        'source' => $source
                };
        }
}

my $gtf="braker2+3_combined_renamed.gtf";
open GTF, $gtf or die "can not open $gtf\n";
while (<GTF>) {
        chomp;
        my @a=split /\t/;
        my $flag=$a[2];
        if ($flag eq "gene") {
                my $gtf_id=$a[-1];
                my $gene  =$anno_info{$gtf_id}->{'gene'};
                my $anno;
                unless ($anno_info{$gtf_id}->{'anno'}) {
                        die "$gtf_id has no annotation\n";
                }
#               ($anno_info{$gtf_id}->{'anno'})?($anno  =$anno_info{$gtf_id}->{'anno'}):($anno="");
                $anno  =$anno_info{$gtf_id}->{'anno'};
                my $source=$anno_info{$gtf_id}->{'source'};
                my $gene_info="gene_id \"$gtf_id\"\; gene_name \"$gene\"\; gene_description \"$anno\"\; gene_source \"$source\"\;";
                my $info;
                for (my $i = 0; $i < @a-1; $i++) {
                        $info.=$a[$i]."\t";
                }
                $info.=$gene_info;
                print "$info\n";
        } elsif ($flag eq "transcript") {
                my $tran      =$a[-1];
                (my $gtf_id)  =$tran=~/(.*?)\./;
                my $tran_info ="transcript_id \"$tran\"\; gene_id \"$gtf_id\"\;";
                my $info;
                for (my $i = 0; $i < @a-1; $i++) {
                        $info.=$a[$i]."\t";
                }
                $info.=$tran_info;
                print "$info\n";
        } else {
                print "$_\n";
        }
}

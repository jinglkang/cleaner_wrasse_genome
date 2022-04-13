#!/usr/bin/perl -w
use strict;
use warnings;

# this script is to know the DEGs are up- or downregulated

my $DEG="DEGs_Interaction_Solo_Fm_info_LncRNA_2.txt";
my $FB="gtf_FB_Interaction_Solo.csv";
my $HB="gtf_HB_Interaction_Solo.csv";
my $MB="gtf_MB_Interaction_Solo.csv";

my (%HB, %MB, %FB);
open HB, $HB or die "can not open $HB\n";
while (<HB>) {
        chomp;
        s/\"//g;
        next if /baseMean/;
        my @a=split /\,/;
        if ($a[2] eq "NA") {
                $HB{$a[0]}="NA";
        } else {
                ($a[2]>0)?($HB{$a[0]}="up"):($HB{$a[0]}="down");
        }
}

open MB, $MB or die "can not open $MB\n";
while (<MB>) {
        chomp;
        s/\"//g;
        next if /baseMean/;
        my @a=split /\,/;
        if ($a[2] eq "NA") {
                $MB{$a[0]}="NA";
        } else {
                ($a[2]>0)?($MB{$a[0]}="up"):($MB{$a[0]}="down");
        }
}

open FB, $FB or die "can not open $FB\n";
while (<FB>) {
        chomp;
        s/\"//g;
        next if /baseMean/;
        my @a=split /\,/;
        if ($a[2] eq "NA") {
                $FB{$a[0]}="NA";
        } else {
                ($a[2]>0)?($FB{$a[0]}="up"):($FB{$a[0]}="down");
        }
}

open DEG, $DEG or die "can not open $DEG\n";
while (<DEG>) {
        chomp;
        my @a=split /\t/;
        my ($info, $info1, $info2);
        $info=$HB{$a[0]}."; ".$MB{$a[0]}."; ".$FB{$a[0]} unless /^Gene/;
        for (my $i = 0; $i < @a; $i++) {
                if ($i<=3) {
                        $info1.=$a[$i]."\t";
                } else {
                        $info2.=$a[$i]."\t";
                }
        }
        $info1=~s/\s+$//;
        $info2=~s/\s+$//;
        if (/^Gene/) {
                print "$info1\tregulation\t$info2\n";
        } else {
                print "$info1\t$info\t$info2\n";
        }
}

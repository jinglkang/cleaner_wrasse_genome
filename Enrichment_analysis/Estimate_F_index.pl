#!/usr/bin/perl -w
use strict;
use warnings;

my $fm="summary_run2_anc.txt";
my $a1=(12**2-2*12)/2;
my $b1=(log2($a1+1/2))+1;
my $header;
my @nums;

open FM, $fm or die "can not open $fm\n";
while (<FM>) {
        chomp;
        my @a=split;
        my $total;
        if (/^Family/) {
                $header="Family_ID\t";
                for (my $i = 1; $i < @a; $i++) {
                        if ($a[$i]=~/\D+\<\d+\>/) {
                                (my $spe)=$a[$i]=~/(\D+)\<\d+\>/;
                                $header.=$spe."\t";
                                push @nums, $i;
                        }
                }
                $header=~s/\s+$//;
                print "$header\n";
        } else {
                foreach my $nb (@nums) {
                        $total+=$a[$nb];
                }
                my $F_T="Family_".$a[0]."\t";
                foreach my $nb (@nums) {
                        my $ratio=$a1*($a[$nb]/$total);
                        my $c1=(log2($ratio+1/2))+1;
                        my $d1=$c1/$b1;
                        $d1=sprintf("%.3f",$d1);
                        $F_T.=$d1."\t";
                }
                $F_T=~s/\s+$//;
                print "$F_T\n";
        }
}

sub log2 {
        my $n = shift;
        # using pre-defined log function
        return log($n) / log(2);
}

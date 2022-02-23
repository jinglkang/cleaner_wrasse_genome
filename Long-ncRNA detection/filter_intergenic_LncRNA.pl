#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;
use Getopt::Long 'HelpMessage';
use Parallel::ForkManager;

my %hash;
my $classify=$ARGV[0];
open FIL1, $classify or die "can not open $classify\n";
while (<FIL1>) {
        my @a=split /\t/;
        next if /^isBest/;
        if ($a[0]==1 && $a[6] eq "intergenic") {
                $hash{$a[1]}++;
        }
}

my $reads   =$ARGV[1];
open FIL2, $reads or die "can not open $reads\n";
while (<FIL2>) {
        chomp;
        next if /^#/;
        my @a=split /\t/;
        if (/^Geneid/) {
                my $info;
                for (my $i = 6; $i < @a; $i++) {
                        $info.=$a[$i]."\t";
                        }
                $info=~s/\s+$//;
                print "$a[0]\t$info\n";
        } else {
                my $info;
                for (my $i = 6; $i < @a; $i++) {
                        $info.=$a[$i]."\t";
                        }
                $info=~s/\s+$//;
                print "$a[0]\t$info\n" if $hash{$a[0]};
        }
}

#!/usr/bin/perl
use strict;
use warnings;

my $swiss="uniprot-filtered-reviewed_yes.fasta";
my (@names);
my $name;
my %hash;
open SWIS, $swiss or die "can not open $swiss\n";
while (<SWIS>) {
        chomp;
        if (/>/) {
                my @a=split /\|/;
                my $uni_acc=$a[1];
                (my $pro_name)=$_=~/\s+?(.*)?\s+OS=/;
                (my $organ)=$_=~/OS=(.*)?\s+OX=/;
                $name=$uni_acc."\t".$pro_name." [".$organ."]";
#               $organ?(print "$name\n"):(die "these is no organism name\n");
                push @names, $name;
        } else {
                $hash{$name}.=$_;
        }
}

foreach my $name (@names) {
        my $len=length($hash{$name});
        print "$name\t$len\n";
}

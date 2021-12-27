#!/usr/bin/perl
use strict;
use warnings;

my $ref="vertebrate_other.fa";
my (@names);
my $name;
my %hash;
open REF, $ref or die "can not open $ref\n";
while (<REF>) {
        chomp;
        if (/>/) {
                s/^>//;
                s/\s+/\t/;
                $name=$_;
                push @names, $name;
        } else {
                $hash{$name}.=$_;
        }
}

foreach my $name (@names) {
        my $len=length($hash{$name});
        print "$name\t$len\n";
}

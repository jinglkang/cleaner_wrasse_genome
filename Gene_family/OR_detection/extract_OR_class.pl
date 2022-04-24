#!/usr/bin/perl -w
use strict;
use warnings;

# Extract the OR sequences of Zebrafish and the OR (Alpha, thet) sequences of L.oculatus for the class
my $OR="MBE_OR_class.fasta";
my %seq;
my $name; my @names;
open OR, $OR or die "can not open $OR\n";
while (<OR>) {
	chomp;
	if (/>/) {
		s/>//;
		$name=$_;
		push @names, $name;
	} else {
		$seq{$name}.=$_;
	}
}

foreach my $name (@names) {
	my $seq=$seq{$name};
	if ($name=~/D\.rerio/ || $name=~/L\.oculatus\.Alpha/ || $name=~/L\.oculatus\.thet/) {
		print ">$name\n$seq\n";
	}
}

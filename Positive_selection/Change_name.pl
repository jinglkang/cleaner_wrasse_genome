#!/usr/bin/perl -w
use strict;
use warnings;

my @spe1=qw(Cheilinus_undulatus Labroides_dimidiatus Labrus_bergylta Notolabrus_celidotus Symphodus_melops Thalassoma_bifasciatum);
my @spe2=qw(Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish);

my @fas=<Longest_*_pep.fasta>;
foreach my $fas (@fas) {
	(my $spe)=$fas=~/Longest_(.*)_pep\.fasta/;
	my $new_fas=$spe.".fasta";
	if (Element($spe, \@spe1)) {
#		print "spe1\t$spe\n";
		open NEW, ">$new_fas" or die "can not create $new_fas\n";
		open FAS, "$fas" or die "can not open $fas\n";
		while (<FAS>) {
			chomp;
			if (/>/) {
				print NEW "$_\n";
			} else {
				s/\.//g;
				print NEW "$_\n";
			}
		}
		my $cmd1="rm $fas";
		system($cmd1);
	} elsif (Element($spe, \@spe2)) {
#		print "spe2\t$spe\n";
		open NEW, ">$new_fas" or die "can not create $new_fas\n";
		open FAS, "$fas" or die "can not open $fas\n";
		while (<FAS>) {
			chomp;
			if (/>/) {
				s/>//; my $header=">".$spe."_".$_;
				print NEW "$header\n";
			} else {
				s/\.//g;
				print NEW "$_\n";
			}
		}
		my $cmd1="rm $fas";
		system($cmd1);
	}
}

sub Element { # the element in the array or not
	my ($element, $array)=@_;
	foreach my $a (@{$array}) {
		if ($element eq $a) {
			return 1;
			last;
		}
	}
}

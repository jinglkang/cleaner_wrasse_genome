#!/usr/bin/perl
use strict;
use warnings;
use List::MoreUtils qw(uniq);
use Getopt::Long 'HelpMessage';

my $usage=<<_EOH_;;
------------------------------------------------------------------------------------------
This script is used to select the orthogroups from Orthogroups.txt

the Orthogroup has at least "\$nb" species, which include "speA" and "speB"
print the "orthogroup id" "gene in speA" "gene in speB"

Usage: 
orth_select.pl --spe Zebrafish Ldim --nb 6

								Kang 2022-01-01
------------------------------------------------------------------------------------------
_EOH_
;

GetOptions(
	'spe:s{1,}', \my @spe,	# the selected two species which both have only one 
	'nb:s', \ my $nb,	# at least this number of species
	'help', \ my $help
	);

if ($help || (! @spe) || (! $nb) ) {
	die $usage; # all of these options are mandatory requirements
}

my $orth="Orthogroups.txt";
print "Orth_ID\tTotal_spe\t$spe[0]\t$spe[0]_id\t$spe[1]\t$spe[1]_id\n";
open ORTH, "$orth" or die "can not open $orth\n";
while (<ORTH>) {
	chomp;
	my @a=split;
	$a[0]=~s/\:$//;
	my $id=$a[0];
	if (/$spe[0]/ && /$spe[1]/) {
		my (@spes, @speA, @speB);
		my ($infoA, $infoB);
		for (my $i = 1; $i < @a; $i++) {
			(my $spe)=$a[$i]=~/(.*)\_/;
			push @spes, $spe;
			if ($spe eq $spe[0]) {
				push @speA, $spe;
				$infoA.=$a[$i].",";
			} elsif ($spe eq $spe[1]) {
				push @speB, $spe;
				$infoB.=$a[$i].",";
			}
		}
		my $total=uniq @spes;
		$infoA=~s/\,$//; $infoB=~s/\,$//;
		my $nbA=@speA; my $nbB=@speB;
		if ($total >= $nb) {
			print "$id\t$total\t$nbA\t$infoA\t$nbB\t$infoB\n";
		}
	}
}

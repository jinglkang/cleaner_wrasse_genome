#!/usr/bin/perl
use strict;
use warnings;

my $gtf="braker2+3_combined_renamed.final.gtf";

my $cmd="less braker2+3_combined_renamed.final.gtf|perl -alne 'print if \$F[2]=~/codon/i' >1.txt";
system($cmd);

my ($gene, $tran, $chr, $start, $end, $strand);
open TXT, "1.txt" or die "can not open 1.txt\n";
while (<TXT>) {
	chomp;
	my @a=split /\t/;
	($tran, $gene)=$a[-1]=~/transcript_id\s\"(.*?)\"\;\sgene_id\s\"(.*?)\"\;/;
	if ( ($a[-3] eq "+") && ($a[2] eq "start_codon") ) {
		$strand=1;
		$chr=$a[0]; $start=$a[3];
		my $line = <TXT>;
		my @b=split /\t/, $line;
		if (($b[2] eq "stop_codon") && ($line=~/$gene/) && ($line=~/$tran/) ) {
			$end=$b[4];
			print "$gene\t$tran\t$chr\t$start\t$end\t$strand\n";
		}
	} elsif ( ($a[-3] eq "-") && ($a[2] eq "stop_codon") ) {
		$strand=-1;
		$chr=$a[0]; $start=$a[3];
		my $line = <TXT>;
		my @b=split /\t/, $line;
		if (($b[2] eq "start_codon") && ($line=~/$gene/) && ($line=~/$tran/) ) {
			$end=$b[4];
			print "$gene\t$tran\t$chr\t$start\t$end\t$strand\n";
		}
	}
}

system("rm 1.txt");

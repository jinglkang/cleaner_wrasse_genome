#!/usr/bin/perl -w
use strict;
use warnings;


my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Spul Tads Tbif Ldim);

my $fasta="/media/HDD/cleaner_fish/genome/gene_family_3/all.fasta";
my %seq; my $gene;
open FASTA, $fasta or die "can not open $fasta\n";
while (<FASTA>) {
	chomp;
	if (/>/) {
		s/>//;
		$gene=$_;
	} else {
		$seq{$gene}.=$_;
	}
}
close FASTA;

my $nb="fm_same_name_nb.txt";
my %single_fm;
open NB, $nb or die "can not open $nb\n";
while (<NB>) {
	chomp;
	my @a=split /\t/;
	next if /^Desc/;
	my $j;
	for (my $i = 2; $i < @a; $i++) {
		$j++ if $a[$i]==1;
	}
	if ($j && $j==14) {
		$single_fm{$a[1]}++;
	}
}
close NB;

my $fm_ct="fm_same_name.txt";
system("mkdir fm_same_name_single_copy") unless -e "fm_same_name_single_copy";
open CT, $fm_ct or die "can not open $fm_ct\n";
while (<CT>) {
	chomp;
	my @a=split /\t/;
	my %spe_seq; my $fasta1;
	my @genes=split /\,/, $a[-1];
	if ($single_fm{$a[0]}) {
		$fasta1="fm_same_name_single_copy/$a[0].fasta";
		open FASTA1, ">$fasta1" or die "can not create $fasta1\n";
		foreach my $gene (@genes) {
			(my $spe)=$gene=~/(.*)\_/;
			(my $seq)=$seq{$gene};
			$spe_seq{$spe}={
				'gene' => $gene,
				'seq'  => $seq
			};
		}
		foreach my $spe (@spes) {
		my $gene=$spe_seq{$spe}->{'gene'};
		my $seq=$spe_seq{$spe}->{'seq'};
		print FASTA1 ">$gene\n$seq\n";
		}
		my $align="fm_same_name_single_copy/$a[0].align.fasta";
		system("muscle -in $fasta1 -out $align");
		system("mv $align $fasta1");
	}
	close FASTA1;
}

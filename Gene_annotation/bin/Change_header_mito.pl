#!/usr/bin/perl
use strict;
use warnings;

# replace the original scaffold (Scx22uW_26) with the mito assembly (/home/kang1234/genome/mito_genome/Ldim-mito.fasta)
# change the sequence name: chr1-ch24, Mito, Scaffold1 ... (/home/kang1234/genome/Gene_annotation/Cleaner_wrasse_softmasked_ChaHeader.fasta)
# How to change: /home/kang1234/genome/Gene_annotation/Ldim_genome.info.change.txt

my $mito="/home/kang1234/genome/mito_genome/Ldim-mito.fasta";
my $mito_seq;
open MITO, $mito or die "can not open $mito\n";
while (<MITO>) {
	chomp;
	next if />/;
	$mito_seq.=uc($_);
}

my $mito_len=length($mito_seq);
my $mito_seq_new;
for (my $i = 1; $i <= $mito_len; $i+=49) {
	my $block = $mito_len-$i+1 < 50? $mito_len-$i+1 : 49;
	my $seq=substr($mito_seq, $i-1, $block);
#	print "$seq\n";
	$mito_seq_new.=$seq."\n";
}
chomp($mito_seq_new);
# print "$mito_seq_new\n";

my %hash1; # %hash1 stores the old and new header
my @olds;
my $info="/home/kang1234/genome/Gene_annotation/Ldim_genome.info.change.txt";
open INFO, $info or die "can not open $info\n";
while (<INFO>) {
	chomp; my @a=split;
	my ($old, $new)=($a[0], $a[1]);
	push @olds, $old;
	$hash1{$old}=$new;
}

my %geno; my $header;
my $geno="/home/kang1234/genome/Gene_annotation/Cleaner_wrasse_softmasked_ChaHeader.fasta";
open GENOME, $geno or die "can not open $geno\n";
while (<GENOME>) {
	chomp;
	if (/>/) {
		s/>//; $header=$_;
#		push @olds, $header;
	} else {
		$geno{$header}.=$_;
	}
}

foreach my $old (@olds) {
	my $new=$hash1{$old};
	my $seq=$geno{$old};
	if ($new ne "MT") {
		my $len=length($seq);
		my $len_new;
		for (my $i = 1; $i <= $len; $i+=49) {
			my $block = $len-$i+1 < 50? $len-$i+1 : 49;
			my $seq1=substr($seq, $i-1, $block);
			$len_new.=$seq1."\n";
		}
		chomp($len_new);
		print ">$new\n$len_new\n";
	} else {
		print ">MT\t$mito_seq_new\n";
	}
}

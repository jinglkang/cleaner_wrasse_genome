#!/usr/bin/perl
use strict;
use warnings;

my ($gene, $tran); my %seq; my %hash; my @genes;
&Parse_geno($ARGV[1]);

my %info;
foreach my $gene (@genes) {
	my @trans=sort @{$hash{$gene}};
	foreach my $tran (@trans) {
		my $seq=$seq{$gene}->{$tran};
		my $len=length($seq);
		if ($info{$gene}) {
			my $len_old=$info{$gene}->{'len'};
			if ($len > $len_old) {
				$info{$gene}={
					'tran' => $tran,
					'len'  => $len
				};
			}
		} else {
			$info{$gene}={
				'tran' => $tran,
				'len'  => $len
			};
		}
	}
}

foreach my $gene (@genes) {
	my $tran=$info{$gene}->{'tran'};
	my $len =$info{$gene}->{'len'};
	print "$gene\t$tran\t$len\n";
}

sub Parse_geno {
	my $phase=$ARGV[1];
	open GENOME, $ARGV[0] or die "can not open $ARGV[0]\n";
	if ($phase==1) {
		while (<GENOME>) {
		chomp;
		if (/^>(.*)\|(.*)/) {
			($gene, $tran)=($1, $2);
			$hash{$gene}=[] unless exists $hash{$gene};
			push @{$hash{$gene}}, $tran;
			push @genes, $gene if @{$hash{$gene}}==1;
			} else {
				$seq{$gene}->{$tran}.=$_;
			}
		}
	} elsif ($phase==0) {
		while (<GENOME>) {
		chomp;
		if (/^>(.*)\./) {
			$gene=$1; s/>//; $tran=$_;
			$hash{$gene}=[] unless exists $hash{$gene};
			push @{$hash{$gene}}, $tran;
			push @genes, $gene if @{$hash{$gene}}==1;
			} else {
				$seq{$gene}->{$tran}.=$_;
			}
		}
	}
}

#!/usr/bin/perl -w
use strict;
use warnings;

# circos karyotype file: ../Ldim_karyotype.txt
# gene location file: Ldim_gene_location_chromPlot.txt

my $kary="../Ldim_karyotype.txt";
my %chr;
open KARY, $kary or die "can not open $kary\n";
while (<KARY>) {
	chomp; my @a=split;
	my ($id, $start, $end)=($a[3], $a[4], $a[5]);
	$chr{$id}={
		'start' => $start,
		'end'   => $end
	};
}

my $loca="Ldim_gene_location_chromPlot.txt";
my %location;
open LOCA, $loca or die "can not open $loca\n";
while (<LOCA>) {
	chomp; next if /^Chrom/;
	my @a=split;
	my ($id, $start, $end)=($a[0], $a[1], $a[2]);
	my $len=$chr{$id}->{'end'};
	for (my $i = 1; $i < $len; $i+=1000000) {
		my $b_s=$i; my $b_e=$i+1000000-1;
		my $block=$b_s." ".$b_e;
		if ($b_s>=$start && $b_s>=$end && $end <= $b_e) {
			$location{$id}->{$block}++;
			last;
		} elsif ($b_s>=$start && $b_s>=$end && $end > $b_e) {
			$location{$id}->{$block}++;
			last;
		}
	}
}

foreach my $id (sort keys %chr) {
	my $len=$chr{$id}->{'end'};
	for (my $i = 1; $i < $len; $i+=1000000) {
		my $b_s=$i; my $b_e=$i+1000000-1;
		my $block=$b_s." ".$b_e;
		my $nb=$location{$id}->{$block};
		print "$id $block $nb\n" if $nb;
	}
}

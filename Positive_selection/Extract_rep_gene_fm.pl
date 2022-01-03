#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

# Extract the representative protein per species per gene family
# dump.blast_output.mci.I30

my $cmd1="less filtered_cafe_input_zebra.txt|perl -alne \'my \@a;for (\$i=2;\$i<\@F;\$i++){push \@a, \$F[\$i] if \$F[\$i]>=1};my \$n=\@a;print \$F[1] if \$n==12' >fam_id.txt";
system($cmd1);

my %id; my @ids;
open FAM_ID, "fam_id.txt" or die "can not open fam_id.txt\n";
while (<FAM_ID>) {
	chomp; $id{$_}++; push @ids, $_;
}

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Cund Fugu Lber Ncel Smel Tbif Ldim);

my $cmd2="cat Longest_*_pep.fasta >all_pep.fas";
system($cmd2);
my $gene; my %geneInfo;
open FAS, "all_pep.fas" or die "can not open all_pep.fas\n";
while (<FAS>) {
	chomp;
	if (/>/) {
		s/>//; $gene=$_;
	} else {
		my $seq=$_;
		my $len=length($_);
		$geneInfo{$gene}={
			'seq' => $seq,
			'len' => $len
		};
	}
}

system("rm fam_id.txt all_pep.fas");

my $i; my %spes;
open FAM_INFO, "dump.blast_output.mci.I30" or die "can not open dump.blast_output.mci.I30\n";
while (<FAM_INFO>) {
	chomp; $i++; my @a=split;
	if ($id{$i}) {
		for (my $k = 0; $k < @a; $k++) {
			if ($a[$k]=~/(.*)\_(EN.*)/) {
				my ($spe, $gene)=$a[$k]=~/(.*)\_(EN.*)/;
				my $seq=$geneInfo{$gene}->{'seq'};
				my $len=$geneInfo{$gene}->{'len'};
				if ($spes{$spe}->{$i}) {
					my $old_len=$spes{$spe}->{$i}->{'len'};
					if ($old_len < $len) {
						$spes{$spe}->{$i}={
							'gene' => $gene,
							'seq'  => $seq,
							'len'  => $len
						};
					}
				} else {
					$spes{$spe}->{$i}={
						'gene' => $gene,
						'seq'  => $seq,
						'len'  => $len
					};
				}
			} else {
				(my $spe)=$a[$k]=~/(.*)\_/; $gene=$a[$k];
				my $seq=$geneInfo{$gene}->{'seq'};
				my $len=$geneInfo{$gene}->{'len'};
				if ($spes{$spe}->{$i}) {
					my $old_len=$spes{$spe}->{$i}->{'len'};
					if ($old_len < $len) {
						$spes{$spe}->{$i}={
							'gene' => $gene,
							'seq'  => $seq,
							'len'  => $len
						};
					}
				} else {
					$spes{$spe}->{$i}={
						'gene' => $gene,
						'seq'  => $seq,
						'len'  => $len
					};
				}
			}
		}
	}
}

my $header="Family_id\tZebra_protein\t";
foreach my $spe (@spes) {
	$header.=$spe."\t";
}
$header=~s/\s+$//; # print "$header\n";

foreach my $id (@ids) {
	my $info;
	$info=$spes{'Zebrafish'}->{$id}->{'gene'}."\t";
	my $len=$spes{'Zebrafish'}->{$id}->{'len'};
	foreach my $spe (@spes) {
		my $gene=$spes{$spe}->{$id}->{'gene'};
		$info.=$gene."\t";
	}
	$info=~s/\s+$//;
	my $name="Family_".$id;
	print "$name\t$info\n" if $len<=10000;
}

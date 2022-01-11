#!/usr/bin/perl -w
use strict;
use warnings;

# Putative opsin genes: putative_opsin.txt
# genome gtf: braker2+3_combined_renamed.gtf

my %Total_info;
my $GTF="braker2+3_combined_renamed.gtf";
open GTF, $GTF or die "can not open $GTF\n";
while (<GTF>) {
	chomp; my @a=split;
	if ($a[2] eq "gene") {
		my $id=$a[0]."\t".$a[3]."\t".$a[4];
		my $gene=$a[-1]; my $strand=$a[6];
		$Total_info{$id}={
			'gene'   => $gene,
			'strand' => $strand
		};
	}
}

my $opsin="putative_opsin.txt"; my ($i, $j);
open TXT, ">Opsin_in_gtf.txt" or die "can not create Opsin_in_gtf.txt\n";
open OPSIN, $opsin or die "can not open $opsin\n";
while (<OPSIN>) {
	chomp; my @a=split /\t/;
	my @b=split /\:/, $a[0];
	my $id;
	($b[2] > $b[1])?($id=$b[0]."\t".$b[1]."\t".$b[2]):($id=$b[0]."\t".$b[2]."\t".$b[1]);
	my $gene=$a[1]; my $anno=$a[2]; my $gene_strand=$b[3];
	last if $b[4] ne "C";
	if ($Total_info{$id}) {
		my $gtf_gene=$Total_info{$id}->{'gene'};
		my $gtf_strand=$Total_info{$id}->{'strand'};
		print TXT "##EXIST\t$id\t$gtf_gene\t$gtf_strand\t$gene\t$gene_strand\t$anno\n";
		$i++;
	} else {
		print TXT "##NONEX\t$id\tNon\tNon\t$gene\t$gene_strand\t$anno\n";
		$j++;
	}
}
print "In_gtf\tC\t$i\n";
print "No_gtf\tC\t$j\n";

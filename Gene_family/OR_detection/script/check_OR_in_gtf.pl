#!/usr/bin/perl -w
use strict;
use warnings;

# Putative OR genes: putative_OR_strand.txt
# Putative OR genes gff: putative_OR.gff
# Putative OR genes annotation: putative_OR.info
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

my $OR="putative_OR_strand.txt";
my %info;
open OR, $OR or die "can not open $OR\n";
while (<OR>) {
	chomp; my @a=split;
	my @b=split /\:/, $a[0];
	my $id=$b[0]."\t".$b[1]."\t".$b[2];
	my $strand=$b[3];
	my $struct=$b[4];
	$info{$id}={
		'strand' => $strand,
		'struct' => $struct
	};
}

my $OR_ano="putative_OR.info"; my ($i, $j);
open TXT, ">OR_in_gtf.txt" or die "can not create OR_in_gtf.txt\n";
open OR_ANO, $OR_ano or die "can not open $OR_ano\n";
while (<OR_ANO>) {
	chomp; my @a=split /\t/;
	$a[0]=~s/\-\D+//;
	my @b=split /\:/, $a[0];
	my $id=$b[0]."\t".$b[1]."\t".$b[2];
	my $gene=$a[1]; my $anno=$a[2];
	my $gene_strand=$info{$id}->{'strand'};
	my $gene_str=$info{$id}->{'struct'};

	if ($Total_info{$id}) {
		my $gtf_gene=$Total_info{$id}->{'gene'};
		my $gtf_strand=$Total_info{$id}->{'strand'};
		print TXT "##EXIST\t$id\t$gtf_gene\t$gtf_strand\t$gene\t$gene_strand\t$gene_str\t$anno\n";
		if ($gene_str eq "C") {
			$i++;
		}
	} else {
		print TXT "##NONEX\t$id\tNon\tNon\t$gene\t$gene_strand\t$gene_str\t$anno\n";
		if ($gene_str eq "C") {
			$j++;
		}
	}
}
print "In_gtf\tC\t$i\n";
print "No_gtf\tC\t$j\n";

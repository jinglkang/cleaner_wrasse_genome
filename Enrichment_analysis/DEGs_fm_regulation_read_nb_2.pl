#!/usr/bin/perl -w
use strict;
use warnings;

# gtf_FB_Interaction_Solo.csv; gtf_HB_Interaction_Solo.csv; gtf_MB_Interaction_Solo.csv
# contraction_fm_one_gene_Ldim.txt
# expasion_fm_one_gene_Ldim.txt

my $cont_fm="contraction_fm_one_gene_Ldim.txt";
my %cont;
open CON, $cont_fm or die "can not open $cont_fm\n";
while (<CON>) {
	chomp;
	my @a=split;
	$cont{$a[0]}="contraction";
}

my $expa_fm="expasion_fm_one_gene_Ldim.txt";
my %expa;
open EXPA, $expa_fm or die "can not open $expa_fm\n";
while (<EXPA>) {
	chomp;
	my @a=split;
	$expa{$a[0]}="expasion";
}

my $fam="dump.blast_output.mci.I30";
my $k;
my (%cont_1, %expa_1);
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
	chomp;
	$k++;
	my @a=split;
	my $fm="Family_".$k;
	if ($cont{$fm}) {
		for (my $i = 0; $i < @a; $i++) {
			my $info;
			if ($a[$i]=~/Ldim/i) {
				$cont_1{$a[$i]}=$fm;
			}
		}
	} elsif ($expa{$fm}) {
		for (my $i = 0; $i < @a; $i++) {
			my $info;
			if ($a[$i]=~/Ldim/i) {
				$expa_1{$a[$i]}=$fm;
			}
		}
	}
}

my $FB_ex="gtf_FB_Interaction_Solo.csv";
my $HB_ex="gtf_HB_Interaction_Solo.csv";
my $MB_ex="gtf_MB_Interaction_Solo.csv";

my $FB_nb="gtf_read_nb_FB.txt";
my $HB_nb="gtf_read_nb_HB.txt";
my $MB_nb="gtf_read_nb_MB.txt";


print "Gene_id\tBasemean\tLog2Foldchange\tP-adj\tType\tFM_id\tTissue\tgroup\treads_nb\n";
&read_csv($FB_ex, $FB_nb, "FB");
&read_csv($HB_ex, $HB_nb, "HB");
&read_csv($MB_ex, $MB_nb, "MB");

sub read_csv {
	my ($csv, $matrix, $name)=@_;
	my %reads_nb;
	open MATRIX, $matrix or die "can not open $matrix\n"; # also open the corresponding reads nb matrix
	while (<MATRIX>) {
		chomp;
		my @a=split;
		my ($solo, $inte);
		if (/^Geneid/) {
			next;
		} else {
			my $gene=$a[0];
			for (my $i = 1; $i <= 6; $i++) {
				$solo+=$a[$i];
			}
			for (my $i = 7; $i < @a; $i++) {
				$inte+=$a[$i];
			}
			$solo=sprintf("%.0f", $solo/6);
			$inte=sprintf("%.0f", $inte/6);
			$reads_nb{$gene}={
				'solo'=>$solo,
				'inte'=>$inte
				};
		}
	}
	open CSV, $csv or die "can not open $csv\n";
	while (<CSV>) {
		chomp;
		s/\"//g;
		my @a=split /\,/;
		my $gene=$a[0];
		my $type; my $fm;
		if (/baseMean/) {
			next;
		} elsif (/NA/) {
			next;
		} else {
			my $value=&determine_DEG($a[1], $a[2], $a[-1]);
#			my $DEG;
#			$value?($DEG="Yes"):($DEG="No");
#			$hash{$gene}=$a[2]."\t".$DEG;
			if ($cont_1{$gene}) {
				$fm=$cont_1{$gene};
				$type="contraction";
			} elsif ($expa_1{$gene}) {
				$fm=$expa_1{$gene};
				$type="expasion";
			} else {
				$fm="None";
				$type="None";
			}
			if ($value) {
				print "$gene\t$a[1]\t$a[2]\t$a[-1]\t$type\t$fm\t$name\tsolo\t$reads_nb{$gene}->{'solo'}\n";
				print "$gene\t$a[1]\t$a[2]\t$a[-1]\t$type\t$fm\t$name\tinte\t$reads_nb{$gene}->{'inte'}\n";
			}
		}
	}
}

sub determine_DEG {
	my ($basemean, $Log2FoldChange, $padj)=@_;
	my $value;
	$Log2FoldChange=abs($Log2FoldChange);
	if ($basemean>=10 && $Log2FoldChange>=0.3 && $padj<=0.05) {
		$value=1;
	} else {
		$value=0;
	}
	return($value);
}

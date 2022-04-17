#!/usr/bin/perl -w
use strict;
use warnings;

# gtf_FB_Interaction_Solo.csv; gtf_HB_Interaction_Solo.csv; gtf_MB_Interaction_Solo.csv
# contraction_fm_one_gene_Ldim.txt
# expasion_fm_one_gene_Ldim.txt

print "LincRNA_id\tLincRNA_reg\tnb_gene\tnb_gene_nm\tnb_gene_des\tnb_gene_reg\tgene_fm\tgene_fm_var\tpos\ttissue\n";

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
my (%cont_1, %expa_1, %gene_fm);
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
	chomp;
	$k++;
	my @a=split;
	my $fm="Family_".$k;
	if ($cont{$fm}) {
		for (my $i = 0; $i < @a; $i++) {
			if ($a[$i]=~/Ldim/i) {
				$cont_1{$a[$i]}=$fm;
			}
		}
	} elsif ($expa{$fm}) {
		for (my $i = 0; $i < @a; $i++) {
			if ($a[$i]=~/Ldim/i) {
				$expa_1{$a[$i]}=$fm;
			}
		}
	} else {
		for (my $i = 0; $i < @a; $i++) {
			if ($a[$i]=~/Ldim/i) {
				$gene_fm{$a[$i]}=$fm;
			}
		}
	}
}

# gene family with positive selected genes
my $pos="Positive_sub_orth_fm.txt";
my %POS;
open POS, $pos or die "can not open $pos\n";
while (<POS>) {
        chomp;
        $POS{$_}++;
}

# Estimate the DE lncRNAs
my $FB_ex="LncRNA_FB_Interaction_Solo.csv";
my $HB_ex="LncRNA_HB_Interaction_Solo.csv";
my $MB_ex="LncRNA_MB_Interaction_Solo.csv";

&read_csv($FB_ex, "FB", "gtf_FB_Interaction_Solo.csv");
&read_csv($HB_ex, "HB", "gtf_HB_Interaction_Solo.csv");
&read_csv($MB_ex, "MB", "gtf_MB_Interaction_Solo.csv");

sub read_csv {
	my ($csv, $name, $DEGs)=@_;
	my (%hash, %hash1);
	open CSV, $csv or die "can not open $csv\n";
	while (<CSV>) {
		chomp;
		s/\"//g;
		my @a=split /\,/;
		my $gene=$a[0];
		if (/baseMean/) {
			next;
		} elsif (/NA/) {
			next;
		} else {
			my $value=&determine_DEG($a[1], $a[2], $a[-1]);
			if ($value ne "-") {
				$hash{$a[0]}=$value;
			}
		}
	}

	open DEG, $DEGs or die "can not open $DEGs\n";
	while (<DEG>) {
		chomp;
		s/\"//g;
		my @a=split /\,/;
		my $gene=$a[0];
		if (/baseMean/) {
			next;
		} elsif (/NA/) {
			next;
		} else {
			my $value=&determine_DEG($a[1], $a[2], $a[-1]);
			$hash1{$a[0]}=$value;
		}
	}

	open LNC, "final_intergenic_LncRNA_classifier.txt";
	while (<LNC>) {
		chomp;
		s/\r//g;
		my @a=split /\t/;
		next if /^lncRNA_gene/;
		if ($hash{$a[0]} && $hash1{$a[2]}) {
			my $Ldim_gene=$a[2];
			my $info;
			if ($cont_1{$Ldim_gene}) {
				my $fm=$cont_1{$Ldim_gene};
				my $pos;
				$POS{$fm}?($pos="positive"):($pos="-");
				$info="$fm\tcontraction\t$pos";
			} elsif ($expa_1{$Ldim_gene}) {
				my $fm=$expa_1{$Ldim_gene};
				my $pos;
				$POS{$fm}?($pos="positive"):($pos="-");
				$info="$fm\texpasion\t$pos";
			} else {
				my $fm=$gene_fm{$Ldim_gene};
				my $pos;
				$POS{$fm}?($pos="positive"):($pos="-");
				$info="$fm\t-\t$pos";
			}
			print "$a[0]\t$hash{$a[0]}\t$a[2]\t$a[-2]\t$a[-1]\t$hash1{$a[2]}\t$info\t$name\n";
		}
	}
}

sub determine_DEG {
	my ($basemean, $Log2FoldChange, $padj)=@_;
	my $value;
#	$Log2FoldChange=abs($Log2FoldChange);
	if ($basemean>=10 && $Log2FoldChange>=0.3 && $padj<=0.05) {
		$value="up";
	} elsif ($basemean>=10 && $Log2FoldChange<=-0.3 && $padj<=0.05) {
		$value="down";
	} else {
		$value="-";
	}
	return($value);
}

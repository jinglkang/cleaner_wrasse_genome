#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

# divide the orthogroups

# /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
####################################################################################
# How to use "possvm"
# conda activate possvm
# export DISPLAY=:0.0
# python ~/software/possvm-orthology/possvm.py -i Gene_Trees/OG0007740_tree.txt
####################################################################################

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Cund Fugu Lber Ncel Smel Tbif Ldim);
my @refs=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu);

my %tre;
my @tree=<Gene_Trees/OG*_tree.txt>;
foreach my $tree (@tree) {
	(my $orth)=basename($tree)=~/(.*)_tree\.txt/;
	$tre{$orth}=$tree;
}

my %fas;
my @fastas=<Orthogroup_Sequences/*.fa>;
foreach my $fasta (@fastas) {
	(my $orth)=basename($fasta)=~/(.*)\.fa/;
	$fas{$orth}=$fasta;
}

#my $final="final_orth.txt";
#open FINAL, ">$final" or die "can not create $final\n";
my $left_run="left_orth_possvm";
open LEFT, ">$left_run" or die "can not create $left_run\n";
my $Orth_Gene_nb="Orthogroups/Orthogroups.GeneCount.tsv";
my (%Orth, %hash);
my $output="divid_orth";
#system("mkdir $output") unless -e $output;
my @header;
my $head;
open ORTH, $Orth_Gene_nb or die "can not open $Orth_Gene_nb\n";
while (<ORTH>) {
	chomp;
	if (/^Orthogroup/) {
		@header=split;
		for (my $i = 1; $i < @header-1; $i++) {
			if ($header[$i]=~/\_/) {
				my ($name1, $name2)=$header[$i]=~/(\D{1}).*_(\D{3}).*/;
				$header[$i]=$name1.$name2;
			}
		}
		foreach my $header (@header) {
			$head.=$header."\t";
		}
		$head=~s/\s+$//;
		print LEFT "$head\n";
	} else {
		my @a=split;
		my $orth=$a[0];
		my $value;
		for (my $i = 1; $i < @a-1; $i++) {
#			print "$header[$i]\n";
			$hash{$orth}->{$header[$i]}=$a[$i];
		}
		foreach my $ref (@refs) {
			if ($hash{$orth}->{$ref} >= 1) {
				$value++;
			}
		}
		if ($value && $value==6) {
#			print "$_\n";
			my $tree =$tre{$orth};
			my $tree1 =basename($tre{$orth});
			my $result = $output."/".$tree1.".ortholog_groups.csv";
			if (-e $result) {
				next;
			} else {
				my $cmd  ="python ~/software/possvm-orthology/possvm.py -i $tree -o $output";
				system($cmd);
				print LEFT "$_\n";
			}
		}
	}
}

#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Tbif Ldim);
my @refs=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu);
my %REF;
foreach my $ref (@refs) {
	$REF{$ref}++;
}

my $header="Orthogroup\t";
foreach my $spe (@spes) {
	$header.=$spe."\t";
}
$header=~s/\s+$//;
print "$header\n";

my @csvs=<divid_orth/*ortholog_groups.csv>;
foreach my $csv (@csvs) {
	open CSV, $csv or die "can not open $csv\n";
	(my $orth)=basename($csv)=~/(.*)\_tree\.txt\.ortholog_groups\.csv/;
	my (%hash, %hash1);
	my @new_orths;
	while (<CSV>) {
		chomp;
		my @a=split;
		if (/^gene/) {
			next;
		} else {
			my @b=split /\_/, $a[0];
			my ($spe, $gene)=($b[-2], $b[-1]);
			unless ($REF{$spe}) {
				$gene=$spe."_".$gene;
			}
			my $new_orth=$orth."_$a[1]";
			$hash{$new_orth}->{$spe}=[] unless exists $hash{$new_orth}->{$spe};
			push @{$hash{$new_orth}->{$spe}}, $gene;
			$hash1{$new_orth}++;
			push @new_orths, $new_orth if $hash1{$new_orth}==1;
		}
	}
	
	foreach my $new_orth (@new_orths) {
		my ($gene_info, $nb_info);
		$gene_info = $new_orth."\t";
		$nb_info   = $new_orth."\t";
		foreach my $spe (@spes) {
			if ($hash{$new_orth}->{$spe}) {
				my @genes = @{$hash{$new_orth}->{$spe}};
				foreach my $gene (@genes) {
					$gene_info.=$gene."\t";
				}
				my $nb    = @genes;
				$nb_info .= $nb."\t";
			} else {
				my $nb    = 0;
				$nb_info .= $nb."\t";
			}
		}
		$gene_info=~s/\s+$//;
		$nb_info  =~s/\s+$//;
#		print "$gene_info\n";
		print "$nb_info\n";
	}
}

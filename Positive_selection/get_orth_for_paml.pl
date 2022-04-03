#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

# divide the orthogroups

# /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
# conda activate possvm
# python ~/software/possvm-orthology/possvm.py -i Gene_Trees/OG0007740_tree.txt

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Cund Fugu Lber Ncel Smel Tbif Ldim);

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

my $final="final_orth.txt";
open FINAL, ">$final" or die "can not create $final\n";
my $Orth_Gene_nb="Orthogroups/Orthogroups.GeneCount.tsv";
my %Orth;
my $output="divid_orth";
system("mkdir $output") unless -e $output;
my (@header, $single_orth, $multi_orth);
open ORTH, $Orth_Gene_nb or die "can not open $Orth_Gene_nb\n";
while (<ORTH>) {
	chomp;
	if (/^Orthogroup/) {
		@header=split;
	} else {
		my @a=split;
		my $orth=$a[0];
		my $value;
		for (my $i = 1; $i < @a; $i++) {
			($a[$i]>0)?($value=1):($value=0);
			last if $value==0;
		}
		if ($value==1) {
			my $j;
			for (my $i = 1; $i < @a; $i++) {
				if ($a[$i]==1) {
					$j++;
				}
			}
			if ($j==12) {
#				push @single_orth, $a[0];
				my $fasta=$fas{$orth};
				my %hash;
				open FASTA, $fasta or die "can not open $fasta\n";
				while (<FASTA>) {
					chomp;
					if (/>/) {
						s/>//;
						(my $spe)=$_=~/(.*)_.*/;
						$hash{$spe}=$_;
					}
				}
				my $info=$orth."\t";
				foreach my $spe (@spes) {
					$info.=$hash{$spe}."\t";
				}
				$info=~s/\s+$//;
				print FINAL "$info\n";
			} else {
#				push @multi_orth, $a[0];
				my $fasta=$fas{$orth};
				my $tree =$tre{$orth};
				my $cmd  ="python ~/software/possvm-orthology/possvm.py -i $tree -o $output";
				system($cmd);
				$tree =basename($tre{$orth});
				my $result = $output."/".$tree.".ortholog_groups.csv";
				my (%hash1, %hash2);
				my @orths;
				open RESULT, $result or die "can not open $result\n";
				while (<RESULT>) {
					chomp;
					my @b=split;
					if (/^gene/) {
						next;
					} else {
						my $new_orth=$orth."_$b[1]";
						$hash1{$new_orth}++;
						push @orths, $new_orth if $hash1{$new_orth}==1;
						my @c=split /\_/, $b[0];
						my $gene=$c[-2]."_".$c[-1];
						$hash2{$new_orth}=[] unless exists $hash2{$new_orth};
						push @{$hash2{$new_orth}}, $gene;
					}
				}
				foreach my $new_orth (sort keys %hash1) {
					my (%hash3, %hash4);
					my (@new_genes, @new_spes);
					my @genes=@{$hash2{$new_orth}};
					foreach my $gene (@genes) {
						(my $spe)=$gene=~/(.*?)\_.*/;
						$hash3{$spe}++;
						if ($hash3{$spe}==1) {
							push @new_spes, $spe;
							$hash4{$spe}=$gene;
						}
					}
					if (@new_spes==12) {
						my $info=$new_orth."\t";
						foreach my $spe (@spes) {
							$info.=$hash4{$spe}."\t";
						}
						$info=~s/\s+$//;
						print FINAL "$info\n";
					}
				}
			}
		}
	}
}

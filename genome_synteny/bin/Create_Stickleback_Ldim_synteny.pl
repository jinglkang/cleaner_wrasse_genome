#!/usr/bin/perl -w
use strict;
use warnings;

# extract the one-to-one orthologous between Ldim and Stickleback
# working dir: /media/HDD/cleaner_fish/genome/synteny
# Ldim_longest_pep_info.txt; Stickleback_longest_pep_info.txt
# Ldim_gene_location.txt; Stickleback_gene_chr.txt
# Orthogroups between Stickleback and Ldim: Stickleback_Ldim_orthogroup.txt

my $cmd1="cat Ldim_longest_pep_info.txt Stickleback_longest_pep_info.txt >total_info";
system($cmd1);

my %long;
open LONG, "total_info" or die "can not open total_info\n";
while (<LONG>) {
	chomp; my @a=split;
	my $name=$a[0]."\t".$a[1];
	$long{$a[0]}=$name;
}

my $cmd2="cat Ldim_gene_location.txt Stickleback_gene_chr.txt >location_info";
system($cmd2);

my %loca;
open FIL1, ">long_Non_eq.txt" or die "can not create long_Non_eq.txt\n";
open FIL2, ">Non_long.txt" or die "can not create Non_long.txt\n";
open LOCA, "location_info" or die "can not open location_info\n";
while (<LOCA>) {
	chomp; my @a=split;
	my $name=$a[0]."\t".$a[1];
	if ($long{$a[0]} && ($long{$a[0]} eq $name)) {
		if ($a[0]=~/EN/) {
			my $new_name="Stickleback_".$a[0];
			$loca{$new_name}=$a[2]."\t".$a[3]."\t".$a[4];
		} else {
			$loca{$a[0]}=$a[2]."\t".$a[3]."\t".$a[4];
		}
	} elsif ($long{$a[0]} && ($long{$a[0]} ne $name)) {
		print FIL1 "$name\t$long{$a[0]}\n";
	} else {
		print FIL2 "$name\n";
	}
}

system("rm total_info location_info");

my $syn="Stickleback_Ldim_synteny.txt";
my $non="Non_detected_Stickleback_Ldim_synteny.txt";
open SYN, ">$syn" or die "can not create $syn\n";
open NON, ">$non" or die "can not create $non\n";
my $orth="Stickleback_Ldim_orthogroup.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
	chomp; next if /^Orth_ID/;
	my @a=split;
	if ($a[2]==1 && $a[4]==1) {
		if ( $loca{$a[3]} && $loca{$a[5]} ) {
			print SYN "$loca{$a[3]}\t$loca{$a[5]}\n";
		} else {
			print NON "$a[3]\t$a[5]\n";
		}
	}
}

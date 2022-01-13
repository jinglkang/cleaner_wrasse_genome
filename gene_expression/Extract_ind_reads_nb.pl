#!/usr/bin/perl -w
use strict;
use warnings;

my @solos_1=qw(LD5 LD6 LD15 LD16 LD25 LD26);
my @inter_1=qw(LD3 LD4 LD13 LD14 LD23 LD24);
my @tissu=qw(FB MB HB);

my %hash;
foreach my $tis (@tissu) {
	my $ind;
	foreach my $solo (@solos_1) {
		$ind=$solo.$tis;
		$hash{$tis}->{"solo"}=[] unless exists $hash{$tis}->{"solo"};
		push @{$hash{$tis}->{"solo"}}, $ind;
	}

	foreach my $inte (@inter_1) {
		$ind=$inte.$tis;
		$hash{$tis}->{"inter"}=[] unless exists $hash{$tis}->{"inter"};
		push @{$hash{$tis}->{"inter"}}, $ind;
	}
}


my (@header, @ids); my %nb;
open FILE, $ARGV[0] or die "can not open $ARGV[0]\n";
while (<FILE>) {
	chomp;
	next if /^#/;
	my @a=split;
	if (/^Geneid/) {
		for (my $i = 0; $i < @a; $i++) {
			$a[$i]=~s/\.sorted\.bam//;
			push @header, $a[$i];
		}
	} else {
		for (my $i = 6; $i < @a; $i++) {
			$nb{$a[0]}->{$header[$i]}=$a[$i];
		}
		push @ids, $a[0];
	}
}


my ($name)=$ARGV[0]=~/(.*)\.txt/;
foreach my $tis (@tissu) {
	my $file=$name."_".$tis.".txt";
	open TIS, ">$file" or die "can not create $file\n";
	my @ind_solo=@{$hash{$tis}->{"solo"}};
	my @ind_inte=@{$hash{$tis}->{"inter"}};

	my ($i, $start); $start="Geneid"."\t";
	foreach my $id (@ids) {
		$i++;
		my $info.=$id."\t";
		foreach my $ind (@ind_solo) {
			$start.=$ind."\t" if $i==1;
			$info.=$nb{$id}->{$ind}."\t";
		}
		foreach my $ind (@ind_inte) {
			$start.=$ind."\t" if $i==1;
			$info.=$nb{$id}->{$ind}."\t";
		}
		$info =~s/\s+$//;
		$start=~s/\s+$//;
		print TIS "$start\n" if $i==1;
		print TIS "$info\n";
	}
}

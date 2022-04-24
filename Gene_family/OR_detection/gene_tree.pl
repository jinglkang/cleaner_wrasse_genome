#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

# construct the gene tree to detect the potential opsin
# in the dir "genewise/"
my @spe=qw(Cheilinus_undulatus Cleaner_wrasse Fugu Labrus_bergylta Medaka Notolabrus_celidotus Platyfish Spottedgar Stickleback Symphodus_melops Thalassoma_bifasciatum Zebrafish);
foreach my $spe (@spe) {
	chdir "/media/HDD/cleaner_fish/genome/OR_detection/$spe/genewise";
	my $cmd2="cp ../../OR_class_zebrafish_L.oculatus.fasta ./";
	my $cmd3="cat query.fa.bla.solar.besthit.lt250.wise.best.1.aa OR_class_zebrafish_L.oculatus.fasta >1.fa";
	my $cmd4="muscle -in 1.fa -out 2.fa";
	my $cmd5="less 2.fa|perl -alne 'if (/>/){s/\:/_/g;print}else{print}' >3.fa";
	my $cmd6="FastTreeMP 3.fa >tree";
	my $cmd7="mv tree /media/HDD/cleaner_fish/genome/OR_detection/$spe.tre";
	system($cmd2); system($cmd3); system($cmd4);
	system($cmd5); system($cmd6); system($cmd7);
	chdir "/media/HDD/cleaner_fish/genome/OR_detection/";
}

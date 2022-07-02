#!/usr/bin/perl
use strict;
use warnings;

my @species=qw(Cheilinus_undulatus Fugu Labroides_dimidiatus Labrus_bergylta Medaka Notolabrus_celidotus Platyfish Semicossyphus_pulcher Spottedgar Stickleback Symphodus_melops Tautogolabrus_adspersus Thalassoma_bifasciatum Zebrafish);
my $swiss="~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta";
my $query=$ARGV[0];
foreach my $spe (@species) {
        my $dir  ="/media/HDD/cleaner_fish/genome/All_genomes/";
        my $fasta="$spe.fasta";
        my $genom="$dir/$fasta";
        my $gtf  ="$dir/$spe.fasta";
        my $pep  ="$dir/longest_pep/$fasta";
        system("perl Gmfm_detect --genome $genom --species $spe --intron 1000 --query $ARGV[0] --uniprot $swiss --gtf $gtf --pep $pep");
}

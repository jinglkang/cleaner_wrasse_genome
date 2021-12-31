#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

# working dir: /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id

system("mkdir single_copy_cds") if ! -e "single_copy_cds";
my $ann="all_anno.fasta";
system("cat Longest_*.fasta >all_anno.fasta");

my %anno;
my $gene;
open ANNO, "$ann" or die "can not open $ann\n";
while (<ANNO>) {
        chomp;
        if (/>/) {
                s/>//;
                $gene=$_;
        } else {
                s/\s+$//;
                $anno{$gene}.=$_;
        }
}

my @fas=<../single_copy/*.fasta>;
foreach my $fas (@fas) {
        (my $id)=basename($fas);
        open CDS, ">single_copy_cds/$id";
        open FAS, "$fas" or die "can not open $fas\n";
        while (<FAS>) {
                chomp;
                if (/>/) {
                        if (/ENS/) {
                                (my $gene)=$_=~/_(.*)/;
                                if ($anno{$gene}) {
                                        print CDS "$_\n$anno{$gene}\n";
                                } else {
                                        print "There is no anno info of $_\n";
                                }
                        } else {
                                (my $gene)=$_=~/\>(.*)/;
                                if ($anno{$gene}) {
                                        print CDS "$_\n$anno{$gene}\n";
                                } else {
                                        print "There is no anno info of $_\n";
                                }
                        }
                }
        }
        chdir("single_copy_cds/");
        my $align=$id."-align.fas";
        my $trim=$id."-trim.fas";
        my $cmd1="muscle -in $id -out $align";
        my $cmd2="trimal -in $align -out $trim -gt 0.9 -st 0.001 -cons 60";
        system($cmd1);
        system($cmd2);
        system("rm $align");
        system("mv $trim $id");
        close FAS;
        close CDS;
        chdir("../");
}

system("rm $ann");

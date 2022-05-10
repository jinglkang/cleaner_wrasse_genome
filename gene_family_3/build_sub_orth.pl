#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

# divide the orthogroups

# /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
####################################################################################
# How to use "possvm"
# conda activate possvm
# python ~/software/possvm-orthology/possvm.py -i Gene_Trees/OG0007740_tree.txt
####################################################################################

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Lber Ncel Smel Spul Tads Tbif Ldim);

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

my $Orth_Gene_nb="Orthogroups/Orthogroups.GeneCount.tsv";
my %Orth;
my $output="sub_orth";
system("mkdir $output") unless -e $output;

my $sub_orth_nb="sub_orth/sub_orth_genecount.txt"; # gene count number for sub_orth
open SUB_ORTH_NB, ">$sub_orth_nb" or die "can not create $sub_orth_nb\n";

my $sub_orth_id="sub_orth/sub_orth_id.txt"; # all gene id for each sub orth
open SUB_ORTH_ID, ">$sub_orth_id" or die "can not create $sub_orth_id\n";

# my $seq_dir="sub_orth/sequence"; # put the sequences of sub orthogroups to $seq_dir
# system("mkdir $seq_dir") unless -e $seq_dir;

my @header; my $new_header="Orthogroup\t";
open ORTH, $Orth_Gene_nb or die "can not open $Orth_Gene_nb\n";
while (<ORTH>) {
        chomp;
        my %gene_nb; my $j;
        if (/^Orthogroup/) {
                @header=split;
                foreach my $spe (@spes) {
                        $new_header.=$spe."\t";
                }
                $new_header=~s/\s+$//;
                print SUB_ORTH_NB "$new_header\n";
        } else {
                my @a=split;
                my $orth=$a[0];
                for (my $i = 1; $i <= 14; $i++) {
                        if ($a[$i]==1) {
                                $j++;
                        }
                        my $symbol;
                        if ($header[$i]=~/(\D{1})\D+\_(\D{3})\D+/) {
                                $symbol=$1.$2;
                        } else {
                                $symbol=$header[$i];
                        }
                        $gene_nb{$symbol}=$a[$i];
                }

                my $info1=$orth."\t";
                foreach my $spe (@spes) {
                        $info1.=$gene_nb{$spe}."\t";
                }
                $info1=~s/\s+$//;

                my $fasta=$fas{$orth};
                if ($j==14) { # for single copy genes
                        print SUB_ORTH_NB "$info1\n";
                        my %id; # for seq id in Orthogroup_Sequences/*.fa
                        my $species;
                        open FASTA, $fasta or die "can not open $fasta\n";
                        while (<FASTA>) {
                                chomp;
                                if (/>/) {
                                        s/>//;
                                        (my $species)=$_=~/(.*)\_/;
                                        $id{$species}.=$_.", ";
                                }
                        }

                        my $info2=$orth."\t";
                        foreach my $spe (@spes) {
                                my $id_info=$id{$spe};
                                $id_info=~s/\,\s+$//;
                                $info2.=$id_info."\t";
                        }
                        $info2=~s/\s+$//;
                        print SUB_ORTH_ID "$info2\n";

                } else { # for mutiple copy genes
                        my $tree =$tre{$orth};
                        my $output2=$output."/possvm_output";
                        system("mkdir $output2") unless -e $output2;

                        my $cmd="python ~/software/possvm-orthology/possvm.py -i $tree -o $output2";
                        system($cmd);
                        $tree =basename($tre{$orth});
                        my $result = $output2."/".$tree.".ortholog_groups.csv";
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
                                        my $spe=$c[-2];
                                        $hash2{$new_orth}->{$spe}=[] unless exists $hash2{$new_orth};
                                        push @{$hash2{$new_orth}->{$spe}}, $gene;
                                }
                        }
                        foreach my $new_orth (sort keys %hash1) {
                                my $info3=$new_orth."\t";
                                my $info4=$new_orth."\t";
                                foreach my $spe (@spes) {
                                        my $nb;
                                        if ($hash2{$new_orth}->{$spe}) {
                                                my @genes=@{$hash2{$new_orth}->{$spe}};
                                                my $nb=@genes;
                                                $info3.=$nb."\t";
                                                my $info5;
                                                foreach my $gene (@genes) {
                                                        $info5.=$gene.", ";
                                                }
                                                $info5=~s/\s+$//;
                                                $info4.=$info5."\t";
                                        } else {
                                                my $nb=0;
                                                $info3.=$nb."\t";
                                                my $gene="";
                                                $info4.=$gene."\t";
                                        }
                                }
                                $info3=~s/\s+$//;
                                $info4=~s/\s+$//;
                                print SUB_ORTH_NB "$info3\n";
                                print SUB_ORTH_ID "$info4\n";
                        }
                }
        }
}

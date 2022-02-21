#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;
use Getopt::Long 'HelpMessage';
use Parallel::ForkManager;

my $usage=<<_EOH_;
------------------------------------------------------------------------------------------
This script is used to run StringTie to assemble and merge transcripts

Usage:
run_stringtie.pl --bams ../ \
--ref_gtf ref.gtf \
--output final.gtf

                                                Kang 2022-02-21
------------------------------------------------------------------------------------------
_EOH_
;

GetOptions(
        'bams:s', \ my $bamdir,                 # the bam files directory
        'ref_gtf:s', \my $ref_gtf,              # the genome gtf file
        'output:s', \my $output,                # the final output merged gtf file
        'help', \ my $help
        );

if ($help || (! $bamdir) && (! $ref_gtf) && (! $output) ) {
        die $usage; # all of these options are mandatory requirements
}

# 1. assemble transcripts for each sample
my @bams=<$bamdir/*.bam>;
my @cmds; my @gtfs;
foreach my $bam (@bams) {
        (my $ind)=basename($bam)=~/(.*)\.bam/;
        my $ind_gtf=$ind.".gtf";
        push @gtfs, $ind_gtf;
        my $cmd="stringtie $bam -p 12 -G $ref_gtf -o $ind_gtf";
        push @cmds, $cmd;
}

my $manager = new Parallel::ForkManager(2);
foreach my $cmd (@cmds) {
        $manager->start and next;
        system($cmd);
        $manager->finish;
}
$manager -> wait_all_children;

# 2. merge the transcripts
my $merge="stringtie --merge -p 24 -G $ref_gtf -o $output ";
foreach my $gtf (@gtfs) {
        $merge.=$gtf." ";
}
$merge=~s/\s+$//;
system($merge);

#!/usr/bin/perl
use strict;
use warnings;

# Extract the best blastp result and the percentage of identical matches shoould be larger than 20%

my (%hash, %hash1);
my @names;

open SWIS, "/home/kang1234/swiss-prot/unprot_name_description.txt" or die "can not open unprot_name_description.txt\n";
while (<SWIS>) {
        chomp;
        my @a=split /\t/;
        $hash1{$a[0]}=$a[1];
}
close SWIS;

open FIL, "Ldim_blastp.result.txt" or die "$!\n";
while (<FIL>) {
        chomp;
        my @a=split;
        my $name=$a[0];
        my $percen=$a[2];
        my $ano=$hash1{$a[1]};
        if ($hash{$name}) {
                my $new_score=$a[-1];
                my $old_score=$hash{$name}->{'score'};
                if ($new_score > $old_score) {
                        $hash{$name}={
                                info => $_,
                                score => $new_score,
                                ano => $ano
                        };
                }
        } elsif ($percen > 20) {
                $hash{$name}={
                        info => $_,
                        score => $a[-1],
                        ano => $ano
                };
                push @names, $name;
        }
}
close FIL;

foreach my $name (@names) {
        my $value=$hash{$name}->{'info'};
        my $ano=$hash{$name}->{'ano'};
        print "$value\t$ano\n";
}

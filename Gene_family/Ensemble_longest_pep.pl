#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
                'fasta:s{1,}', \my @fasta,# the overall reads number matrix
                );

foreach my $fas (@fasta) {
        my ($genes, $hash1, $hash2)=extract_info_fasta($fas);
        my %hash;
        my $output="Longest_".$fas;
        open OUTPUT, ">$output" or die "can not open $output\n";
        foreach my $gene (@{$genes}) {
                my $time=${$hash1}{$gene};
                for (my $i = 1; $i < $time+1; $i++) {
                        my $len1=${$hash2}{$gene}->{$i}->{'len1'};
                        my $len2=${$hash2}{$gene}->{$i}->{'len2'};
                        my $seq=${$hash2}{$gene}->{$i}->{'seq'};
#                       print "$gene\t$i\t$len1\t$len2\n";
                        if ($hash{$gene}) {
                                my $len=$hash{$gene}->{'len1'};
                                if ($len1 >=$len) {
                                        $hash{$gene}={
                                                'time' => $i,
                                                'len1' => $len1,
                                                'len2' => $len2,
                                                'seq' => $seq
                                        };
                                }
                        } else {
                                $hash{$gene}={
                                        'time' => $i,
                                        'len1' => $len1,
                                        'len2' => $len2,
                                        'seq' => $seq
                                };
                        }
                }
        }
        foreach my $gene (@{$genes}) {
                my $len1=$hash{$gene}->{'len1'};
#               my $len2=$hash{$gene}->{'len2'};
                my $seq=$hash{$gene}->{'seq'};
#               my $time=$hash{$gene}->{'time'};
#               print "$gene\t$time\t$len1\t$len2\n" if $len1 > 0;
                print OUTPUT ">$gene\n$seq\n" if $len1 > 0;
        }
        close OUTPUT;
}

sub extract_info_fasta {
        my ($fasta)=@_;
        my @genes;
        my ($gene, $len);
        my (%hash1, %hash2, %hash3);
        open FASTA, "$fasta" or die "can not open $fasta\n";
        while (<FASTA>) {
                chomp;
                if (/>/) {
                        s/>//;
                        my @a=split /\|/;
                        $gene=$a[0];
                        $a[1]?($len=$a[1]):($len=0);
                        $hash1{$gene}++;
                        push @genes, $gene if $hash1{$gene}==1;
                } else {
                        my $time=$hash1{$gene};
                        $hash2{$gene}->{$time} .= $_;
                        my $seq=$hash2{$gene}->{$time};
                        my $len2=length($seq);
                        $hash3{$gene}->{$time}={
                                len1 => $len,
                                len2 => $len2,
                                seq => $seq
                        };
                }
        }
        return(\@genes, \%hash1, \%hash3);
}

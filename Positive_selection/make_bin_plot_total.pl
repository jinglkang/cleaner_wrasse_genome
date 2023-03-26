use strict;
use warnings;

my (%hash1,%hash2);
my @bins=("[0,0.025]","(0.025,0.05]","(0.05,0.075]","(0.075,0.1]","(0.1,0.15]","(0.15,0.2]","(0.2,0.3]","(0.3,0.4]","(0.4,0.5]","(0.5,1]",">1");
print "species\tBin\tNumber\tmean_dN\tmean_dS\tmean_len\n";
open "fil", "free_ratio_result.txt";  # output sequence number in different bins
while (<fil>) {
    chomp;
    my @a=split;
    my $spe=$a[1];
    if (/^Orth_id/) {
        next;
    } else {
        foreach my $bin (@bins) {
            if ($bin eq "[0,0.025]") {
                if ($a[-5]>=0 && $a[-5]<=0.025) {
                        $hash1{$spe}->{$bin}++;
                        $hash2{$spe}->{$bin}->{'dN'} += $a[-4];
                        $hash2{$spe}->{$bin}->{'dS'} += $a[-3];
                        $hash2{$spe}->{$bin}->{'len'} += $a[2];
                }
            } elsif ($bin eq ">1") {
                if ($a[-5] > 1) {
                        $hash1{$spe}->{$bin}++;
                        $hash2{$spe}->{$bin}->{'dN'} += $a[-4];
                        $hash2{$spe}->{$bin}->{'dS'} += $a[-3];
                        $hash2{$spe}->{$bin}->{'len'} += $a[2];
                }
            } else {
                (my $low, my $up)=$bin=~/\((.*)\,(.*)\]/;
                if ($a[-5]>$low && $a[-5]<=$up) {
                        $hash1{$spe}->{$bin}++;
                        $hash2{$spe}->{$bin}->{'dN'} += $a[-4];
                        $hash2{$spe}->{$bin}->{'dS'} += $a[-3];
                        $hash2{$spe}->{$bin}->{'len'} += $a[2];
                }
            }
        }
    }
}

foreach my $spe (keys %hash1) {
    foreach my $bin (@bins) {
        my $num=$hash1{$spe}->{$bin};
        my $dN_total=$hash2{$spe}->{$bin}->{'dN'};
        my $dS_total=$hash2{$spe}->{$bin}->{'dS'};
        my $len_total=$hash2{$spe}->{$bin}->{'len'};
        my $mean_dN=sprintf("%.4f",$dN_total/$num);
        my $mean_dS=sprintf("%.4f",$dS_total/$num);
        my $mean_len=sprintf("%.0f",$len_total/$num);
        print "$spe\t$bin\t$num\t$mean_dN\t$mean_dS\t$mean_len\n";
    }
}

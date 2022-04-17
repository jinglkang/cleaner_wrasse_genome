#!/usr/bin/perl -w
use strict;
use warnings;
use Statistics::Test::WilcoxonRankSum;

my $orth="final_orth.txt.1";
my %ORTH;
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
    chomp;
    my @a=split;
    $ORTH{$a[0]}=$a[-1]; # get the gene id of Ldim
}

my %dNdS;
my @spe=qw(Ldim Tbif Smel Lber Cund Ncel);
open FREE, "free_ratio_result.txt" or die "can not open free_ratio_result.txt\n";
while (<FREE>) {
    chomp;
    if (/^Orth_id/) {
        next;
    } else {
        my @a=split;
        my $gene=$ORTH{$a[0]};
        my $spe=$a[1];
        $dNdS{$gene}->{$spe}=$a[7];
#        print "$a[0]\t$gene\t$spe\t$dNdS{$gene}->{$spe}\n";
    }
}

my (%go, %len);
my @go_name;
open GO, "Ldim_kaks_enrichment.txt" or die "can not open Ldim_kaks_enrichment.txt\n";
while (<GO>) {
    chomp;
    if (/^Tags/){
        next;
    } else {
        my @a=split /\t/;
        my $go_name=$a[1]."\t".$a[2]."\t".$a[3];
        push @go_name, $go_name;
        my @gene=split /\;/, $a[-1];
        my $t_len=scalar(@gene);
        $len{$go_name}=$t_len;
        foreach my $gene (@gene) {
            foreach my $spe (@spe) {
                if ($dNdS{$gene}->{$spe}) {
                    my $kaks=$dNdS{$gene}->{$spe};
                    push @{$go{$go_name}->{$spe}}, $kaks;
#                    print "$gene\t$spe\t$kaks\n";
                }
            }
        }
    }
}

foreach my $go_name (@go_name) {
    my $info;
    my $t_len=$len{$go_name};
    $info=$go_name."\t";
    my (%num,%p,%wil);
    foreach my $spe (@spe) {
        my $len;
        ($go{$go_name}->{$spe})?($len=@{$go{$go_name}->{$spe}}):($len=0);
        $num{$spe}=$len;
#       my $len=@{$go{$go_name}->{$spe}};
#       $info.=$spe."\t".$len."\t";
    }
    my $ratio=($num{'Ldim'})/($t_len);
    $ratio=sprintf("%.2f",$ratio);
    $info.="Ldim"."\t".$num{'Ldim'}."\t"."$ratio"."\t";
    my @spe_new=qw(Tbif Smel Lber Cund Ncel);
    if ($num{'Ldim'} >=5 && $num{'Tbif'} >=5 && $num{'Smel'} >=5 && $num{'Lber'} >=5  && $num{'Cund'} >=5 && $num{'Ncel'} >=5 ) {
        my @pf;
        my @Ldim=@{$go{$go_name}->{'Ldim'}};
#       my @Daru=@{$go{$go_name}->{'Daru'}};
#       my @Ocomp=@{$go{$go_name}->{'Ocomp'}};
#       my @Pmol=@{$go{$go_name}->{'Pmol'}};
#       my @Padel=@{$go{$go_name}->{'Padel'}};
#       my @Acura=@{$go{$go_name}->{'Acura'}};
        foreach my $spe (qw (Tbif Smel Lber Cund Ncel)) {
            my $wilcox_test = Statistics::Test::WilcoxonRankSum->new();
            my @data2=@{$go{$go_name}->{$spe}};
            $wilcox_test->load_data(\@Ldim, \@data2);
            my $prob = $wilcox_test->probability();
            my $pf = sprintf '%f', $prob;
            my $su = $wilcox_test->summary();
            my $stat;
            $p{$spe} = $pf;
            if ($pf <= 0.05) {
                ($su=~/higher/)?($stat="higher"):($stat="lower");
                $wil{$spe}=$stat;
                push @pf, $pf;
            } else {$wil{$spe}="Undef"}
        }
        if (@pf>=5) {
            foreach my $spe (qw(Tbif Smel Lber Cund Ncel)) {
                my $ratio=($num{$spe})/($t_len);
                $ratio=sprintf("%.2f",$ratio);
                $info.=$spe."\t".$num{$spe}."\t".$p{$spe}."\t".$wil{$spe}."\t".$ratio."\t";
            }
        $info=~s/\s+$//;
        print "$info\n";
        }
    }
#   $info=~s/\s+//;
#   print "$info\n";
}

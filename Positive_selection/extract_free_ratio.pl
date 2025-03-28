use strict;
use warnings;
open "fil", "$ARGV[0]";
my @names=<fil>;
my $header="Orth_id\tspecies\tlenth\t";
$header.="branch\tt\tN\tS\tdN/dS\tdN\tdS\tN*dN\tS*dS\n";
open BRANCH, ">>free_ratio_result.txt";
print BRANCH "$header";
foreach my $name (@names) {
        chomp $name;
        my $i;
        my ($len,$tag);
        my (%spe);
        open "fil1", "$name/free-ratio-result.txt";
        while (<fil1>) {
                chomp;
                $i++;
                my @a=split;
                if ($i==1) {
                        $len=$a[-1];
                } elsif (/^#/) {
                        $a[0]=~/#(\d+):/;
                        my $tag=$1;
                        $spe{$tag}=$a[-1];
                }elsif (@a==9 && $a[-1]=~/\d+\.\d+/) {
                        my $first=shift @a;
                        $first=~/\d+\.\.(\d+)/;
                        my $tag=$1;
                        $a[0]=~s/\.\./\_/;
                        my $len2=$a[2]+$a[3];
                        unless ($a[-3]>1 || $a[2]>$len || $len2>$len+50 || $a[-2]<1 || $a[-1]<1) {
                                print BRANCH "$name\t$spe{$tag}\t$len\t$_\n" if (exists $spe{$tag});
                        }
                }
        }
}

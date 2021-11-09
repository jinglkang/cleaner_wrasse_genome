#!/usr/bin/perl -w
my $usage=<<EOF;
------------------------------------------------------------------------
Feed me with the text output from genewise (-pseudo -genesf), I'll give you non-overlapped best results.
This is what I'm gonna do:
1) sort the genewise output file in order of scaffold name (strand included) and decreasing genewise score.
2) go though the file line by line and print if it have no overlap with printed results.

Usage: perl $0 *.wise >*.wise.best
                                                                                Du Kang 2017-07-14
-----------------------------------------------------------------------
EOF

$ARGV[0] or die $usage;
`cp $ARGV[0] tmp20171004`;
system (q#cat tmp20171004 |perl -pe 's/\n/&/;s/genewise \$Name/\ngenewise \$Name/g'|perl -lane 'next if /^\s*$/;/\&Target Sequence\s+(.*?)\&Strand:\s+(.*)\&Start\/End.*Score (.*?) bits.*\&Gene 1\&Gene (\S+) (.*?)( \[pseudogene\])?\&\s+Exon/;print "$1\t$2\t$3\t$4\t$5\t$_"' >tmp20171005#);
system (q#sort -k1,1 -k2,2 -k3,3nr tmp20171005 -o tmp20171005#);

use Set::IntervalTree;
$flag='initial';
open IN, "tmp20171005" or die $!;
while (<IN>) {
        chomp;
        @_=split;
        $scaffold=$_[0];
        if($_[1] eq 'forward'){
                $current=$scaffold."for";
                $low=$_[3];
                $high=$_[4];
        }else{
                $current=$scaffold."rev";
                $low=$_[4];
                $high=$_[3];
        }
        $quote=quotemeta($_[0]);
        s/$quote\t$_[1]\t$_[2]\t$_[3]\t$_[4]\s+//;
        if ($current ne $flag) {
                $flag=$current;
                $tree = Set::IntervalTree->new;
                $object=1;
                $tree->insert($object,$low,$high);
                s/&/\n/g;
                print;
        }else {
                $results = $tree->fetch($low,$high);
                if (! scalar(@$results)){
                        $object++;
                        $tree->insert($object,$low,$high);
                        s/&/\n/g;
                        print;
                }
        }
}

`rm tmp20171004 tmp20171005`;

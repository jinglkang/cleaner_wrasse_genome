#!/usr/bin/perl -w

my $usage=<<EOF;
------------------------------------------------------------------------
Feed me with bla.solar output, I'll give you non-overlapped best hit.
This is what I'm gonna do:
1) sort the solar output file in order of scaffold name (strand included) and decreasing bit score.
2) go though the file line by line and print if it have no overlap with printed results.

Usage: $0 bla.out.solar >bla.out.solar.besthit
                                                                                Du Kang 2017-09-06
------------------------------------------------------------------------
EOF

$ARGV[0] or die $usage;
$tmpfile="$ARGV[0].tmp20170906";
`cp $ARGV[0] $tmpfile`;
`sort -k6,6 -k5,5 -k11,11nr $tmpfile -o $tmpfile`;


use Set::IntervalTree;
$flag='initial';
open IN, $tmpfile or die $!;
while (<IN>) {
        @_=split;
        $current= $_[4] eq "+"? $_[5]."for" : $_[5]."rev";
        $low=$_[7];
        $high=$_[8];
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

unlink $tmpfile;

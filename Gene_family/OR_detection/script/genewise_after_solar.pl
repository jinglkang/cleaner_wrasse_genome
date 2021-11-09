#!/usr/bin/perl -w
my $usage=<<EOF;
----------------------------------------------------
Feed me with output from solar.pl, I'll give you the genewise results.
I also give you *.done.list file, so you can know how many rows I have done for you at the moment.

Usage: $0 pool.fa bla.out.solar
        # hint: if you want using me in nohup parallel, put a "2>&1 >bla.out.solar.nohup" in the cmd end, it helps to fix the problem "memory access violation".

Demo of bla.out.solar:
DareOR10.11     334     21      319     -       flattened_line_10233    2504    206     1011    2       105     21,108;141,319; 1011,748;748,206;       -40;-65;
XetrORs34.40    333     35      331     -       flattened_line_10233    2441    1542    2441    1       83      35,331; 2441,1542;      -83;
BrflORs41.4     346     41      346     +       flattened_line_1027     86762   85815   86762   1       88      41,346; 85815,86762;    +88;
DareOR21.28     322     9       318     -       flattened_line_10587    2080    1145    2080    1       139     9,318;  2080,1145;      -139;
---------------------------------------------------

EOF

@ARGV or die $usage;

$fname=$ARGV[1]=~/.*\/(.*)/? $1 : $ARGV[1];
        # get the base name

# build the name-seq hash
open SEQ, $ARGV[0] or die $usage;
while (<SEQ>) {
        chomp;
        if (/>/) {
                s/>//;
                @_=split;
                $name=$_[0];
        }else{
                $seq{$name}.=$_;
        }
}
close SEQ;

# for each row of the solor output table, build the p.fa and d.fa, and run genewise.
open TAB, $ARGV[1] or die $usage;
$d_seq="";
while (<TAB>) {
        @_=split /\t/, $_;
        $p_name=$_[0];
        $d_name=$_[5];
#       $p_start=$_[2];
#       $p_end=$_[3];
        $ds= $_[7];
        $de= $_[8];
#       $h_length=$de-$ds+1;
#       $p_length=$_[1];
        $d_length=length $seq{$d_name}; # solar sometimes report wrong length of the hit sequence

        $strand= $_[4] eq '+' ? "tfor" : "trev";
#       $d_start= int($ds-3/2*$p_length) >0? int($ds-3/2*$p_length) : 1;
        $d_start= int($ds-280) >0? int($ds-280) : 1;
#       $d_end= int($de+3/2*$p_length) <$d_length? int($de+3/2*$p_length) : $d_length;
        $d_end= int($de+280) <$d_length? int($de+280) : $d_length;

        open P, ">$fname.p.fa";
        print P ">$p_name\n$seq{$p_name}\n";
        close P;

        open D, ">$fname.d.fa";
        $d_seq=substr($seq{$d_name}, $d_start-1, $d_end-$d_start+1);    # I have to do this, if you let genewise do it, it's going to be highly time-consuming
        print D ">$d_name\n$d_seq\n";
        close D;

        `genewise $fname.p.fa $fname.d.fa -quiet -$strand -pseudo -genesf >WISE`;
        open OUT, ">>$fname.wise";
        open GENE_WISE, "WISE";
        while (<GENE_WISE>) {
                chomp;
                if(/(Gene|Exon|Supporting)\s+(\d+)\s+(\d+)/){
                        $os=$2;
                        $oe=$3;
                        $ns=$os+$d_start-1;
                        $ne=$oe+$d_start-1;
                        s/$os\s+$oe/$ns $ne/;
                }
                print OUT "$_\n";
        }
        close OUT;

        # open DONE, ">>$fname.done.list";
        # print DONE "$_";
        #close DONE;
}
close TAB;

#clean up the battlefield
`rm $fname.p.fa $fname.d.fa WISE`;

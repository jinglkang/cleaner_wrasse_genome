use strict;
use warnings;
use File::Basename;

my @Apoly=<*_R1.fq.gz>;
foreach my $Apoly (@Apoly) {
        (my $name)=basename ($Apoly)=~/(.*)_R1\.fq\.gz/;
        my $sam=$name.".sam";
        my $R1=$Apoly;
        my $R2="$name"."_R2.fq.gz";
        if (-e $R1) {
        # -x: the directory of your genome index, note replace this directory by your own
                my $cmd1="hisat2 -p 20 --dta -q -x ../Cleaner_wrasse ";
        # --known-splicesite-infile: also replace this directory by your own
        #       $cmd1.="--known-splicesite-infile ~/A.poly.genome/A.poly.splice-sites.txt ";
        # -S: the directory of your output file
                $cmd1.="-1 $R1 -2 $R2 -S RNA-align/$sam ";
        # save the alignment information
                $cmd1.="--summary RNA-align/$name".".txt";
                system($cmd1);
        }
        # transform sam to bam
        my $bam="$name".".bam";
        if (-e "RNA-align/$sam") {
                my $cmd2="samtools view -Su -@ 10 RNA-align/$sam -o RNA-align/$bam";
                system($cmd2);
        }
        # sort bam
        if (-e "RNA-align/$bam") {
                my $sort_bam=$name.".sorted.bam";
                my $cmd3="samtools view -bS RNA-align/$sam >RNA-align/$bam"; # get the binary bam file
                my $cmd4="samtools sort RNA-align/$bam -o RNA-align/$sort_bam"; # sorted bam file
                my $cmd5="samtools index RNA-align/$sort_bam";
                my $cmd6="rm RNA-align/$sam RNA-align/$bam";
                system($cmd3);
                system($cmd4);
                system($cmd5);
                system($cmd6);
        }
}

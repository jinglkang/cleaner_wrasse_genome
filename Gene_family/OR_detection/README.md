# Olfactory receptors detection
**THANKS** very very much for the help of Dr. Du Kang (University of Wuerzburg) and Dr. Jiang Haifeng (Northwest A&F University). All the scripts are from Du Kang.    
working dir: ~/Desktop/cleaner_fish/genome/OR_detection;      
move to: /media/HDD/cleaner_fish;       
Non_OR_gene2.fasta: download from [paper](https://link-springer-com.eproxy.lib.hku.hk/protocol/10.1007%2F978-1-62703-377-0_3#Sec00036)      
MBE_OR_class.fasta && OR_query_MBE.fasta: download from [MBE](https://academic.oup.com/mbe/article/38/10/4238/6277737#304113028)       
Zebrafish_OR_class.fasta: download according to [Evolutionary dynamics of olfactory receptor genes in fishes and tetrapods](https://www.pnas.org/content/102/17/6039/tab-figures-data)     
## obtain query receptors
search "**olfactory**" in gene name of species     
```bash
less Stickleback_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Stickleback_".$F[0];print $ge'>query_gene.txt
less Fugu_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Fugu_".$F[0];print $ge'>>query_gene.txt
less Medaka_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Medaka_".$F[0];print $ge'>>query_gene.txt
less Platyfish_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Platyfish_".$F[0];print $ge'>>query_gene.txt
less Spottedgar_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Spottedgar_".$F[0];print $ge'>>query_gene.txt
less Zebrafish_gene.txt.gz|grep -Ei 'olfactory'|perl -alne '$ge="Zebrafish_".$F[0];print $ge'>>query_gene.txt
```
use the longest pep sequence as the gene sequence:  ../test/makeblastdb_input.fa
```bash
perl temp2.pl >query.fasta
```
257 of 320 sequences as query      

## identify OR in Labroides dimidiatus (bluestreak cleaner wrasse)
### solar output
```bash
Stickleback_ENSGACG00000005797  319     52      319     -       Scx22uW_10      28217623        26878094        26880398        2       196     52,272;271,319; 26880398,26879739;26878240,26878094;    -158;-39;
Stickleback_ENSGACG00000005797  319     1       300     -       Scx22uW_11      31167972        31135941        31136830        2       94      1,135;138,300;  31136830,31136438;31136432,31135941;    -47;-47;
Stickleback_ENSGACG00000010313  796     14      791     +       Scx22uW_17      12817414        11935300        11938409        5       665     14,69;70,166;165,517;515,620;621,791;   11935300,11935467;11935589,11935879;11936020,11937162;11937249,11937698;11937897,11938409;      +49;+83;+303;+86;+149;
Stickleback_ENSGACG00000010313  796     21      789     +       Scx22uW_17      12817414        11930927        11948974        7       424     21,68;74,171;165,417;440,517;516,558;554,620;621,789;   11930927,11931070;11931162,11931458;11931738,11932484;11932624,11932854;11932931,11933059;11933112,11933312;11948468,11948974;  +16;+49;+130;+40;+29;+27;+141;
```
**solar**: **-cCn** intron length (suject point: 26878094, 26878240, 26879739, 26880398; subject length 26880398-26878094+1=2305; pep length 319\*3=957; intron length 26878240-26879739+1=1500; it will not be clustered together if -cCn=1000 even the two blast hit have overlap, otherwise the two blast hit will be clustered)    
```bash
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Cleaner_wrasse_softmasked_ChaHeader.fasta ./
mkdir Ldim
mv Cleaner_wrasse_softmasked_ChaHeader.fasta Ldim/
cp query.fasta Ldim/
cd Ldim/
makeblastdb -in Cleaner_wrasse_softmasked_ChaHeader.fasta -dbtype nucl -parse_seqids -out Cleaner_wrasse
tblastn -outfmt 6 -query query.fasta -out query.fa.bla -db Cleaner_wrasse -evalue 1e-10 -num_threads 30
solar.pl -f m8 -cCn 1000 -d -1 query.fa.bla >query.fa.bla.solar
best_solar_finder.pl query.fa.bla.solar >query.fa.bla.solar.besthit
cat query.fa.bla.solar.besthit|perl -lane '$alength=$F[3]-$F[2]+1;print unless $alength<250' >query.fa.bla.solar.besthit.lt250
cat query.fasta Cleaner_wrasse_softmasked_ChaHeader.fasta >pool.fa
genewise_after_solar.pl pool.fa query.fa.bla.solar.besthit.lt250
best_genewise_finder.pl query.fa.bla.solar.besthit.lt250.wise >query.fa.bla.solar.besthit.lt250.wise.best
wise_parser.pl Cleaner_wrasse_softmasked_ChaHeader.fasta query.fa.bla.solar.besthit.lt250.wise.best
```
## build an NJ tree using FastTree
include the sequences of Non-OR genes and Zebrafish clasiffied OR genes         
```bash
fa2aln 1.fasta -f > 1.align.fasta
FastTree -fastest 2.align.fasta > 2.align.tre
less 2.align.tre|perl -alne 's/β/Bata/g;s/γ/Gama/g;s/δ/Delta/g;s/ε/Epsilon/g;s/ζ/Zeta/g;s/η/Eta/g;s/θ/Theta/g;s/κ/Kappa/g;print' >2.align.tre2
```
## ORdetect1
```bash
ORdetect --genome /media/HDD/cleaner_fish/genome/OR_detection/Ldim/Cleaner_wrasse_softmasked_ChaHeader.fasta \
--species Cleaner_wrasse \
--query /media/HDD/cleaner_fish/genome/OR_detection/query.fasta \
--nonOR /media/HDD/cleaner_fish/genome/OR_detection/Non_OR_gene2.fasta  \
--class /media/HDD/cleaner_fish/genome/OR_detection/Zebrafish_OR_class2.fasta  \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
## NO SPACE
```bash
journalctl --vacuum-size=100M
journalctl --vacuum-time=10d
```
And delete the core-dump in /var/lib/apport/coredump  
## ORdetect2 (which will be used in the following OR genes detection)      
```bash
ORdetect --genome /media/HDD/cleaner_fish/genome/OR_detection/Gasterosteus_aculeatus.BROADS1.dna_sm.toplevel.fa \
--species Stickleback \
--query /media/HDD/cleaner_fish/genome/OR_detection/OR_query_MBE.fasta \
--nonOR /media/HDD/cleaner_fish/genome/OR_detection/Non_OR_gene2.fasta \
--class /media/HDD/cleaner_fish/genome/OR_detection/MBE_OR_class.fasta \
--uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```
## add strand inforation (+|-)   
dir: /media/HDD/cleaner_fish/genome/OR_detection    
vi temp4.pl     
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

# /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse/genewise/query.fa.bla.solar.besthit.lt250.wise.best.1.gff
# /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse/group/filter.out.fasta.bla.best.1

my $cmd="ls -l -d \*/\|perl -alne \'\$F[-1]=~s\/\\/\/\/g;print \$F[-1]\' >1.txt";
system($cmd);
my $dir1="/media/HDD/cleaner_fish/genome/OR_detection/";
open DIR, "1.txt" or die "can not open 1.txt\n";
while (<DIR>) {
	chomp;
	my %hash;
	my $spe=$_;
	my $gff=$dir1."$spe/genewise/query.fa.bla.solar.besthit.lt250.wise.best.1.gff";
	my $filter=$dir1."$spe/group/filter.out.fasta.bla.best.1";
	
	open GFF, "$gff" or die "can not open $gff";
	while (<GFF>) {
		chomp;
		my @a=split;
		if (/match/) {
			my $name=$a[0].":".$a[3].":".$a[4];
			$hash{$name}=$a[6];
		}
	}

	my $NEW=$dir1."$spe/group/filter.out.fasta.bla.best.1.strand";
	open NEW, ">$NEW" or die "can not create $NEW\n";
	open FILTER, "$filter" or die "can not open $filter\n";
	while (<FILTER>) {
		chomp;
		my @a=split;
		my @b=split /\-/, $a[0];
		my $name=$b[0];
		my $phase=$b[1];
		my $info;
		for (my $i = 1; $i < @a; $i++) {
			$info.=$a[$i]."\t";
		}
		$info=~s/\s+$//;
		if ($hash{$name}) {
			my $strand=$hash{$name};
			my $new_name=$name.":".$strand.":".$phase;
			print NEW "$new_name\t$info\n";
		}
	}
}

system("rm 1.txt");
```
```bash
perl temp4.pl
```
***
## Add the OR and vision opsin genes info into genome gtf file
### OR genes
```bash
# Kang@fishlab3 Mon Jan 10 11:18:50 /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse/group
scp filter.out.fasta.bla.best.1.strand kang1234@147.8.76.155:~/genome/Gene_annotation/combined/putative_OR_strand.txt
scp filter.out.1.info kang1234@147.8.76.155:~/genome/Gene_annotation/combined/putative_OR.info

# Kang@fishlab3 Mon Jan 10 11:37:57 /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse/genewise
scp query.fa.bla.solar.besthit.lt250.wise.best.1.gff kang1234@147.8.76.155:~/genome/Gene_annotation/combined/putative_OR.gff
```
#### Add the OR gene info if it's not in the gtf
check which OR gene is in the gtf and which is detected by genewise   
```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Jan 10 13:49:51 ~/genome/Gene_annotation/combined
perl check_OR_in_gtf.pl
# In_gtf	C	6
# No_gtf	C	41

# In_gtf	C	16
# No_gtf	C	31
```
OR gene info in gtf or not: OR_in_gtf.txt   
41 complete OR genes are not in the gtf   
#### Add the complete OR not in gtf into a gtf, can add the content of this file into the genome gtf
```bash
# (base) kang1234@celia-PowerEdge-T640 Tue Jan 11 11:56:27 ~/genome/Gene_annotation/combined
perl add_OR_gtf.pl >OR.gtf
```
## Some predicted genes by genewise might have same start position with the genes in original gtf file
```bash
# (base) kang1234@celia-PowerEdge-T640 Thu Jan 13 01:43:15 ~/genome/Gene_annotation/combined
perl check_OR_in_gtf_2.pl
# In_gtf	C	21
# No_gtf	C	26

# (base) kang1234@celia-PowerEdge-T640 Thu Jan 13 01:47:22 ~/genome/Gene_annotation/combined
perl create_OR_gtf.pl >OR_genewise.gtf
```
***
## class once again (using the query.fa.bla.solar.besthit.lt250.wise.best.1.aa, combine with the class fasta file, and then contruct phylogenetic tree, then check manual)
```bash
# Extract the OR sequences of Zebrafish and the OR (Alpha, thet) sequences of L.oculatus for the class
# Kang@fishlab3 Sun Apr 24 20:02:25 /media/HDD/cleaner_fish/genome/OR_detection
perl extract_OR_class.pl >OR_class_zebrafish_L.oculatus.fasta
perl gene_tree.pl
```

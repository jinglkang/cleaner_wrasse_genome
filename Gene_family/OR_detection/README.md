# Olfactory receptors detection
working dir: ~/Desktop/cleaner_fish/genome/OR_detection;      
move to: /media/HDD/cleaner_fish;       
Non_OR_gene.fasta: download sequences according to [paper](https://link-springer-com.eproxy.lib.hku.hk/protocol/10.1007%2F978-1-62703-377-0_3#Sec00036)      
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

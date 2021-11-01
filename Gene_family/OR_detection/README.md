# Olfactory receptors detection
working dir: ~/Desktop/cleaner_fish/genome/OR_detection      
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
320 sequences as query      
## identify OR in Labroides dimidiatus (bluestreak cleaner wrasse)
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
wise2cds.pl Cleaner_wrasse_softmasked_ChaHeader.fasta query.fa.bla.solar.besthit.lt250.wise.best >query.fa.bla.solar.besthit.lt250.wise.best.cds
```

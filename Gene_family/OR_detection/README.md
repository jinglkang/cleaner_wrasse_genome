Olfactory receptors detection
--------------------------------------
working dir: ~/Desktop/cleaner_fish/genome/OR_detection      
# obtain query receptors
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

Gene Families
------------------------------
## dowload data from Ensembl: [Biomart](http://www.ensembl.org/biomart/martview/d5204916c47e24f97df5659227a20b42)
Japanese Medaka, Oryzias latipes; Fugu, Takifugu rubripes; Stickleback, Gasterosteus aculeatus; Zebrafish, Danio rerio; Platyfish, Xiphophorus maculatus; Spotted gar, Lepisosteus oculatus
1. click Ensembl Genes 104 -> Zebrafish genes (GRCz11);    
2. click Attributes -> Sequences: Peptide -> Header information: Gene ID + CDS length (uncheck Transcript ID);    
3. click Result -> Compressed file (.gz);    

## extract the longest pep
working dir: ~/Desktop/cleaner_fish/genome/test     
```bash
perl Ensemble_longest_pep.pl --fasta *.fasta
```
**result**: Longest\*\_pep.fasta    
put pep sequences of all species into one file    
```bash
cat Longest* > makeblastdb_input.fa
```

### For Platyfish which didn't download from Biomart
working dir: ~/Desktop/cleaner_fish/genome  
download pep sequences file of Platyfish from Ensembl (Platyfish.pep.all.fasta)     
```bash
perl prep_Ensembl_pep.pl --fasta Platyfish.pep.all.fasta
```
***
## For species with gff and genome fasta file that were downloaded from ncbi
working dir: ~/Desktop/cleaner_fish/genome  
species: *cheilinus undulatus* (Cund), *Labrus bergylta* (Lber), *Notolabrus celidotus* (Ncel);   
```bash
~/software/gffread/gffread -y cheilinus_undulatus.pep.all.fasta -g cheilinus_undulatus.fasta cheilinus_undulatus.gff
less cheilinus_undulatus.gff|grep -v '#'|perl -alne 'print if $F[2] eq "mRNA"'|perl -alne 'my ($tra)=$_=~/ID=(.*?);/;my ($gene)=$_=~/Parent=(.*?);/;$gene=~s/gene/Cund/;print "$tra\t$gene"' > cheilinus_undulatus.tran.gene
perl transform.pl --fasta cheilinus_undulatus.pep.all.fasta --table cheilinus_undulatus.tran.gene >cheilinus_undulatus.pep.all.2.fasta
perl prep_ncbi_pep.pl --fasta cheilinus_undulatus.pep.all.2.fasta
```
***
## all-by-all by blast
```bash
makeblastdb -in makeblastdb_input.fa -dbtype prot -out blastdb
nohup blastp -num_threads 30 -db blastdb -query makeblastdb_input.fa -outfmt 7 -seg yes > blast_output.txt 2>&1 &
```

## Clustering sequences with mcl
```bash
grep -v "#" blast_output.txt | grep -v "nohup"| cut -f 1,2,11 > blast_output.abc
mcxload -abc blast_output.abc --stream-mirror --stream-neg-log10 -stream-tf 'ceil(200)' -o blast_output.mci -write-tab blast_output.tab
mcl blast_output.mci -I 3
mcxdump -icl out.blast_output.mci.I30 -tabr blast_output.tab -o dump.blast_output.mci.I30
python mcl2rawcafe.py -i dump.blast_output.mci.I30 -o unfiltered_cafe_input.txt -sp "ENSTRUG ENSORLG ENSLOCG ENSGACG ENSDARG"
python clade_and_size_filter.py -i unfiltered_cafe_input.txt -o filtered_cafe_input.txt -s
```

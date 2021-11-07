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
***
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
## For species genes predicted by BRAKER
### *Thalassoma bifasciatum*
**SNORLAX** working dir: ~/genome/Gene_annotation/Thalassoma_bifasciatum   
rename the output gtf (braker.gtf), and extract the pep sequences        
```bash
rename_gtf.py --gtf braker.gtf --prefix Tbif --out braker_renamed.gtf
~/software/gffread/gffread -y Thalassoma_bifasciatum.pep.all.fasta -g ../Thalassoma_bifasciatum_ChaHeader.fasta braker_renamed.gtf
```
```bash
perl temp1.pl Thalassoma_bifasciatum.pep.all.fasta>Thalassoma_bifasciatum_pep.fasta
```
```perl
#!/usr/bin/perl
use strict;
use warnings;

my %hash; my $tran; my @trans;
open FIL, "$ARGV[0]";
while (<FIL>) {
	chomp;
	if (/>/) {
		s/>//;
		$tran=$_;
		push @trans, $tran;
	} else {
		$hash{$tran}.=$_;
	}
}

foreach my $tran (@trans) {
	(my $na)=$tran=~/(.*)\./;
	my $seq=$hash{$tran};
	my $len=length($seq);
	print ">$na|$len\n$seq\n";
}
```
***
### *Symphodus melops*
**SNORLAX** working dir: ~/genome/Gene_annotation/Symphodus_melops    
rename the output gtf (braker.gtf), and extract the pep sequences        
```bash
rename_gtf.py --gtf braker.gtf --prefix Smel --out braker_renamed.gtf
~/software/gffread/gffread -y Symphodus_melops.pep.all.fasta -g ../Symphodus_melops_softmasked.fasta braker_renamed.gtf
cp ../Thalassoma_bifasciatum/temp1.pl ./
perl temp1.pl Symphodus_melops.pep.all.fasta>Symphodus_melops_pep.fasta
```
***
### *Labroides dimidiatus*
**SNORLAX** working dir: ~/genome/Gene_annotation/combined       
```bash
~/software/gffread/gffread -y Cleaner_wrasse.pep.all.fasta -g ../Cleaner_wrasse_softmasked_ChaHeader.fasta braker2+3_combined_renamed.gtf
cp ../Thalassoma_bifasciatum/temp1.pl temp4.pl
perl temp4.pl Cleaner_wrasse.pep.all.fasta>Labroides_dimidiatus_pep.fasta
``` 
***
copy Labroides_dimidiatus_pep.fasta Thalassoma_bifasciatum_pep.fasta Symphodus_melops_pep.fasta to my own workstation (/media/HDD/cleaner_fish/genome);       
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
***
## CAFE for gene family: start
working dir: my own work station (/media/HDD/cleaner_fish/genome/gene_family)       
```
mv test/ gene_family/    
mv ../*_pep.fasta ./
perl Ensemble_longest_pep.pl --fasta *.fasta
cat Longest* > makeblastdb_input.fa
makeblastdb -in makeblastdb_input.fa -dbtype prot -out blastdb
nohup blastp -num_threads 30 -db blastdb -query makeblastdb_input.fa -outfmt 7 -seg yes > blast_output.txt 2>&1 &
```
## CAFE for gene family: start
working dir: my own work station (/media/HDD/cleaner_fish/genome/gene_family)       
```
mv test/ gene_family/    
mv ../*_pep.fasta ./
perl Ensemble_longest_pep.pl --fasta *.fasta
cat Longest* > makeblastdb_input.fa
makeblastdb -in makeblastdb_input.fa -dbtype prot -out blastdb
nohup blastp -num_threads 30 -db blastdb -query makeblastdb_input.fa -outfmt 7 -seg yes > blast_output.txt 2>&1 &
```
### use diamond to do the blastp
```perl
#!/usr/bin/perl
use strict;
use warnings;

my $gene; my @genes; my %hash;
open FIL1, "makeblastdb_input.fa";
while (<FIL1>) {
        chomp;
        if (/>/) {
                s/>//;
                $gene=$_;
                push @genes, $gene;
        } else {
                $hash{$gene}.=$_;
        }
}

open FIL2, ">1.txt";
foreach my $gene (@genes) {
        my $new_gene;
        if ($gene=~/ENSTRUG/) {
                $new_gene="Fugu_".$gene;
        } elsif ($gene=~/ENSORLG/) {
                $new_gene="Medaka_".$gene;
        } elsif ($gene=~/ENSXMAG/) {
                $new_gene="Platyfish_".$gene;
        } elsif ($gene=~/ENSLOCG/) {
                $new_gene="Spottedgar_".$gene;
        } elsif ($gene=~/ENSGACG/) {
                $new_gene="Stickleback_".$gene;
        } elsif ($gene=~/ENSDARG/) {
                $new_gene="Zebrafish_".$gene;
        } else {
                $new_gene=$gene;
        }
        my $seq=$hash{$gene};   
        if ($seq=~/\./) {
                print FIL2 ">$new_gene\n$seq\n";
        } else {
                print ">$new_gene\n$seq\n";
        }
}
close FIL2;

```
remove the sequences if the sequences include '.' (these seuqneces will be saved in 1.txt)      
```bash
perl temp1.pl >makeblastdb_input.2.fa
diamond makedb --in makeblastdb_input.2.fa -d blastdb
diamond blastp -q makeblastdb_input.2.fa -e 1e-5 --sensitive -d ./blastdb --out blast_output.txt
cut -f 1,2,11 blast_output.txt > blast_output.abc
mcxload -abc blast_output.abc --stream-mirror --stream-neg-log10 -stream-tf 'ceil(200)' -o blast_output.mci -write-tab blast_output.tab
mcl blast_output.mci -I 3
mcxdump -icl out.blast_output.mci.I30 -tabr blast_output.tab -o dump.blast_output.mci.I30
python mcl2rawcafe.py -i dump.blast_output.mci.I30 -o unfiltered_cafe_input.txt -sp "Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish Cund Lber Ncel Smel Tbif Ldim"
python clade_and_size_filter.py -i unfiltered_cafe_input.txt -o filtered_cafe_input.txt -s
```
### Estimating a species tree on the basis of one-to-one orthologues
extract single copy orthologues and align them (the result will be in: /media/HDD/cleaner_fish/genome/gene_family/single_copy)      
```bash
less filtered_cafe_input.txt|perl -alne 'my @a;for($i=2;$i<@F;$i++){push @a, $F[$i] if $F[$i]==1};print if @a==12'|wc -l
perl extract_single_copy.pl
```
1465 single copy orthlogues, trimAl trim the regions with bad quality in the sequences.             
```perl
#!/usr/bin/perl
use strict;
use warnings;

my (%seq, %hash);
my $spe; my @spes;
my @fasta=<single_copy/*.fasta>;
foreach my $fasta (@fasta) {
	my $new=$fasta."trimal";
	system("trimal -in $fasta -out $new -gt 0.8 -st 0.001 -cons 60");
	open FIL, "$new" or die "can not open $new\n";
	while (<FIL>) {
		chomp;
		if (/>(.*?)(_|-)/) {
			$spe=$1;
			$hash{$spe}++;
			push @spes, $spe if $hash{$spe}==1;
		} else {
			$seq{$spe}.=$_;
		}
	}
	system("rm $new");
}

foreach my $spe (@spes) {
	print ">$spe\n$seq{$spe}\n";
}
```
```bash
perl temp2.pl >single_copy.concatenated.fasta
fasta2phy.pl single_copy.concatenated.fasta >single_copy.concatenated.phy
```
the phylogenetic tree will be constructed on the basis of single_copy.concatenated.phy     
use the PROTGAMMAAUTO parameter to select the optimal amino acid substitution model, specify spotted gar as the outgroup, and evaluate the robustness of the result using 1000 bootstraps.        
```bash
raxmlHPC -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 1000 -s single_copy.concatenated.phy -o Spottedgar -n single_copy.concatenated
```

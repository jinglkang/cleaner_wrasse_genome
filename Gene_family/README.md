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
### *Cheilinus undulatus*
**SNORLAX** working dir: ~/genome/Gene_annotation/Cheilinus_undulatus      
```bash
perl ../combined/temp4.pl Cheilinus_undulatus.pep.all.fasta >Cheilinus_undulatus_pep.fasta
# copy to my own work station
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Cheilinus_undulatus/Cheilinus_undulatus_pep.fasta ./
```
***
### *Labrus bergylta*
**SNORLAX** working dir: ~/genome/Gene_annotation/Labrus_bergylta       
```bash
perl ../combined/temp4.pl Labrus_bergylta.pep.all.fasta >Labrus_bergylta_pep.fasta
# copy to my own work station
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Labrus_bergylta/Labrus_bergylta_pep.fasta ./
```
***
### *Notolabrus celidotus*
**SNORLAX** working dir: ~/genome/Gene_annotation/Notolabrus_celidotus       
```bash
perl ../combined/temp4.pl Notolabrus_celidotus.pep.all.fasta >Notolabrus_celidotus_pep.fasta
 # copy to my own work station
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Notolabrus_celidotus/Notolabrus_celidotus_pep.fasta ./
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
### Install r8s
```bash
sed -i 's/continuousML.o //' Makefile.linux
sed -i 's/continuousML.o:/#continuousML.o:/' Makefile.linux
# then delete "memory.o: /usr/include/errno.h /usr/include/sys/errno.h" in Makefile.linux to "memory.o: /usr/include/errno.h"
make -f Makefile.linux
```
set the calibration point: *D. rerio* - *G. aculeatus* (149.85-165.2 Mya), get the mid point as the calibration point (156.53).     
```bash
python cafetutorial_prep_r8s.py -i RAxML_bestTree.single_copy.concatenated -o r8s_ctl_file.txt -s 638853 -p 'Zebrafish,Stickleback' -c '156.53'
r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt
tail -n 1 r8s_tmp.txt | cut -c 16- > r8s_ultrametric.txt
```
### Remove gene families without homology in the SWISS-PROT database and the families that contained sequences that have multiple functional annotations
```bash
perl extract_swiss_homology.pl --anno Ldim.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Ldim >dump.blast_output.mci.I30.Ldim.swis
perl extract_swiss_homology.pl --anno Smel.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Smel >dump.blast_output.mci.I30.Smel.swis
perl extract_swiss_homology.pl --anno Tbif.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Tbif >dump.blast_output.mci.I30.Tbif.swis
```
```perl
#! /usr/bin/perl
use strict;
use warnings;

my @id;
open FIL1, "dump.blast_output.mci.I30.Ldim.swis";
while (<FIL1>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL2, "dump.blast_output.mci.I30.Smel.swis";
while (<FIL2>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL3, "dump.blast_output.mci.I30.Tbif.swis";
while (<FIL3>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

my %hash;
foreach my $id (@id) {
	$hash{$id}++;
}

open FIL4, "filtered_cafe_input.txt";
while (<FIL4>) {
	chomp;
	my @a=split;
	if (/^Desc/) {
		print "$_\n";
	} else {
		print "$_\n" if $hash{$a[1]} && $hash{$a[1]}==3;
	}
}
```
```bash
perl temp3.pl >filtered_cafe_input.final.txt
```
**filtered_cafe_input.final.txt** will be the final input of CAFE     
### Estimating the birth-death parameter λ
#### Estimating a single λ for the whole tree
**run1.sh**        
```cafe
#! cafe
load -i filtered_cafe_input.final.txt -t 20 -l reports/log_run1.txt -p 0.01 -r 10000
tree ((((Platyfish:71.101088,Medaka:71.101088):12.018970,((((Lber:19.393079,Smel:19.393079):18.702044,Cund:38.095123):5.832633,((Ldim:17.725724,Tbif:17.725724):13.416364,Ncel:31.142089):12.785667):31.400507,(Fugu:71.980591,Stickleback:71.980591):3.347671):7.791796):73.409942,Zebrafish:156.530000)ishack:96.028791,Spottedgar:252.558791)
lambda -s -t ((((1,1)1,((((1,1)1,1)1,((1,1)1,1)1)1,(1,1)1)1)1,1)1,1)
report reports/report_run1
```
working dir: **SNORLAX** (~/genome/gene_family)     
```bash
chmod +x run1.sh
mkdir reports
cafe run1.sh
```
##### Summarizing the output
also put cafecore.pyc in the working directory       
```bash
python2 report_analysis.py -i reports/report_run1.cafe -o reports/summary_run1
```
##### Plot the result: Rapid, Expansions, Contractions
```bash
python2 draw_tree.py -i reports/summary_run1_node.txt -t '((((Platyfish:71.1011,Medaka:71.1011):12.019,((((Lber:19.3931,Smel:19.3931):18.702,Cund:38.0951):5.83263,((Ldim:17.7257,Tbif:17.7257):13.4164,Ncel:31.1421):12.7857):31.4005,(Fugu:71.9806,Stickleback:71.9806):3.34767):7.7918):73.4099,Zebrafish:156.53):96.0288,Spottedgar:252.559)' -d '((((Platyfish<0>,Medaka<2>)<1>,((((Lber<4>,Smel<6>)<5>,Cund<8>)<7>,((Ldim<10>,Tbif<12>)<11>,Ncel<14>)<13>)<9>,(Fugu<16>,Stickleback<18>)<17>)<15>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run1_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports/summary_run1_node.txt -t '((((Platyfish:71.1011,Medaka:71.1011):12.019,((((Lber:19.3931,Smel:19.3931):18.702,Cund:38.0951):5.83263,((Ldim:17.7257,Tbif:17.7257):13.4164,Ncel:31.1421):12.7857):31.4005,(Fugu:71.9806,Stickleback:71.9806):3.34767):7.7918):73.4099,Zebrafish:156.53):96.0288,Spottedgar:252.559)' -d '((((Platyfish<0>,Medaka<2>)<1>,((((Lber<4>,Smel<6>)<5>,Cund<8>)<7>,((Ldim<10>,Tbif<12>)<11>,Ncel<14>)<13>)<9>,(Fugu<16>,Stickleback<18>)<17>)<15>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run1_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports/summary_run1_node.txt -t '((((Platyfish:71.1011,Medaka:71.1011):12.019,((((Lber:19.3931,Smel:19.3931):18.702,Cund:38.0951):5.83263,((Ldim:17.7257,Tbif:17.7257):13.4164,Ncel:31.1421):12.7857):31.4005,(Fugu:71.9806,Stickleback:71.9806):3.34767):7.7918):73.4099,Zebrafish:156.53):96.0288,Spottedgar:252.559)' -d '((((Platyfish<0>,Medaka<2>)<1>,((((Lber<4>,Smel<6>)<5>,Cund<8>)<7>,((Ldim<10>,Tbif<12>)<11>,Ncel<14>)<13>)<9>,(Fugu<16>,Stickleback<18>)<17>)<15>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run1_tree_Contractions.png -y Contractions
```
### Setting λ to a previously estimated value to deal with families with large numbers of gene copies
**run2.sh**     
```cafe
#! cafe
load -i filtered_cafe_input.final.txt -t 20 -l reports/log_run2.txt
tree ((((Platyfish:71.101088,Medaka:71.101088):12.018970,((((Lber:19.393079,Smel:19.393079):18.702044,Cund:38.095123):5.832633,((Ldim:17.725724,Tbif:17.725724):13.416364,Ncel:31.142089):12.785667):31.400507,(Fugu:71.980591,Stickleback:71.980591):3.347671):7.791796):73.409942,Zebrafish:156.530000):96.028791,Spottedgar:252.558791)
lambda -l 0.00230072 -t ((((1,1)1,((((1,1)1,1)1,((1,1)1,1)1)1,(1,1)1)1)1,1)1,1)
report reports/report_run2
```
```bash
cafe run2.sh
```
***
## Start again in a new dir (use the annotation file by ourselves)
working dir: /media/HDD/cleaner_fish/genome/gene_family_2   
```bash
cp ../gene_family/*_pep.fasta ./
perl Ensemble_longest_pep.pl --fasta *.fasta
cat Longest* > makeblastdb_input.fa
perl temp1.pl >makeblastdb_input.2.fa
diamond makedb --in makeblastdb_input.2.fa -d blastdb
diamond blastp -q makeblastdb_input.2.fa -e 1e-5 --sensitive -d ./blastdb --out blast_output.txt
cut -f 1,2,11 blast_output.txt > blast_output.abc
mcxload -abc blast_output.abc --stream-mirror --stream-neg-log10 -stream-tf 'ceil(200)' -o blast_output.mci -write-tab blast_output.tab
mcl blast_output.mci -I 3
mcxdump -icl out.blast_output.mci.I30 -tabr blast_output.tab -o dump.blast_output.mci.I30
cp ../gene_family/mcl2rawcafe.py ./
python mcl2rawcafe.py -i dump.blast_output.mci.I30 -o unfiltered_cafe_input.txt -sp "Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish Cund Lber Ncel Smel Tbif Ldim"
less ../gene_family/filtered_cafe_input.txt|wc -l
python clade_and_size_filter.py -i unfiltered_cafe_input.txt -o filtered_cafe_input.txt -s
```
***
### Remove gene families without homology in the SWISS-PROT database and the families that contained sequences that have multiple functional annotations
```bash
# copy the annotation file of Ldim, Smel, Tbif, Cund, Lber, Ncel
cp ../gene_family/*anno.final.txt ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Cheilinus_undulatus/Cheilinus_undulatus.pep.all.1.conca.long.fasta.ano.final Cund.anno.final.txt
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Labrus_bergylta/Labrus_bergylta.pep.all.1.conca.long.fasta.ano.final Lber.anno.final.txt
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Notolabrus_celidotus/Notolabrus_celidotus.pep.all.1.conca.long.fasta.ano.final Ncel.anno.final.txt
cp ../gene_family/extract_swiss_homology.pl ./
perl extract_swiss_homology.pl --anno Ldim.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Ldim >dump.blast_output.mci.I30.Ldim.swis
perl extract_swiss_homology.pl --anno Smel.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Smel >dump.blast_output.mci.I30.Smel.swis
perl extract_swiss_homology.pl --anno Tbif.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Tbif >dump.blast_output.mci.I30.Tbif.swis
perl extract_swiss_homology.pl --anno Cund.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Cund >dump.blast_output.mci.I30.Cund.swis
perl extract_swiss_homology.pl --anno Lber.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Lber >dump.blast_output.mci.I30.Lber.swis
perl extract_swiss_homology.pl --anno Ncel.anno.final.txt --gene_family dump.blast_output.mci.I30 --key_word Ncel >dump.blast_output.mci.I30.Ncel.swis
```
```perl
#! /usr/bin/perl
use strict;
use warnings;

my @id;
open FIL1, "dump.blast_output.mci.I30.Ldim.swis";
while (<FIL1>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL2, "dump.blast_output.mci.I30.Smel.swis";
while (<FIL2>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL3, "dump.blast_output.mci.I30.Tbif.swis";
while (<FIL3>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL4, "dump.blast_output.mci.I30.Cund.swis";
while (<FIL4>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL5, "dump.blast_output.mci.I30.Lber.swis";
while (<FIL5>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

open FIL6, "dump.blast_output.mci.I30.Ncel.swis";
while (<FIL6>) {
	chomp;
	my @a=split;
	push @id, $a[0];
}

my %hash;
foreach my $id (@id) {
	$hash{$id}++;
}

open FIL7, "filtered_cafe_input.txt";
while (<FIL7>) {
	chomp;
	my @a=split;
	if (/^Desc/) {
		print "$_\n";
	} else {
		print "$_\n" if $hash{$a[1]} && $hash{$a[1]}==6;
	}
}
```
```bash
perl temp2.pl >filtered_cafe_input.final.txt
```
after the removal of genes in the same family but with different annotations, filtered_cafe_input.txt (20077 genes) --> filtered_cafe_input.final.txt (12965 genes)    
***
### Estimating a species tree on the basis of one-to-one orthologues
```bash
mkdir single_copy
# 1180 single copy genes
less filtered_cafe_input.final.txt|perl -alne 'my @a;for($i=2;$i<@F;$i++){push @a, $F[$i] if $F[$i]==1};print if @a==12'|wc -l
# notice to change the input files, the resulted fasta files of single copy genes will be in the directory "single_copy/"
perl extract_single_copy.pl
# 1180 single copy orthlogues, trimAl trim the regions with bad quality in the sequences.
cp ../gene_family/temp2.pl temp3.pl
perl temp3.pl >single_copy.concatenated.fasta
fasta2phy.pl single_copy.concatenated.fasta >single_copy.concatenated.phy
# construct a phylogenetic tree, running in SNORLAX: ~/genome/gene_family
scp single_copy.concatenated.phy kang1234@147.8.76.155:~/genome/gene_family
nohup raxmlHPC -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 1000 -s single_copy.concatenated.phy -o Spottedgar -n single_copy.concatenated > raxml.process 2>&1 &
```
### r8s to obtain the ultrametric tree
RAxML_bestTree.single_copy.concatenated as the input file   
set the calibration point: D. rerio - G. aculeatus (149.85-165.2 Mya), get the mid point as the calibration point (156.53)    
working dir (my workstation): /media/HDD/cleaner_fish/genome/gene_family_2    
```bash
cp ../gene_family/cafetutorial_prep_r8s.py ./
python cafetutorial_prep_r8s.py -i RAxML_bestTree.single_copy.concatenated -o r8s_ctl_file.txt -s 638853 -p 'Zebrafish,Stickleback' -c '156.53'
r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt
tail -n 1 r8s_tmp.txt | cut -c 16- > r8s_ultrametric.txt
```
### Estimating the birth-death parameter λ
remove "ishack" in r8s_ultrametric.txt;   
filtered_cafe_input.final.txt will be the final input of CAFE;   
cp the two files to SNORLAX and run CAFE
```bash
scp r8s_ultrametric.txt kang1234@147.8.76.155:~/genome/gene_family
scp filtered_cafe_input.final.txt kang1234@147.8.76.155:~/genome/gene_family
```
### Estimating a single λ for the whole tree
**run1.sh**   
```CAFE
#! cafe
load -i filtered_cafe_input.final.txt -t 20 -l reports/log_run1.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -s -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run1
```
save into run1.sh   
```bash
cafe run1.sh
python2 report_analysis.py -i reports/report_run1.cafe -o reports/summary_run1
```
Lambda: 0.00256848   
### Setting λ to a previously estimated value to deal with families with large numbers of gene copies
**run2.sh**
```CAFE
#! cafe
load -i filtered_cafe_input.final.txt -t 20 -l reports/log_run2.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -l 0.00256848 -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run2
```
save into run2.sh   
```bash
python2 report_analysis.py -i reports/report_run2.cafe -o reports/summary_run2
```
**plot**   
-i && -t can be found in "report_run2.cafe" (Tree: && # IDs of nodes)
```bash
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Contractions.png -y Contractions
```
### extracted the expanded and contracted gene family in Ldim
```bash
less summary_run2_anc.txt|perl -alne 'next if /^Family/;$num=$F[14]-$F[10];print "$F[0]" if $num>0' >Ldim_gene_expansion_family_id.txt
perl Extract_gene_family_info.pl Ldim.anno.final.txt dump.blast_output.mci.I30 Ldim Ldim_gene_expansion_family_id.txt >Ldim_gene_expansion_family.txt
less summary_run2_anc.txt|perl -alne 'next if /^Family/;$num=$F[14]-$F[10];print "$F[0]" if $num<0' >Ldim_gene_contraction_family_id.txt
perl Extract_gene_family_info.pl Ldim.anno.final.txt dump.blast_output.mci.I30 Ldim Ldim_gene_contraction_family_id.txt >Ldim_gene_contraction_family.txt
```
#### extracted the gene copy number that keep increasing from Oligate to Facultative clean fish
working dir (my workstation): /media/HDD/cleaner_fish/genome/gene_family_2
```bash
perl Extract_gene_family_increase.pl Lber.anno.final.txt dump.blast_output.mci.I30 Lber|less
```
#### extracted the gene copy number that is maximum in one species (its copy gene number is more than at least 5)
```bash
perl Extract_gene_family_max.pl Lber.anno.final.txt dump.blast_output.mci.I30 Lber|less
```
#### select the gene family that the min number in cleaner fish species is more than the max number in non-cleaner fish species
```bash
perl cleaner_more_than_noncleaner.pl Smel.anno.final.txt dump.blast_output.mci.I30 Smel
```
some gene family in different species with different annotations (need solve this problerm)    
***
### Ensure the gene family with the same annation in all the six fish species
and make sure that Zebrafish has this gene family    
```bash
perl anno_consistent.pl >filtered_cafe_input.final.consistent.txt
```
11728 gene family   
***
### CAFE in SNORLAX
```bash
# Kang@fishlab3 Tue Dec 28 11:46:16 /media/HDD/cleaner_fish/genome/gene_family_2
scp filtered_cafe_input.final.consistent.txt kang1234@147.8.76.155:~/genome/gene_family
```
#### Estimating a single λ for the whole tree
SNORLAX: ~/genome/gene_family   
run1.sh   
```bash
#! cafe
load -i filtered_cafe_input.final.consistent.txt -t 20 -l reports/log_run1.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -s -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run1
```

```bash
cafe run1.sh
python2 report_analysis.py -i reports/report_run1.cafe -o reports/summary_run1
```
Lambda: 0.00216440

#### Setting λ to a previously estimated value to deal with families with large numbers of gene copies
run2.sh   
```bash
#! cafe
load -i filtered_cafe_input.final.consistent.txt -t 20 -l reports/log_run2.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -l 0.00216440 -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run2
```

```bash
cafe run2.sh
python2 report_analysis.py -i reports/report_run2.cafe -o reports/summary_run2
```

#### Plot
```bash
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Contractions.png -y Contractions
```

```bash
# Kang@fishlab3 Tue Dec 28 16:47:23 /media/HDD/cleaner_fish/genome/gene_family_2
mv summary_run2_anc.txt summary_run2_anc_11729.txt
```
***
### Ensure the gene family with the same annation in all the six fish species
and make sure that Zebrafish has this gene family    
```bash
perl anno_consistent.pl >filtered_cafe_input.final.consistent.txt
```
7334 gene family left   
***
### CAFE in SNORLAX
```bash
# Kang@fishlab3 Tue Dec 28 11:46:16 /media/HDD/cleaner_fish/genome/gene_family_2
scp filtered_cafe_input.final.consistent.txt kang1234@147.8.76.155:~/genome/gene_family
```
#### Estimating a single λ for the whole tree
SNORLAX: ~/genome/gene_family   
run1.sh   
```bash
#! cafe
load -i filtered_cafe_input.final.consistent.txt -t 20 -l reports/log_run1.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -s -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run1
```

```bash
cafe run1.sh
python2 report_analysis.py -i reports/report_run1.cafe -o reports/summary_run1
```
Lambda: 0.00129188

#### Setting λ to a previously estimated value to deal with families with large numbers of gene copies
run2.sh   
```bash
#! cafe
load -i filtered_cafe_input.final.consistent.txt -t 20 -l reports/log_run2.txt -p 0.01 -r 10000
tree ((((Platyfish:71.157004,Medaka:71.157004):12.230458,((Fugu:72.568551,Stickleback:72.568551):3.343557,(((Smel:19.853801,Lber:19.853801):19.109431,Cund:38.963232):5.636659,((Tbif:18.004632,Ldim:18.004632):14.124763,Ncel:32.129395):12.470496):31.312217):7.475354):73.142538,Zebrafish:156.530000):96.579514,Spottedgar:253.109514)
lambda -l 0.00129188 -t ((((1,1)1,((1,1)1,(((1,1)1,1)1,((1,1)1,1)1)1)1)1,1)1,1)
report reports/report_run2
```

```bash
cafe run2.sh
python2 report_analysis.py -i reports/report_run2.cafe -o reports/summary_run2
```

#### Plot
```bash
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports/summary_run2_node.txt -t '((((Platyfish:71.157,Medaka:71.157):12.2305,((Fugu:72.5686,Stickleback:72.5686):3.34356,(((Smel:19.8538,Lber:19.8538):19.1094,Cund:38.9632):5.63666,((Tbif:18.0046,Ldim:18.0046):14.1248,Ncel:32.1294):12.4705):31.3122):7.47535):73.1425,Zebrafish:156.53):96.5795,Spottedgar:253.11)' -d '((((Platyfish<0>,Medaka<2>)<1>,((Fugu<4>,Stickleback<6>)<5>,(((Smel<8>,Lber<10>)<9>,Cund<12>)<11>,((Tbif<14>,Ldim<16>)<15>,Ncel<18>)<17>)<13>)<7>)<3>,Zebrafish<20>)<19>,Spottedgar<22>)<21>' -o reports/summary_run2_tree_Contractions.png -y Contractions
```

```bash
# Kang@fishlab3 Tue Dec 28 16:50:27 /media/HDD/cleaner_fish/genome/gene_family_2
scp kang1234@147.8.76.155:~/genome/gene_family/reports/summary_run2_anc.txt ./
# (base) kang1234@celia-PowerEdge-T640 Tue Dec 28 17:15:14 ~/genome/gene_family
mv reports reports_1
```

***
### USE the previous results
**discard this result, it will reduce the results if consider the different annotation info between species and within species. However, this is gene family, we need not consider too much about annotation info because different copy migh be with different name (like or1, or2)**    
need not filter: use **filtered_cafe_input.txt** as the input of CAFE   
remove the gene family with zero gene in Zebrafish    
```bash
# Kang@fishlab3 Tue Dec 28 17:11:46 /media/HDD/cleaner_fish/genome/gene_family_2
less filtered_cafe_input.txt|perl -alne 'if (/^Desc/){print}elsif ($F[-7]>0){print}' >filtered_cafe_input_zebra.txt
scp filtered_cafe_input_zebra.txt kang1234@147.8.76.155:~/genome/gene_family
```
#### RUN CAFE in SNORLAX
change the file name in run1.sh and run2.sh    
```bash
mkdir reports
cafe run1.sh
python2 report_analysis.py -i reports/report_run1.cafe -o reports/summary_run1
# Lambda: 0.00238384
cafe run2.sh
python2 report_analysis.py -i reports/report_run2.cafe -o reports/summary_run2
mv reports reports_2
```
***
remove the results to my workstation   
```bash
# Kang@fishlab3 Tue Dec 28 18:52:16 /media/HDD/cleaner_fish/genome/gene_family_2
scp -r kang1234@147.8.76.155:~/genome/gene_family/reports_1 ./
scp -r kang1234@147.8.76.155:~/genome/gene_family/reports_2 ./
```

#### Extract the sig. expansion and constraction genes in each key branch
```bash
# Kang@fishlab3 Tue Dec 28 23:58:01 /media/HDD/cleaner_fish/genome/gene_family_2/reports_2
less summary_run2_fams.txt|perl -alne 'next if /^#/;next if $F[0]!~/</;@a=split /\,/,$F[1];$nb=@a;my ($ex,$co);foreach my $a(@a){$ex++ if $a=~/\+/;$co++ if $a=~/\-/;}$ex?($ex=$ex):($ex=0);$co?($co=$co):($co=0);print "$F[0]\t$nb\t$ex\t$co"'
perl extract_sig_fm.pl
```
## Bone
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 日  5 01 09:16:33 ~/Documents/2022/Ldim_genome/Enrichment
less contraction_fm_no_filter_enrichment.txt|grep -i 'bone'|perl -alne 'next if ! /^\[OVER\]/;print'|perl -alne '@a=split /\t/;print $a[2]' >bone_go_function.txt
extract_gene_functions -i contraction_fm_no_filter_enrichment.txt -a Gene_annotation.final.txt --gene_column 1 --func_column 3 --functions bone_go_function.txt --output bone_func_genes_Ldim_contract
less bone_func_genes_Ldim_contract.txt|perl -alne '@a=split /\t/;print "$a[2]\t$a[-2]\t$a[-1]"'|sort -u >bone_genes_Ldim_contract.txt
```
***
## Olfactory
```bash
less contraction_fm_no_filter_enrichment.txt|grep -iE 'olfactory|Odorant'|perl -alne 'next if ! /^\[OVER\]/;print'|perl -alne '@a=split /\t/;print $a[2]' >olfactory_go_function.txt
extract_gene_functions -i contraction_fm_no_filter_enrichment.txt -a Gene_annotation.final.txt --gene_column 1 --func_column 3 --functions olfactory_go_function.txt --output olfactory_func_genes_Ldim_contract
less olfactory_func_genes_Ldim_contract.txt|perl -alne '@a=split /\t/;print "$a[2]\t$a[-2]\t$a[-1]"'|sort -u >olfactory_genes_Ldim_contract.txt
```
***
## vision
```bash
less contraction_fm_no_filter_enrichment.txt|grep -iE 'vision'|perl -alne 'next if ! /^\[OVER\]/;print'|perl -alne '@a=split /\t/;print $a[2]' >vision_go_function.txt
extract_gene_functions -i contraction_fm_no_filter_enrichment.txt -a Gene_annotation.final.txt --gene_column 1 --func_column 3 --functions olfactory_go_function.txt --output vision_func_genes_Ldim_contract
less vision_func_genes_Ldim_contract.txt|perl -alne '@a=split /\t/;print "$a[2]\t$a[-2]\t$a[-1]"'|sort -u >vision_genes_Ldim_contract.txt
```

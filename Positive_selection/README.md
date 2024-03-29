# Positive_selection: Orthologous genes detection
## InParanoid: orthologous genes detection (give up this following part)
work in HPC   
```bash
# jlkang@hpc2021-io1 Fri Dec 31 13:44:59 ~
mkdir orthologous_detection; cd orthologous_detection
# transfer the InParanoid program to HPC
# Kang@fishlab3 Fri Dec 31 13:52:34 ~/software/InParanoid4
scp * jlkang@hpc2021-io1:~/orthologous_detection
```

### Prepare the protein sequences (include all protein, not just the longest)
ENSEMBEL: gene_id|protein_id   
the other six species: transcript_id   
```bash
# Labroides_dimidiatus
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 14:52:56 ~/genome/Gene_annotation/combined
scp Cleaner_wrasse.pep.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Labroides_dimidiatus_all_pep.fa

# Symphodus_melops
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 14:57:04 ~/genome/Gene_annotation/Symphodus_melops
scp Symphodus_melops.pep.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Symphodus_melops_all_pep.fa

# Labrus_bergylta
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 14:58:21 ~/genome/Gene_annotation/Labrus_bergylta
scp Labrus_bergylta.pep.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Labrus_bergylta_all_pep.fa

# Thalassoma_bifasciatum
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 14:59:28 ~/genome/Gene_annotation/Thalassoma_bifasciatum
scp Thalassoma_bifasciatum.pep.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Thalassoma_bifasciatum_all_pep.fa

# Cheilinus_undulatus
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 15:00:33 ~/genome/Gene_annotation/Cheilinus_undulatus
scp Cheilinus_undulatus.pep.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Cheilinus_undulatus_all_pep.fa

# Notolabrus_celidotus
# (base) kang1234@celia-PowerEdge-T640 Fri Dec 31 15:01:22 ~/genome/Gene_annotation/Notolabrus_celidotus
scp Notolabrus_celidotus.cds.all.fasta jlkang@hpc2021-io1:~/orthologous_detection/Notolabrus_celidotus_all_pep.fa
```

```bash
ls -1 *.fa > RUN
gawk '{n[ni++]=$1} END {for (i=0;i<ni-1;i++) for (j=i+1;j<ni;j++){print "/home/jlkang/orthologous_detection/inparanoid.pl",
n[i], n[j]}}' RUN | sort -R > RUN.sh
# inparanoid.pl: Set 'run_blast' to 1 && 'run_inparanoid' to 0 && 'blastall' to 'blastall -a32'
cp ../script.cmd ./ # revise the job script
# change to compute node to submit jobs
# jlkang@hpc2021-io1 Fri Dec 31 16:24:48 ~/orthologous_detection
ssh jlkang@hpc2021
# jlkang@hpc2021 Fri Dec 31 16:26:34 ~/orthologous_detection
sbatch script.cmd
# Submitted batch job 113072
# jlkang@hpc2021 Fri Dec 31 16:28:21 ~/orthologous_detection
sq
# JOBID  PARTITION  NAME         ST   USER       QOS      NODES CPUS  TRES_PER_NODE TIME_LIMIT  TIME_LEFT   NODELIST(REASON)
# 113072 intel      inparanoid_b PD   jlkang     normal   66    2112  N/A           3-10:00:00  3-10:00:00  (Priority)
split -11 RUN.sh RUN.sh
```

```bash
# jlkang@hpc2021 Fri Dec 31 20:51:42 ~/orthologous_detection
sbatch script.RUN.shaa.cmd # [a-f]
# jlkang@hpc2021 Fri Dec 31 21:30:14 ~/orthologous_detection
sq
# JOBID  PARTITION  NAME         ST   USER       QOS      NODES CPUS  TRES_PER_NODE TIME_LIMIT  TIME_LEFT   NODELIST(REASON)
# 113115 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
# 113116 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
# 113117 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
# 113118 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
# 113120 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
# 113119 amd        inparanoid_b PD   jlkang     normal   1     128   N/A           3-10:00:00  3-10:00:00  (Priority)
```
***
# Orthofinder
Orthofind is more suitable to as the tool for gene family than blastall (personal opinion)   
```bash
# Kang@fishlab3 Sat Jan 01 13:25:40 /media/HDD/cleaner_fish/genome/gene_family_2
mkdir longest_pep; cd longest_pep
# Kang@fishlab3 Sat Jan 01 14:05:34 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep
cp ../Longest_*_pep.fasta ./;mv Longest_Spotted_gar_pep.fasta Longest_Spottedgar_pep.fasta;mv Longest_Japanese_Medaka_pep.fasta Longest_Medaka_pep.fasta
# change the fasta file name and add the species name in the header of sequences
perl Change_name.pl; rm Change_name.pl
cd ../
# Kang@fishlab3 Sat Jan 01 14:06:00 /media/HDD/cleaner_fish/genome/gene_family_2
nohup orthofinder -f longest_pep -a 32 >Orthofinder.process 2>&1 &
# [1] 14786
```
## All these orthogroups would be applied to detect postive selection
tree: /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/Gene_Trees   
### Download the cds nucleotide sequences of six species (e.g., Zebrafish) from Ensembl
all pep and cds in   
```bash
# jlkang@hpc2021 Mon Jan 03 11:48:32 ~/orthologous_detection/all_pep
# jlkang@hpc2021 Mon Jan 03 11:48:32 ~/orthologous_detection/all_cds
perl Ensemble_longest_pep.pl --fasta *.fa # Longest_*_all_cds.fa are the result (longest cds per species)
```
### The cds sequences of longest pep of other six speceis are detected before in gene family analysis
```bash
# Kang@fishlab3 Mon Jan 03 12:03:02 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
# Longest_Cheilinus_undulatus_cds.fasta; Longest_Labroides_dimidiatus_cds.fasta
# Longest_Labrus_bergylta_cds.fasta; Longest_Notolabrus_celidotus_cds.fasta
# Longest_Symphodus_melops_cds.fasta; Longest_Thalassoma_bifasciatum_cds.fasta

# Kang@fishlab3 Mon Jan 03 13:54:02 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
mkdir longest_pep_sequences; mkdir longest_cds_sequences
scp jlkang@hpc2021-io1.hku.hk:~/orthologous_detection/all_cds/Longest_*_all_cds.fa longest_cds_sequences/
# Kang@fishlab3 Mon Jan 03 14:01:18 /media/HDD/cleaner_fish/genome/gene_family_2/single_copy_id
ll Longest_*_cds.fasta|perl -alne 'unless (/single_copy_id_cds/){$n.=$F[-1]." "};END{print $n}'
cp Longest_Cheilinus_undulatus_cds.fasta Longest_Labroides_dimidiatus_cds.fasta Longest_Labrus_bergylta_cds.fasta Longest_Notolabrus_celidotus_cds.fasta Longest_Symphodus_melops_cds.fasta Longest_Thalassoma_bifasciatum_cds.fasta /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/longest_cds_sequences/
# Kang@fishlab3 Mon Jan 03 14:03:50 /media/HDD/cleaner_fish/genome/gene_family_2
ll Longest_*_pep.fasta|perl -alne '$n.=$F[-1]." "};END{print $n}'
cp Longest_Cheilinus_undulatus_pep.fasta Longest_Fugu_pep.fasta Longest_Japanese_Medaka_pep.fasta Longest_Labroides_dimidiatus_pep.fasta Longest_Labrus_bergylta_pep.fasta Longest_Notolabrus_celidotus_pep.fasta Longest_Platyfish_pep.fasta Longest_Spotted_gar_pep.fasta Longest_Stickleback_pep.fasta Longest_Symphodus_melops_pep.fasta Longest_Thalassoma_bifasciatum_pep.fasta Longest_Zebrafish_pep.fasta /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/longest_pep_sequences/
```
***
# One protein as the representative protein of gene family per species
the longest one per species per gene family will be randomly selected   
```bash
# Kang@fishlab3 Mon Jan 03 15:42:33 /media/HDD/cleaner_fish/genome/gene_family_2
mv Longest_Japanese_Medaka_pep.fasta Longest_Medaka_pep.fasta
mv Longest_Spotted_gar_pep.fasta Longest_Spottedgar_pep.fasta
# pep length <=10000
perl Extract_rep_gene_fm.pl >Rep_gene_fm.txt # 8974 gene family
mkdir paml_input; cd paml_input
# Kang@fishlab3 Mon Jan 03 17:51:52 /media/HDD/cleaner_fish/genome/gene_family_2/paml_input
cp ../Longest_Zebrafish_pep.fasta ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/longest_cds_sequences/*.fasta ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/longest_cds_sequences/*.fa ./
vi correlation.txt
# Zebrafish       Longest_Zebrafish_pep.fasta     Longest_Zebrafish_all_cds.fa
# Stickleback     Longest_Stickleback_pep.fasta   Longest_Stickleback_all_cds.fa
# Spottedgar      Longest_Spotted_gar_pep.fasta   Longest_Spottedgar_all_cds.fa
# Platyfish       Longest_Platyfish_pep.fasta     Longest_Platyfish_all_cds.fa
# Medaka  Longest_Japanese_Medaka_pep.fasta       Longest_medaka_all_cds.fa
# Cund    Longest_Cheilinus_undulatus_pep.fasta   Longest_Cheilinus_undulatus_cds.fasta
# Fugu    Longest_Fugu_pep.fasta  Longest_Fugu_all_cds.fa
# Lber    Longest_Labrus_bergylta_pep.fasta       Longest_Labrus_bergylta_cds.fasta
# Ncel    Longest_Notolabrus_celidotus_pep.fasta  Longest_Notolabrus_celidotus_cds.fasta
# Smel    Longest_Symphodus_melops_pep.fasta      Longest_Symphodus_melops_cds.fasta
# Tbif    Longest_Thalassoma_bifasciatum_pep.fasta        Longest_Thalassoma_bifasciatum_cds.fasta
# Ldim    Longest_Labroides_dimidiatus_pep.fasta  Longest_Labroides_dimidiatus_cds.fasta
cp ../Rep_gene_fm.txt ./
# parallel run prepare_input_paml.pl: two threads
nohup perl prepare_input_paml_parallel.pl Rep_gene_fm.txt >prepare_input_paml.process 2>&1 &
# [1] 11647
```
## RUN codeml
vi spe_Ldim.tre   
```bash
# Kang@fishlab3 Thu Jan 06 10:32:06 /media/HDD/cleaner_fish/genome/gene_family_2/paml_input
vi spe_Ldim.tre
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif,Ldim #1)))))),Spottedgar);
# perl codeml.pl --input final_orth_input_paml.txt --model branch-site --dir . --output_suf Ldim --tree spe_Ldim.tre --icode 0 --omega 1.2
# parallel run codeml.pl: codeml_parallel.pl
nohup perl codeml_parallel.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 23132
```
## Result
**working dir**: /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/postively_selected_genes      
vi temp1.pl    
```perl
#!/usr/bin/perl -w
use strict;
use warnings;
use List::MoreUtils qw(uniq);

# working dir: /media/HDD/cleaner_fish/genome/gene_family_2/reports_2

# get the anno info per gene family using Zebrafish anno info
# Zebrafish anno info: /media/HDD/cleaner_fish/genome/gene_family_2/all_annotation/Zebrafish_gene.txt
# gene per family: /media/HDD/cleaner_fish/genome/gene_family_2/dump.blast_output.mci.I30

my %zebra;
my $zebra_ano="/media/HDD/cleaner_fish/genome/gene_family_2/all_annotation/Zebrafish_gene.txt";
open ZEBRA, "$zebra_ano" or die "There is no $zebra_ano\n";
while (<ZEBRA>) {
        chomp;
        my @a=split /\t/;
        next if /^Gene/;
        my $id="Zebrafish_".$a[0];
        my $info;
        for (my $i = 1; $i < @a; $i++) {
                $info.=$a[$i]."\t";
        }
        $info=~s/\s+$//;
        $zebra{$id}=$info;
}

my %family;
my $fam="/media/HDD/cleaner_fish/genome/gene_family_2/dump.blast_output.mci.I30";
my $k;
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        $k++;
        my @a=split;
        next if ! /Zebrafish/i;
        for (my $i = 0; $i < @a; $i++) {
                if ($a[$i]=~/Zebrafish/i) {
                        $family{$k}=$zebra{$a[$i]};
#                       print "$k\t$family{$k}\n";
                        last;
                }
        }
}

my @txts=<*.txt>;
foreach my $txt (@txts) {
        (my $id)=$txt=~/Ldim-psg-Family_(\d+)\.txt/;
        my $ano=$family{$id};
        print "Family_$id\t$ano\n";
}
```

```bash
# Kang@fishlab3 Wed Jan 12 11:40:04 /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/postively_selected_genes
perl temp1.pl >psg.txt
```
**psg.txt: 234 positively selected gene family**     
## Check the one-to-one gene family in the positively selected genes
extract the one-to-one gene family    
1210 one-to-one gene families   
```bash
# Kang@fishlab3 Wed Jan 12 11:53:05 /media/HDD/cleaner_fish/genome/gene_family_2
less filtered_cafe_input_zebra.txt|perl -alne 'my @a;for($i=2;$i<@F;$i++){push @a, $F[$i] if $F[$i]==1};$fa="Family_".$F[1];print "$fa" if @a==12' >single_copy_fm_id.txt
```

vi add_dup_info_psg.pl    
```perl
#!/usr/bin/perl -w
use strict;
use warnings;

# figure out which gene family is one-to-one in psg
# single_copy_fm_id.txt
# psg.txt: /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/postively_selected_genes/psg.txt

my $single="single_copy_fm_id.txt";
my %single;
open SINGLE, $single or die "can not open $single\n";
while (<SINGLE>) {
	chomp; $single{$_}++;
}

my $psg="/media/HDD/cleaner_fish/genome/gene_family_2/paml_input/postively_selected_genes/psg.txt";
open PSG, $psg or die "can not open $psg\n";
while (<PSG>) {
	chomp; my @a=split /\t/;
	if ($single{$a[0]}) {
		print "$a[0]\tSingle_copy\t$a[1]\t$a[2]\n";
	} else {
		print "$a[0]\tMulti_copy\t$a[1]\t$a[2]\n";
	}
}
```

```bash
# Kang@fishlab3 Wed Jan 12 12:09:23 /media/HDD/cleaner_fish/genome/gene_family_2
perl add_dup_info_psg.pl >psg_add_dup_info.txt
```
**29 one-to-one gene family; 205 multi copy gene families**    
***
## Restart the postively selected genes analysis based on the orthogous estimated by OrthoFinder
### based on the gene tree per orthogroups estimated by OrthoFinder to get one gene per species per orthogroup by possvm.py     
```bash
# Kang@fishlab3 Sun Apr 03 22:52:10 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
nohup perl get_orth_for_paml.pl >get_orth_for_paml.process 2>&1 &
[1] 2894
# The final orthologous genes (one per species): final_orth.txt
```
### prepare the paml input
```bash
# Kang@fishlab3 Mon Apr 04 09:56:47 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
mkdir paml_input; mv Longest* paml_input
cd paml_input
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/correlation.txt ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/prepare_input_paml_parallel.pl ./
cp ../final_orth.txt ./
less final_orth.txt|perl -alne 'my $info;for ($i=1;$i<@F;$i++){$F[$i]=~s/.*\_// if $F[$i]=~/\_EN/;$info.=$F[$i]."\t"};$info=~s/\s+$//;print"$F[0]\t$info"' >final_orth.txt.1
nohup perl prepare_input_paml_parallel.pl final_orth.txt.1 >prepare_input_paml.process 2>&1 &
# [1] 743
#################
# Ldim
#################
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/spe_Ldim.tre ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/codeml.pl ./
cp /media/HDD/cleaner_fish/genome/gene_family_2/paml_input/codeml_parallel.pl ./
# Kang@fishlab3 Tue Apr 05 19:43:07 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/paml_input
nohup perl codeml_parallel.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 31988
# Kang@fishlab3 Fri Apr 08 17:38:03 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01/paml_input
perl add_PSGs_info.pl /media/HDD/cleaner_fish/genome/gene_family_2/Ldim.anno.final.txt final_orth.txt.1 >Ldim_potential_psg.txt

# Estimate FDR
# R
# p_apoly<-read.table(file="Ldim_potential_psg.txt", sep="\t", quote = "")
# p_apoly$fdr<- p.adjust(p_apoly$V5,method="fdr",length(p_apoly$V5))
# write.table(p_apoly, file="p_fdr_Ldim.txt",row.names=F,col.names=F,quote=F,sep="\t")
less p_fdr_Ldim.txt|perl -alne 'print if $F[-1]<=0.05' >Ldim_final_psg.txt

#################
# Tbif in SNORLAX
#################
# SNORLAX run paml
# Kang@fishlab3 Tue Apr 05 21:22:20 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
nohup scp -r paml_input/ kang1234@147.8.76.155:~/genome
# ctrl+z
bg
# [2]+ nohup scp -r paml_input/ kang1234@147.8.76.155:~/genome &
# (base) kang1234@celia-PowerEdge-T640 Tue Apr 05 21:37:51 ~/genome/paml_input
cp codeml_parallel.pl codeml_parallel_Tbif.pl
vi codeml_parallel_Tbif.pl 
# my $cmd="perl codeml.pl --input temp/$temp --model branch-site --dir . --output_suf Tbif --tree spe_Tbif.tre --icode 0 --omega 1.2";
vi spe_Tbif.tre
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif #1,Ldim)))))),Spottedgar);
nohup perl codeml_parallel_Tbif.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 818

#################
# Smel in SNORLAX
#################
# (base) kang1234@celia-PowerEdge-T640 Thu Apr 07 13:11:32 ~/genome/paml_input
# 20 threads
cp codeml_parallel_Tbif.pl codeml_parallel_Smel.pl
cp spe_Tbif.tre spe_Smel.tre
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel #1,Lber)),(Ncel,(Tbif,Ldim)))))),Spottedgar);
nohup perl codeml_parallel_Smel.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 9128

#################
# Lber in SNORLAX
#################
# (base) kang1234@celia-PowerEdge-T640 Sun Apr 10 10:31:52 ~/genome/paml_input
# 20 threads
cp codeml_parallel_Tbif.pl codeml_parallel_Lbel.pl
cp spe_Tbif.tre spe_Lbel.tre
# ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber #1)),(Ncel,(Tbif,Ldim)))))),Spottedgar);
nohup perl codeml_parallel_Lbel.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 3999

###################################################
# the ancestal branch of Tbif and Ldim in SNORLAX
###################################################
# (base) kang1234@celia-PowerEdge-T640 Thu Apr 21 13:16:47 ~/genome/paml_input
vi Ancestor_Ldim_Tbif.tre 
# tree: ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif,Ldim) #1))))),Spottedgar);
cp codeml_parallel_Lbel.pl codeml_parallel_Ancestor_Ldim_Tbif.pl
nohup perl codeml_parallel_Ancestor_Ldim_Tbif.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 10651
perl add_PSGs_info_2.pl clearner_fish_anno.final.txt final_orth.txt.1 >Ancestor_Ldim_Tbif_potential_psg.txt
# Estimate FDR
# R
# p_apoly<-read.table(file="Ancestor_Ldim_Tbif_potential_psg.txt", sep="\t", quote = "")
# p_apoly$fdr<- p.adjust(p_apoly$V5,method="fdr",length(p_apoly$V5))
# write.table(p_apoly, file="p_fdr_Ancestor_Ldim_Tbif.txt",row.names=F,col.names=F,quote=F,sep="\t")
less p_fdr_Ancestor_Ldim_Tbif.txt|perl -alne 'print if $F[-1]<=0.05' >Ancestor_Ldim_Tbif_final_psg.txt

###################################################
# the ancestal branch of Smel and Lber in SNORLAX
###################################################
(base) kang1234@celia-PowerEdge-T640 Tue Apr 26 11:46:13 ~/genome/paml_input
$vi Ancestor_Smel_Lber.tre 
# tree: ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber) #1),(Ncel,(Tbif,Ldim)))))),Spottedgar);
cp codeml_parallel_Ancestor_Ldim_Tbif.pl codeml_parallel_Ancestor_Smel_Lber.pl
nohup perl codeml_parallel_Ancestor_Smel_Lber.pl final_orth_input_paml.txt >codeml.process 2>&1 &
# [1] 7581
perl add_PSGs_info_2.pl clearner_fish_anno.final.txt final_orth.txt.1 >Ancestor_Smel_Lber_potential_psg.txt
# Estimate FDR
# R
# p_apoly<-read.table(file="Ancestor_Smel_Lber_potential_psg.txt", sep="\t", quote = "")
# p_apoly$fdr<- p.adjust(p_apoly$V5,method="fdr",length(p_apoly$V5))
# write.table(p_apoly, file="p_fdr_Ancestor_Smel_Lber.txt",row.names=F,col.names=F,quote=F,sep="\t")
less p_fdr_Ancestor_Smel_Lber.txt|perl -alne 'print if $F[-1]<=0.05' >Ancestor_Smel_Lber_final_psg.txt

##########################################
# free-ratio to estimate evolutionary rate
##########################################
# (base) kang1234@celia-PowerEdge-T640 Tue Apr 12 21:19:53 ~/genome/paml_input
# perl codeml.pl --input final_orth_input_paml.txt --model free-ratio --dir . --tree spe.tre --icode 0 --omega 1.2
cp codeml_parallel_Lbel.pl codeml_parallel_free_ratio.pl
vi codeml_parallel_free_ratio.pl
cp spe_Tbif.tre spe.tre
# spe.tre: ((Zebrafish,((Platyfish,Medaka),((Fugu,Stickleback),((Cund,(Smel,Lber)),(Ncel,(Tbif,Ldim)))))),Spottedgar);
nohup perl codeml_parallel_free_ratio.pl final_orth_input_paml.txt >free_ratio.process 2>&1 &
# [1] 31549
# get the free ratio results
# (base) kang1234@celia-PowerEdge-T640 Fri Apr 15 09:40:22 ~/genome/paml_input
perl extract_free_ratio.pl final_orth_input_paml.txt # output in the current dir: free_ratio_result.txt
perl make_bin_plot_total.pl >free_ratio_bin_plot_total.txt

# use the Ldim gene in final_orth.txt.1 to do the enrichment
# Functional enrichment Result: Ldim_kaks_enrichment.txt
# Kang@fishlab3 Sun Apr 17 11:58:53 ~/Desktop/KaKs_free/Ldim
# GO: Wilcoxon_rank-sum Ldim sig. larger/smaller than other 5 Labridae fish species
perl Wilcoxon_rank-sum_test_GO_ratio.pl >target.Ldim.go.larger5.txt
perl Wilcoxon_rank-sum_test_GO_ratio.2.pl >target.Ldim.go.larger1.txt

# plot the evolutionary rate of certain GO functions
# kangjingliang@kangjingliangdeMacBook-Pro 日  4 17 21:50:26 ~/Documents/2022/Ldim_genome/PSGs
perl extract_gene_under_GO_in_free_ratio.pl olfactory_behavior.txt >olfactory_behavior_free_ratio.txt
perl extract_gene_under_GO_in_free_ratio.pl visual_behavior.txt >visual_behavior_free_ratio.txt
perl extract_gene_under_GO_in_free_ratio.pl social_behavior.txt >social_behavior_free_ratio.txt
```
### identify the lost genes
```bash
# Kang@fishlab3 Mon Apr 04 20:31:46 /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/OrthoFinder/Results_Jan01
nohup perl do_possvm_left.pl >do_possvm_left.process 2>&1 &
# [1] 29888
# estimate the gene nb in each new orthogroup
perl estimate_gene_nb_new_orth.pl number >gene_nb_new_orth.txt
perl estimate_gene_nb_new_orth.pl gene >gene_new_orth.txt
```

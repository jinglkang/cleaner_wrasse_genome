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
# refer	Longest_Zebrafish_pep.fasta
# Zebrafish	Longest_Zebrafish_all_cds.fa
# Stickleback	Longest_Stickleback_all_cds.fa
# Spottedgar	Longest_Spottedgar_all_cds.fa
# Platyfish	Longest_Platyfish_all_cds.fa
# Medaka	Longest_medaka_all_cds.fa
# Cund	Longest_Cheilinus_undulatus_cds.fasta
# Fugu	Longest_Fugu_all_cds.fa
# Lber	Longest_Labrus_bergylta_cds.fasta
# Ncel	Longest_Notolabrus_celidotus_cds.fasta
# Smel	Longest_Symphodus_melops_cds.fasta
# Tbif	Longest_Thalassoma_bifasciatum_cds.fasta
# Ldim	Longest_Labroides_dimidiatus_cds.fasta
cp ../Rep_gene_fm.txt ./
# parallel run prepare_input_paml.pl
nohup perl prepare_input_paml_parallel.pl Rep_gene_fm.txt >prepare_input_paml.process 2>&1 &
# [1] 5208
```
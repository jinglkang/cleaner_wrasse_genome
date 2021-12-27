Gene annotation for another two species (also another three species: *Cheilinus undulatus*, *Labrus bergylta*, *Notolabrus celidotus*)
------------------------------------------------------
## Symphodus melops (corkwing wrasse)
annotation gtf file lacks the alternative splicing information          
working dir: ~/Desktop/cleaner_fish/genome   && SNORLAX:   ~/genome/Repeat_annotation/smel_repeat     
### Tandem Repeats Finder to search the tandem repeat
```bash
mkdir smel_genome
cd smel_genome/
trf Symphodus_melops.fasta 2 5 7 80 10 50 2000 -h -f -d -m
```
### Repeat annotation
#### RepeatModeler
```bash
curl -sSLO https://github.com/Dfam-consortium/TETools/raw/master/dfam-tetools.sh
chmod +x dfam-tetools.sh
./dfam-tetools.sh
BuildDatabase -name Symphodus_melops Symphodus_melops.fasta
nohup RepeatModeler -database Symphodus_melops -pa 30 -LTRStruct >& RepeatModeler.run.out &
```
#### RepeatMasker: soft mask
```bash
RepeatMasker -lib Symphodus_melops-families.fa -pa 30 -xsmall Symphodus_melops.fasta
cp Symphodus_melops.fasta.masked Symphodus_melops_softmasked.fasta
```
results: ~/Desktop/cleaner_fish/genome/smel_genome/Symphodus_melops_softmasked.fasta
### Gene Prediction
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--species Symphodus_melops \
--cores 20 \
--genome=Symphodus_melops_softmasked.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta \
--workingdir ./Symphodus_melops
```
### Annotate
```bash
# rename first
rename_gtf.py --gtf braker.gtf --prefix Smel --out braker_renamed.gtf
# get the pep sequence per transcript
~/software/gffread/gffread -y Symphodus_melops.pep.all.fasta -g ../Symphodus_melops_softmasked.fasta braker_renamed.gtf
# rename the sequences header and remove sequences if the sequences include '.'
less Symphodus_melops.pep.all.fasta|perl -alne 'if (/>/){my ($gene)=$_=~/>(.*)\./;print "$_ gene=$gene"}else{print}' >Symphodus_melops.pep.all.1.fasta
# get the longest transcript per gene
perl extract_long_transcript.pl Symphodus_melops.pep.all.1.fasta
# the output is suffixed with "conca" and "conca.long"
# Symphodus_melops.pep.all.1.conca.fasta: the pep sequences are concatenated
# Symphodus_melops.pep.all.1.conca.long.fasta: the longest concatenated pep sequences per gene
# now we can annotate Symphodus_melops.pep.all.1.conca.long.fasta by annotate
annotate --fasta Symphodus_melops.pep.all.1.conca.long.fasta
```
***
## *Thalassoma bifasciatum* : did not find the annotation information
Gene prediction for *Thalassoma bifasciatum* (Bluehead wrasse)
### Using OrthoDB as basis for protein.fa to predict genes
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--species Thalassoma_bifasciatum \
--cores 20 \
--genome=Thalassoma_bifasciatum_ChaHeader.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta \
--workingdir ./Thalassoma_bifasciatum
```
### Annotate
```bash
less Thalassoma_bifasciatum.pep.all.fasta|perl -alne 'if (/>/){my ($gene)=$_=~/>(.*)\./;print "$_ gene=$gene"}else{print}' >Thalassoma_bifasciatum.pep.all.1.fasta
perl ../Symphodus_melops/extract_long_transcript.pl Thalassoma_bifasciatum.pep.all.1.fasta
annotate --fasta Thalassoma_bifasciatum.pep.all.1.conca.long.fasta
```
***
## *Cheilinus undulatus*
### Using OrthoDB as basis for protein.fa to predict genes
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--species Cheilinus_undulatus \
--cores 20 \
--genome=Cheilinus_undulatus_softmasked_ChaHeader.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta \
--workingdir ./Cheilinus_undulatus
```
## Annotate
```bash
rename_gtf.py --gtf braker.gtf --prefix Cund --out braker_renamed.gtf
~/software/gffread/gffread -y Cheilinus_undulatus.pep.all.fasta -g ../Cheilinus_undulatus_softmasked_ChaHeader.fasta braker_renamed.gtf
less Cheilinus_undulatus.pep.all.fasta|perl -alne 'if (/>/){my ($gene)=$_=~/>(.*)\./;print "$_ gene=$gene"}else{print}' >Cheilinus_undulatus.pep.all.1.fasta
perl ../Symphodus_melops/extract_long_transcript.pl Cheilinus_undulatus.pep.all.1.fasta
annotate --fasta Cheilinus_undulatus.pep.all.1.conca.long.fasta
```
***
## *Labrus bergylta*
### Using OrthoDB as basis for protein.fa to predict genes
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--species Labrus_bergylta \
--cores 20 \
--genome=Labrus_bergylta_softmasked_ChaHeader.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta \
--workingdir ./Labrus_bergylta
```
### Annotate
```bash
rename_gtf.py --gtf braker.gtf --prefix Lber --out braker_renamed.gtf
~/software/gffread/gffread -y Labrus_bergylta.pep.all.fasta -g ../Labrus_bergylta_softmasked_ChaHeader.fasta braker_renamed.gtf
less Labrus_bergylta.pep.all.fasta|perl -alne 'if (/>/){my ($gene)=$_=~/>(.*)\./;print "$_ gene=$gene"}else{print}' >Labrus_bergylta.pep.all.1.fasta
perl ../Symphodus_melops/extract_long_transcript.pl Labrus_bergylta.pep.all.1.fasta
annotate --fasta Labrus_bergylta.pep.all.1.conca.long.fasta
```
***
## *Notolabrus celidotus*
### Using OrthoDB as basis for protein.fa to predict genes
```bash
braker.pl --softmasking --AUGUSTUS_ab_initio --gff3 \
--species Notolabrus_celidotus \
--cores 20 \
--genome=Notolabrus_celidotus_softmasked_ChaHeader.fasta \
--prot_seq=OrthoDB_Vertebrata/proteins.fasta \
--workingdir ./Notolabrus_celidotus
```
### Annotate
```bash
rename_gtf.py --gtf braker.gtf --prefix Ncel --out braker_renamed.gtf
~/software/gffread/gffread -y Notolabrus_celidotus.pep.all.fasta -g ../Notolabrus_celidotus_softmasked_ChaHeader.fasta braker_renamed.gtf
less Notolabrus_celidotus.pep.all.fasta|perl -alne 'if (/>/){my ($gene)=$_=~/>(.*)\./;print "$_ gene=$gene"}else{print}' >Notolabrus_celidotus.pep.all.1.fasta
perl ../Symphodus_melops/extract_long_transcript.pl Notolabrus_celidotus.pep.all.1.fasta
annotate --fasta Notolabrus_celidotus.pep.all.1.conca.long.fasta
```
***
## Run BUSCO for all six speices
copy all pep fasta files to my own workstation   
```bash
# Kang@fishlab3 Mon Dec 27 19:53:14 /media/HDD/cleaner_fish_genome
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Symphodus_melops/Symphodus_melops.pep.all.1.conca.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Thalassoma_bifasciatum/Thalassoma_bifasciatum.pep.all.1.conca.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Notolabrus_celidotus/Notolabrus_celidotus.pep.all.1.conca.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Labrus_bergylta/Labrus_bergylta.pep.all.1.conca.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/Cheilinus_undulatus/Cheilinus_undulatus.pep.all.1.conca.fasta ./
```
run BUSCO   
vi run_busco.sh   
```bash
python ~/software/Busco/scripts/run_BUSCO.py -m prot -i Symphodus_melops.pep.all.1.conca.fasta -o Smel -l ~/software/Busco/lineage/actinopterygii_odb9 -c 30 -t Smel-tmp
python ~/software/Busco/scripts/run_BUSCO.py -m prot -i Thalassoma_bifasciatum.pep.all.1.conca.fasta -o Tbif -l ~/software/Busco/lineage/actinopterygii_odb9 -c 30 -t Tbif-tmp
python ~/software/Busco/scripts/run_BUSCO.py -m prot -i Notolabrus_celidotus.pep.all.1.conca.fasta -o Ncel -l ~/software/Busco/lineage/actinopterygii_odb9 -c 30 -t Ncel-tmp
python ~/software/Busco/scripts/run_BUSCO.py -m prot -i Labrus_bergylta.pep.all.1.conca.fasta -o Lber -l ~/software/Busco/lineage/actinopterygii_odb9 -c 30 -t Lber-tmp
python ~/software/Busco/scripts/run_BUSCO.py -m prot -i Cheilinus_undulatus.pep.all.1.conca.fasta -o Cund -l ~/software/Busco/lineage/actinopterygii_odb9 -c 30 -t Cund-tmp
```

```bash
nohup sh run_busco.sh > Busco.process 2>&1 &
# [1] 26627
```

Gene annotation for another two species
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
# rename the sequences header
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

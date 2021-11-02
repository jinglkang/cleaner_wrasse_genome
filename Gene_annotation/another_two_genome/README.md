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

# Phylogeny
-----------
## Mitochondrial genes: COI, 12S, 16S
### Species (NCBI: Nucleotide --> search "Thamnaconus septentrionalis mitochondrion, complete genome")
**Labridae** (10 species): 5 Labroides; 1 Symphodus; 1 Labrus; 1 Thalassoma; 1 Cheilinus; 1 Notolabrus.     
*Labrodies dimdiatus* (sequences from our genome and a individual from NCBI), *L. phthirophagus*, *L. bicolor*, *L. pectoralis*, *L. rubrolabiatus*     
Symphodus melops, Labrus bergylta, *Thalassoma bifasciatum*, *Cheilinus undulatus*, *Notolabrus celidotus*    
**outgroup**: Eupercaria ()     
Eupercaria; Perciformes; Serranoidei; Serranidae; Epinephelinae; Epinephelini; Epinephelus; Epinephelus fuscoguttatus    
Eupercaria; Centrarchiformes; Centrarchoidei; Centrarchidae; Micropterus; Micropterus salmoides    
Eupercaria; Lutjaniformes; Lutjanidae; Lutjanus; Lutjanus erythropterus     
Eupercaria; Sciaenidae; Sciaenops; Sciaenops ocellatus     
Eupercaria; Chaetodontiformes; Chaetodontidae; Chelmon; Chelmon rostratus     
Eupercaria; Tetraodontiformes; Monacanthidae; Thamnaconus; Thamnaconus septentrionalis     
Eupercaria; Lophiiformes; Antennarioidei; Antennariidae; Antennarius; Antennarius maculatus       
Eupercaria; Scatophagidae; Scatophagus; Scatophagus argus        
Eupercaria; Spariformes; Sparidae; Acanthopagrus; Acanthopagrus latus      
Eupercaria; Lobotiformes; Datnioididae; Datnioides; Datnioides undecimradiatus     
Eupercaria; Moronidae; Morone; Morone chrysops     
Eupercaria; Pempheriformes; Lateolabracidae; Lateolabrax; Lateolabrax maculatus  
Danio rerio (zebrafish)     
***
### before concatenated the sequences of three mito genes
working dir: my own workstation (~/Desktop/cleaner_fish/mito_phy)    
download the sequences, and put all sequences to one file according genes      
```bash
perl cat_sequences.pl --fasta *.12S.fasta >12S.fasta
perl cat_sequences.pl --fasta *.16S.fasta >16S.fasta
perl cat_sequences.pl --fasta *.COI.fasta >COI.fasta
```
**align by Muscle**    
trim flanking regions, for COI (keep the sequences can be translated to pep), for 12S and 16S (delete the postion if any species includes a gap), and concatenated the sequences of three genes per species       
```bash
perl concatenated.pl --fasta *_align*fasta --out concatenated
```
gene length: 12S (424 bp), 16S (511 bp), COI (634 bp).    
***
### identify the best-fitting model for each gene
```bash
java -jar ~/software/jmodeltest-2.1.10/jModelTest.jar -d 12S_align.fasta -g 4 -i -f -AIC -BIC -a
java -jar ~/software/jmodeltest-2.1.10/jModelTest.jar -d 16S_align.fasta -g 4 -i -f -AIC -BIC -a
java -jar ~/software/jmodeltest-2.1.10/jModelTest.jar -d COI_align_coding.fasta -g 4 -i -f -AIC -BIC -a
```

12S Best Models:    
||Model|f(a)|f(c)|f(g)|f(t)|kappa|titv|Ra|Rb|Rc|Rd|Re|Rf|pInv|gamma|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|AIC|GTR+I+G|0.30|0.26|0.21|0.23|0.00|0.00|2.343|8.240|2.420|0.264|18.064|1.000|0.44|0.55|
|BIC|SYM+I+G|0.25|0.25|0.25|0.25|0.00|0.00|4.709|11.891|4.069|0.317|27.272|1.000|0.44|0.58|

16S Best Models:   
||Model|f(a)|f(c)|f(g)|f(t)|kappa|titv|Ra|Rb|Rc|Rd|Re|Rf|pInv|gamma|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|AIC|GTR+I+G|0.30|0.22|0.24|0.23|0.00|0.00|9.285|19.505|6.987|0.854|36.943|1.000|0.37|0.49|
|BIC|SYM+I+G|0.25|0.25|0.25|0.25|0.00|0.00|11.147|24.518|9.011|0.767|36.947|1.000|0.39|0.55|

COI Best Models:    
||Model|f(a)|f(c)|f(g)|f(t)|kappa|titv|Ra|Rb|Rc|Rd|Re|Rf|pInv|gamma|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|AIC|HKY+I+G|0.30|0.28|0.12|0.30|21.41|10.56|1.000|21.409|1.000|1.000|21.409|1.000|0.36|0.21|
|BIC|HKY+I+G|0.30|0.28|0.12|0.30|21.41|10.56|1.000|21.409|1.000|1.000|21.409|1.000|0.36|0.21|
***
### transform fasta file to phylip format
```bash
fasta2phy.pl concatenated.fasta >concatenated.phy
```

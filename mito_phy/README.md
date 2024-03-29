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
java -jar ~/software/jmodeltest-2.1.10/jModelTest.jar -d concatenated.fasta -g 4 -i -f -AIC -BIC -a
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

concatenated genes Best Models:       
||Model|f(a)|f(c)|f(g)|f(t)|kappa|titv|Ra|Rb|Rc|Rd|Re|Rf|pInv|gamma|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|AIC|GTR+I+G|0.31|0.25|0.18|0.26|0.00|0.00|2.825|13.095|3.554|0.765|27.807|1.000|0.48|0.52|    
|BIC|GTR+I+G|0.31|0.25|0.18|0.26|0.00|0.00|2.825|13.095|3.554|0.765|27.807|1.000|0.48|0.52|    

***

### transform fasta file to phylip format
```bash
fasta2phy.pl concatenated.fasta >concatenated.phy
```
### CONSTRUCT phylogentic tree: Raxml
#### concatenated, no partition
```bash
raxmlHPC -f a -x 12345 -p 12345 -# 1000 -m GTRGAMMAI -s concatenated.phy -n concatenated_1
```
**results:**        
Best-scoring ML tree written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bestTree.concatenated_1       
Best-scoring ML tree with support values written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitions.concatenated_1      
Best-scoring ML tree with support values as branch labels written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitionsBranchLabels.concatenated_1       
All 1000 bootstrapped trees written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bootstrap.concatenated_1         
#### partition
patitions.tab:   
DNA, gene1 = 1-424     
DNA, gene2 = 425-935      
DNA, gene3 = 936-1569     

```bash
raxmlHPC -f a -m GTRGAMMAI -p 12345 -x 12345 -# 1000 -q patitions.tab -s concatenated.phy -n concatenated_2
```
**results:**     
Best-scoring ML tree written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bestTree.concatenated_2       
Best-scoring ML tree with support values written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitions.concatenated_2       
Best-scoring ML tree with support values as branch labels written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitionsBranchLabels.concatenated_2      
#### set Danio_rerio as outgroup
```bash
raxmlHPC -f a -m GTRGAMMAI -p 12345 -x 12345 -# 1000 -q patitions.tab -s concatenated.phy -o Danio_rerio -n concatenated_3
```
**results:**     
Best-scoring ML tree written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bestTree.concatenated_3       
Best-scoring ML tree with support values written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitions.concatenated_3       
Best-scoring ML tree with support values as branch labels written to: /home/Kang/Desktop/cleaner_fish/mito_phy/RAxML_bipartitionsBranchLabels.concatenated_3      
****
### CONSTRUCT phylogentic tree: Beast
convert fasta file to nexus: http://phylogeny.lirmm.fr/phylo_cgi/data_converter.cgi     
add some command in the end:      
```
begin assumptions;
        charset 12S = 1-424;
        charset 16S = 425-935;
        charset COI = 936-1569;
end;
```
In Linux:    
1. ./beauti; File -> import alignment (select the nexus file);    
2. if you just want one combined tree when you set the partitions, select all partitions (link trees);           
3. site model: 12S (GTR+I+G; default + estimate(except substitution rate)); 16S (GTR+I+G; default + estimate(except substitution rate)); COI (HKY+I+G; default + estimate(except substitution rate));       
4. clock model: relaxed clock log normal (default)    
5. priors: default (Yule model: notice uniform birth rate should be set the lower and upper value, here i set them as 0 and 2);
6. priors: if you want to add calibration time (+ add prior: Taxon set, all species you want set to a taxon, log normal distribution (set mean and standard deviation to ensure in calibration time within 2.5%-97.5%), notice to select monophyletic);     
7. MCMC: chain length; store every (how often the prameter values in the markov chain should be displayed on the screen and recorded in the log file: if chain length=1000000, you want more than 10000 samples, then the store every should be 1000000/10000=100); the other set as default;  
8. File -> save as (xml file); ./beast (run the xml file);                
9. Estimate the results: File -> import Trace file (log File); the results are in the directory where you ran beast;        
10. TreeAnnotator to get the final tree: burnin percentage (10); posterior probability limit (0.5);    
****
### CONSTRUCT phylogentic tree: MrBayes 
convert fasta file to nexus: http://phylogeny.lirmm.fr/phylo_cgi/data_converter.cgi     
add some command in the end:      
```
begin mrbayes;
        charset 12S = 1-424;
        charset 16S = 425-935;
        charset COI = 936-1569;
        partition by_gene = 3:12S,16S,COI;
        set partition = by_gene;
end;
```
**run MrBayes:** mb       
set model for each partition         
```
lset applyto=(1,2) nst=6 rates=invgamma
lset applyto=(3) nst=6 rates=invgamma
mcmc ngen=10000000 samplefreq=20000
sump burnin=125
sumt burnin=125
```
***
## restart: the same mito genes, different species
working dir: ~/Desktop/cleaner_fish/mito_phy/restart       
### Species (NCBI: Nucleotide --> search "Thamnaconus septentrionalis mitochondrion, complete genome")
**Labridae** (10 species): 5 Labroides; 1 Symphodus; 1 Labrus; 1 Thalassoma; 1 Cheilinus; 1 Notolabrus.           

*Labrodies dimdiatus* (sequences from our genome and a individual from NCBI), *L. phthirophagus*, *L. bicolor*, *L. pectoralis*, *L. rubrolabiatus*    
*Symphodus melops*, *Labrus bergylta*, *Thalassoma bifasciatum*, *Cheilinus undulatus*, *Notolabrus celidotus*            

**other species** (6 species): medaka, *Oryzias latipes*; fugu, Takifugu rubripes (remove: spotted green pufferfish, *Tetraodon nigroviridis*); stickleback, *Gasterosteus aculeatus*; zebrafish, *Danio rerio*; platyfish, *Xiphophorus maculatus*; Spotted gar, *Lepisosteus oculatus*.     
three genes alignment length: 12S (426); 16S (518); COI	(634).         

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

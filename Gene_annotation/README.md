Gene_annotation
---------------
# BRAKER
## 1. Mapping RNA-seq data to hardmasked genome fasta (Cleaner_wrasse_hardmasked_ChaHeader.fasta)
### Build the index of reference genome
```bash
hisat2-build -f Cleaner_wrasse_hardmasked_ChaHeader.fasta Cleaner_wrasse
```
***
## 1. genome file only
--esmode: In this mode, run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes predicted by GeneMark-ES. Final predictions are ab initio.  
```bash
braker.pl --softmasking --species Labroides_dimidiatus --esmode --cores 20 --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta
```

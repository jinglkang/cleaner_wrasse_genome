Gene_annotation
---------------
# BRAKER
## 1. genome file only
--esmode: In this mode, run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes predicted by GeneMark-ES. Final predictions are ab initio.  
```bash
braker.pl --softmasking --species Labroides_dimidiatus --esmode --cores 20 --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta
```

# Genome synteny with Zebrafish
Zebrafish genome downloaded from NCBI (my workstation: /media/HDD/cleaner_fish/genome/OR_detection/Zebrafish_genome.ncbi.fa)         
## Get the bed file of Cleaner wrasses
SNORALAX: ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.gtf      
```bash
less braker2+3_combined_renamed.gtf|perl -alne 'if ($F[2] eq "gene"){$F[0]=~s/Scx22uW_/LD/;($F[4]>$F[3])?(print "$F[0]\t$F[3]\t$F[4]\t$F[-1]"):(print "$F[0]\t$F[4]\t$F[3]\t$F[-1]")} ' >Ldom.bed
```

# Genome synteny with Zebrafish
Zebrafish genome gtf downloaded from Ensembl (my workstation: /media/HDD/cleaner_fish/genome/synteny/Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf)         
## Get the bed file of Cleaner wrasses
SNORALAX: ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.gtf      
```bash
less braker2+3_combined_renamed.gtf|perl -alne 'if ($F[2] eq "gene"){$F[0]=~s/Scx22uW_/LD/;($F[4]>$F[3])?(print "$F[0]\t$F[3]\t$F[4]\t$F[-1]"):(print "$F[0]\t$F[4]\t$F[3]\t$F[-1]")} ' >Ldim.bed
```
my workstation: /media/HDD/cleaner_fish/genome/synteny
```bash
cp ../OR_detection/Zebrafish_genome.ncbi.fa ./
cp ../gene_family/Longest_Labroides_dimidiatus_pep.fasta ./
scp kang1234@147.8.76.155:~/genome/Gene_annotation/combined/Ldim.bed ./
mv /media/HDD/cleaner_fish/genome/OR_detection/Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf ./
less Danio_rerio.GRCz11.104.chr_patch_hapl_scaff.gtf|grep -v '^#'|perl -alne 'if ($F[2] eq "gene"){my $chr="DR$F[0]";(my $gene)=$_=~/gene_id\s+\"(.*?)\"/;$F[0]=~s/Scx22uW_/LD/;($F[4]>$F[3])?(print "$chr\t$F[3]\t$F[4]\t$gene"):(print "$chr\t$F[4]\t$F[3]\t$gene")}' >Zebrafish.bed
cp ../gene_family/Longest_Zebrafish_pep.fasta ./
```

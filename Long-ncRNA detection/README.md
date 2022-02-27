# Long non-coding RNA annotation
## 1. HISAT2 for mapping: finish
## 2. Stringtie to assemble transcripts
```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Feb 21 13:56:23 ~/genome/Gene_annotation/RNA-seq/RNA-align
mkdir LncRNA_detection; cd LncRNA_detection
cp ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.gtf ./
perl run_stringtie.pl --bams ../ --ref_gtf braker2+3_combined_renamed.gtf --output all_inds.gtf
```
## 3. Long-ncRNA detection
### 3.1 FEELNC
```bash
# Kang@fishlab3 Mon Feb 21 22:02:06 ~/Desktop
mkdir Ldim_LncRNA; cd Ldim_LncRNA

# FEELnc
# [Scx22uW_1	GeneMark.hmm3	transcript	2914	4009	.	+	.	Ldim_g1.t1] does not contain 'transcript_id' attribute...
less braker2+3_combined_renamed.gtf |perl -alne 'my $info;for ($i=0;$i<@F-1;$i++){$info.=$F[$i]."\t"};if ($F[2] eq "gene"){$info.="gene_id \"".$F[-1]."\"";print $info}elsif ($F[2] eq "transcript"){($gene)=$F[-1]=~/(.*)\.t\d+/;$info.="transcript_id \"".$F[-1]."\";"." gene_id \"".$gene."\"";print $info}else{print}' >Ldim_original.gtf
FEELnc_filter.pl --infile=all_inds.gtf --mRNAfile=Ldim_original.gtf --monoex=-1 --biotype=transcript_biotype=protein_coding --outlog=Ldim_filter_LncRNA.log > Ldim_candidate_lncRNA.gtf

# Kang@fishlab3 Tue Feb 22 14:10:46 /tmp
less 17817_Ldim.codpot.coding_rnaSize.tmp|perl -alne 'print if $F[-1]<1'
# name	RNA_size
# Ldim_g28013.t1	0
# Ldim_g1829.t1	0
# Ldim_g5019.t1	0
# Ldim_g309.t2	0
# Ldim_g19182.t1	0

# Kang@fishlab3 Tue Feb 22 14:41:14 ~/Desktop/Ldim_LncRNA/codpot
less Ldim_original.gtf|perl -alne 'unless (/Ldim_g28013.t1|Ldim_g1829.t1|Ldim_g5019.t1|Ldim_g309.t2|Ldim_g19182.t1/){print}' >Ldim_original_remove.gtf
FEELnc_codpot.pl --infile=Ldim_candidate_lncRNA.gtf -a Ldim_original_remove.gtf --genome=Cleaner_wrasse_softmasked_ChaHeader.fasta --mode=intergenic --outname=Ldim.codpot --outdir=codpot/
# Kang@fishlab3 Tue Feb 22 15:52:28 ~/Desktop/Ldim_LncRNA/codpot
less Ldim.codpot.lncRNA.gtf|perl -alne '($tr)=$_=~/transcript_id \"(.*?)\"/;print uc($tr)'|sort -u >Ldim_FEELnc.txt
# 8001 potential LncRNA transcripts
FEELnc_classifier.pl --lncrna=codpot/Ldim.codpot.lncRNA.gtf --mrna=Ldim_original_remove.gtf --log=Ldim.classifier.log > Ldim.classifier.txt
```

### 3.2 CPAT
```bash
# Kang@fishlab3 Tue Feb 22 15:16:15 ~/Desktop/Ldim_LncRNA
less all_inds.gtf|perl -alne 'unless (/Ldim_g28013.t1|Ldim_g1829.t1|Ldim_g5019.t1|Ldim_g309.t2|Ldim_g19182.t1/){print}' >Ldim_all_inds_remove.gtf
~/software/gffread/gffread -w Ldim_all_inds_remove.fa -g Cleaner_wrasse_softmasked_ChaHeader.fasta Ldim_all_inds_remove.gtf
cp ~/Desktop/LncRNA/zebrafish_model ./
cpat.py -g Ldim_all_inds_remove.fa -d zebrafish_model/Zebrafish_logitModel.RData -x zebrafish_model/zebrafish_Hexamer.tsv -o Ldim_all_inds_remove
less Ldim_all_inds_remove|perl -alne 'next if /^mRNA_size/; print uc($F[0]) if $F[-1]<=0.38' >Ldim_CPAT.txt
# 17541 potential LncRNA transcripts
```

### 3.3 CPC
```bash
# change phtyhon version to /usr/bin/python3.6
# Kang@fishlab3 Tue Feb 22 15:37:33 ~/software/CPC2_standalone-1.0.1
alias python='/usr/bin/python3.6'
sudo apt-get install python3-pip
python3.6 -m pip install biopython
# change the first line "#!/usr/bin/env python" in bin/CPC2.py to "#!/usr/bin/env python3.6"
~/software/CPC2_standalone-1.0.1/bin/CPC2.py -i Ldim_all_inds_remove.fa
# Kang@fishlab3 Tue Feb 22 15:54:35 ~/Desktop/Ldim_LncRNA
less cpc2output.txt.txt|perl -alne 'print uc($F[0]) if $F[-1] eq "noncoding"' >Ldim_CPC.txt
# 23028 potential LncRNA transcripts
```

## 4. Common LncRNA transcripts predicted by three tools (FEELnc, CPAT, CPC)
```bash
# Kang@fishlab3 Tue Feb 22 16:30:41 ~/Desktop/Ldim_LncRNA
# Three_common_LncRNA.txt # 6287 common LncRNA transcripts
# Kang@fishlab3 Tue Feb 22 16:35:33 ~/Desktop/Ldim_LncRNA
less Three_common_LncRNA.txt|perl -alne 's/\.\d+$//;print'|sort -u|wc -l
# 3074 LncRNA genes
####################
# all of the transcripts in the gene should be non-coding

# CPAT
# Kang@fishlab3 Tue Feb 22 17:04:56 ~/Desktop/Ldim_LncRNA
cp ~/Desktop/LncRNA/temp5.pl cpat_LncGENE.pl
# Ldim_all_inds_remove; all_inds.gtf
perl cpat_LncGENE.pl Ldim_all_inds_remove all_inds.gtf
# result file: CPAT_all_trans_nc.txt (10639 LncGENEs)

# CPC
cp ~/Desktop/LncRNA/temp8.pl cpc_LncGENE.pl
# cpc2output.txt.txt; all_inds.gtf
perl cpc_LncGENE.pl cpc2output.txt.txt all_inds.gtf >CPC_all_trans_nc.txt # 9431 LncGENEs

# FEELnc
# Kang@fishlab3 Tue Feb 22 17:47:21 ~/Desktop/Ldim_LncRNA
cp ~/Desktop/LncRNA/temp7.pl FEELnc_LncGENE.pl
# Ldim.classifier.txt
perl FEELnc_LncGENE.pl >FEELnc_all_trans_nc.txt # 2825 LncGENEs
####################

####################
# LncRNA genes at least two programs
# kangjingliang@kangjingliangdeMacBook-Pro 二  2 22 20:54:23 ~/Documents/2022/Ldim_genome/LncRNA
less jVenn.csv|perl -alne 'next if /^FEELnc/;@a=split /\,/;for ($i=3;$i<@a;$i++){print $a[$i] if $a[$i]}' >LncRNA_gene_overlap_2.txt
# Kang@fishlab3 Tue Feb 22 20:54:54 ~/Desktop/Ldim_LncRNA
cp ~/Desktop/LncRNA/temp10.pl gtf_LncRNA_gene.pl
perl gtf_LncRNA_gene.pl LncRNA_gene_overlap_2.txt all_inds.gtf >LncRNA_gene_overlap_2.gtf
# classifier
FEELnc_classifier.pl --lncrna=LncRNA_gene_overlap_2.gtf --mrna=Ldim_original_remove.gtf --log=Ldim.classifier.log > Ldim_LncRNA_gene_overlap_2_classifier.txt
####################
```

## 5. filter out LncRNA genes with low expression
```bash
# (base) kang1234@celia-PowerEdge-T640 Tue Feb 22 21:30:10 ~/genome/Gene_annotation/RNA-seq/RNA-align
nohup featureCounts -a LncRNA_gene_overlap_2.gtf -o LncRNA_gene_read_nb.txt -T 24 *bam >featureCounts.process 2>&1 &
# make sure the read nb more than 10 at least 80 samples
# (base) kang1234@celia-PowerEdge-T640 Wed Feb 23 09:52:36 ~/genome/Gene_annotation/RNA-seq/RNA-align
perl filter_LncRNA_expression.pl >LncRNA_gene_read_nb_filtered.txt # 4160 LncRNA genes
# based on the classied results of Ldim_LncRNA_gene_overlap_2_classifier.txt to get all LncRNA genes without low expression
# Kang@fishlab3 Wed Feb 23 10:37:59 ~/Desktop/Ldim_LncRNA
perl filter_intergenic_LncRNA.pl Ldim_LncRNA_gene_overlap_2_classifier.txt LncRNA_gene_read_nb_filtered.txt >LncRNA_gene_read_nb_filtered_intergenic.txt
# 3543 LncRNA genes
# LncRNA genes classification
# Kang@fishlab3 Sun Feb 27 16:25:34 ~/Desktop/Ldim_LncRNA
perl final_intergenic_LncRNA_classifier.pl LncRNA_gene_read_nb_filtered_intergenic.txt Gene_annotation.final.txt Ldim_LncRNA_gene_overlap_2_classifier.txt >final_intergenic_LncRNA_classifier.txt
```

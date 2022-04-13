# DEGs detection
## Get reads nb matrix
```bash
# (base) kang1234@celia-PowerEdge-T640 Wed Jan 12 20:16:46 ~/genome/Gene_annotation/RNA-seq/RNA-align
nohup featureCounts -a ../../combined/Ldim_original_name.gtf -o gtf_read_nb.txt -T 24 LD13*bam LD14*bam LD23*bam LD24*bam LD3*bam LD4*bam LD15*bam LD16*bam LD25*bam LD26*bam LD5*bam LD6*bam >featureCounts.process 2>&1 &
# [1] 25734

# Opsin
nohup featureCounts -a Opsin_genewise.gtf -o Opsin_reads_nb.txt -T 24 LD13*bam LD14*bam LD23*bam LD24*bam LD3*bam LD4*bam LD15*bam LD16*bam LD25*bam LD26*bam LD5*bam LD6*bam >featureCounts.process 2>&1 &
# [1] 14544

# OR
nohup featureCounts -a OR_genewise.gtf -o OR_reads_nb.txt -T 24 LD13*bam LD14*bam LD23*bam LD24*bam LD3*bam LD4*bam LD15*bam LD16*bam LD25*bam LD26*bam LD5*bam LD6*bam >featureCounts.process 2>&1 &
# [1] 16814
```

## Get the matrix according to the tissue and ind order ("solo" --> "interaction")
```bash
#(base) kang1234@celia-PowerEdge-T640 Thu Jan 13 14:27:13 ~/genome/Gene_annotation/RNA-seq/RNA-align
mkdir read_matrix
mv *_nb_*.txt gtf_read_nb.txt read_matrix/

(base) kang1234@celia-PowerEdge-T640 Thu Jan 13 14:56:13 ~/genome/Gene_annotation/RNA-seq/RNA-align/read_matrix
perl Extract_ind_reads_nb.pl gtf_read_nb.txt # outputs: gtf_read_nb_FB.txt; gtf_read_nb_HB.txt; gtf_read_nb_MB.txt
perl Extract_ind_reads_nb.pl OR_reads_nb.txt
perl Extract_ind_reads_nb.pl Opsin_reads_nb.txt
```

## DEGs detection
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 四  1 13 16:16:31 ~/Documents/2021/Cleaner_wrasse/gene_expression
# set "baseMean >= 10; abs(log2FoldChange)>=0.3; padj <= 0.05"
# FB: 2735 DEGs
DESeq --matrix gtf_read_nb_FB.txt --samples coldata_FB.txt --column Group --prefix gtf_FB

# MB: 512 DEGs
DESeq --matrix gtf_read_nb_MB.txt --samples coldata_MB.txt --column Group --prefix gtf_MB

# HB: 1582 DEGs
DESeq --matrix gtf_read_nb_HB.txt --samples coldata_HB.txt --column Group --prefix gtf_HB

### OR
# FB: 0
DESeq --matrix OR_reads_nb_FB.txt --samples coldata_FB.txt --column Group --prefix OR_FB
# MB: 0
DESeq --matrix OR_reads_nb_MB.txt --samples coldata_MB.txt --column Group --prefix OR_MB
# HB: 0
DESeq --matrix OR_reads_nb_HB.txt --samples coldata_HB.txt --column Group --prefix OR_HB

### Opsin
# FB: 0
DESeq --matrix Opsin_reads_nb_FB.txt --samples coldata_FB.txt --column Group --prefix Opsin_FB
# MB: 0
DESeq --matrix Opsin_reads_nb_MB.txt --samples coldata_MB.txt --column Group --prefix Opsin_MB
# HB: 0
DESeq --matrix Opsin_reads_nb_HB.txt --samples coldata_HB.txt --column Group --prefix Opsin_HB
```

## Get the annotation of DEGs and Connect the DEGs and gene family id
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 四  1 13 23:38:53 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl DEGs_in_Fm.pl gtf_FB_Interaction_Solo.DEGs.txt >FB_DEGs_in_Fm.txt # 2092 Fms have DEGs
perl DEGs_in_Fm.pl gtf_MB_Interaction_Solo.DEGs.txt >MB_DEGs_in_Fm.txt # 435 Fms have DEGs
perl DEGs_in_Fm.pl gtf_HB_Interaction_Solo.DEGs.txt >HB_DEGs_in_Fm.txt # 1268 Fms have DEGs
```
***
## Get the reads nb matrix of all inds
```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Feb 14 22:25:30 ~/genome/Gene_annotation/RNA-seq/RNA-align/read_matrix
nohup featureCounts -a ../../combined/Ldim_original_name.gtf -o all_inds_read_nb.txt -T 24 *bam >featureCounts.process 2>&1 &
mv all_inds_read_nb.txt read_matrix/
cd read_matrix/
perl Extract_ind_reads_nb_2.pl all_inds_read_nb.txt # outputs: all_inds_read_nb_FB.txt; all_inds_read_nb_HB.txt; all_inds_read_nb_MB.txt
```
***
## Get the DEGs at least one tissue
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 二  3 01 11:58:05 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl DEGs_Interaction_Solo.pl >DEGs_Interaction_Solo.txt
# add the gene family information: extraction or contraction; positive selection or not
perl DEGs_Interaction_Solo_Fm_info.pl >DEGs_Interaction_Solo_Fm_info.txt
# add DE LncRNA info
perl DEGs_Interaction_Solo_Fm_info_LncRNA.pl >DEGs_Interaction_Solo_Fm_info_LncRNA.txt
# add DEGs regulation info
perl DEGs_Interaction_Solo_Fm_info_LncRNA_regulation.pl >DEGs_Interaction_Solo_Fm_info_LncRNA_regulation.txt

###########
# connect gene family and sub-orthogroup
# kangjingliang@kangjingliangdeMacBook-Pro 三  4 13 16:14:11 ~/Documents/2021/Cleaner_wrasse/gene_expression
scp kang1234@147.8.76.155:~/genome/paml_input/final_orth.txt ./
# check if all the genes in the same sub-orthogroup were in the same gene family
vi Positive_sub_orth.txt # put in the sub-orth id that were detected with PSGs in Ldim
# just keep the sub-orth that all gene inside were in the same gene family
# kangjingliang@kangjingliangdeMacBook-Pro 三  4 13 17:08:51 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl connect_fm_suborth.pl >Positive_sub_orth_fm.txt # keep the corresponding gene fm id
perl DEGs_Interaction_Solo_Fm_info_2.pl >DEGs_Interaction_Solo_Fm_info_2.txt
perl DEGs_Interaction_Solo_Fm_info_LncRNA_2.pl >DEGs_Interaction_Solo_Fm_info_LncRNA_2.txt
perl DEGs_Interaction_Solo_Fm_info_LncRNA_regulation_2.pl >DEGs_Interaction_Solo_Fm_info_LncRNA_regulation_2.txt
```
***
## Estimate the TPM per gene
based on gtf_read_nb.txt in ~/genome/Gene_annotation/RNA-seq/RNA-align/read_matrix    
```R
# (base) kang1234@celia-PowerEdge-T640 Wed Apr 06 13:13:30 ~/genome/Gene_annotation/RNA-seq/RNA-align/read_matrix
R
countdata<-read.table("gtf_read_nb.txt",skip = 1,sep="\t",header = T,row.names = 1)
metadata <- countdata[,1:5]
countdata <- countdata[,6:ncol(countdata)]
prefix<-"gtf_read_nb"
kb <- metadata$Length / 1000
rpk <- countdata / kb
tpm <- t(t(rpk)/colSums(rpk) * 1000000)
write.csv(tpm,paste0(prefix,"_tpm.csv"))
q()
```
Result file: gtf_read_nb_tpm.csv    
transform csv to txt seprated by tab    
```bash
# (base) kang1234@celia-PowerEdge-T640 Wed Apr 06 13:44:40 ~/genome/Gene_annotation/RNA-seq/RNA-align/read_matrix
less gtf_read_nb_tpm.csv|perl -alne 's/\.sorted\.bam//g;s/"//g;s/\,/\t/g;print'|perl -alne 'if (/^\s+/){s/^\s+/Geneid\t/;print}else{print}' >gtf_read_nb_tpm.txt
perl Extract_ind_reads_nb_3.pl gtf_read_nb_tpm.txt
```
**Results file**: gtf_read_nb_tpm_FB.txt; gtf_read_nb_tpm_HB.txt; gtf_read_nb_tpm_MB.txt      

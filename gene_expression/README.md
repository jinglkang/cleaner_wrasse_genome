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
# set "baseMean >= 10; abs(log2FoldChange)>=1; padj <= 0.05"
# FB: 543 DEGs
DESeq --matrix gtf_read_nb_FB.txt --samples coldata_FB.txt --column Group --prefix gtf_FB

# MB: 63 DEGs
DESeq --matrix gtf_read_nb_MB.txt --samples coldata_MB.txt --column Group --prefix gtf_MB

# HB: 937 DEGs
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
perl DEGs_in_Fm.pl gtf_FB_Interaction_Solo.DEGs.txt >FB_DEGs_in_Fm.txt # 381 Fms have DEGs
perl DEGs_in_Fm.pl gtf_MB_Interaction_Solo.DEGs.txt >MB_DEGs_in_Fm.txt # 47 Fms have DEGs
perl DEGs_in_Fm.pl gtf_HB_Interaction_Solo.DEGs.txt >HB_DEGs_in_Fm.txt # 725 Fms have DEGs
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
```

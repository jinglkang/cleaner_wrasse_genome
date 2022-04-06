# Functional Enrichment analysis
## Gene family
Extract a gene from each gene family  
```bash
# Kang@fishlab3 Tue Mar 22 15:12:55 /media/HDD/cleaner_fish/genome/gene_family_2/reports_2
# expasion_fm_Ldim.txt; contraction_fm_Ldim.txt
perl extract_gene_fm.pl expasion_fm_Ldim.txt > expasion_fm_one_gene_Ldim.txt
perl extract_gene_fm.pl contraction_fm_Ldim.txt > contraction_fm_one_gene_Ldim.txt

# Estimate F-index per gene family
# Kang@fishlab3 Wed Mar 23 10:58:44 /media/HDD/cleaner_fish/genome/gene_family_2/reports_2
perl Estimate_F_index.pl >all_spe_F_index.txt
perl Estimate_F_index_plot.pl >all_spe_F_index_plot.txt

# positive
# Kang@fishlab3 Tue Mar 22 16:21:32 /media/HDD/cleaner_fish/genome/gene_family_2/paml_input
perl extract_pos_Ldim_gene.pl >pos_Ldim_gene.txt

# overlapped gene fm between contraction gene fm in Ldim and expasion gene fm in Tbif
# kangjingliang@kangjingliangdeMacBook-Pro 一  3 28 20:26:56 ~/Documents/2022/Ldim_genome/Enrichment
less overlap_fm_enrichment_no_filter.txt|grep -i 'behav'|grep -i '\[OVER\]'|perl -alne '@a=split /\t/;print "$a[2]\t$a[4]" if $a[4]<=0.05'|wc -l
# 18 GO functions related to behavior
```
## gene expression changes for the genes in the contraction gene family of Ldim
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 日  3 27 16:28:58 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl fm_regulation.pl contraction_fm_one_gene_Ldim.txt > contraction_fm_regulation.txt
# kangjingliang@kangjingliangdeMacBook-Pro 日  3 27 22:39:52 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl fm_regulation.pl expasion_fm_one_gene_Ldim.txt|grep -i 'yes'
# In the expasion gene family, only three DEGs
# Family_483	Ldim_g13605	0.340317467064697	Yes	FB
# Family_1168	Ldim_g13792	-2.83381244667021	Yes	HB
# Family_1588	Ldim_g20501	-2.95372635859654	Yes	HB

# kangjingliang@kangjingliangdeMacBook-Pro 日  3 27 23:48:05 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl DEGs_regulation.pl
# 		Up	Down
# FB	968	1767
# HB	475	1107
# MB	202	310

# The genes in gene family are DEGs
# kangjingliang@kangjingliangdeMacBook-Pro 日  4 03 15:42:25 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl DEGs_fm_regulation.pl >DEGs_point_plot.txt
# add reads nb information
# kangjingliang@kangjingliangdeMacBook-Pro 三  4 06 10:56:22 ~/Documents/2021/Cleaner_wrasse/gene_expression
perl DEGs_fm_regulation_read_nb.pl >DEGs_point_reads_nb_plot.txt
perl DEGs_fm_regulation_read_nb_2.pl >DEGs_point_reads_nb_plot_2.txt
```

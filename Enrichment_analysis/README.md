# Functional Enrichment analysis
## Gene family
Extract a gene from each gene family  
```bash
# Kang@fishlab3 Tue Mar 22 15:12:55 /media/HDD/cleaner_fish/genome/gene_family_2/reports_2
# expasion_fm_Ldim.txt; contraction_fm_Ldim.txt
perl extract_gene_fm.pl expasion_fm_Ldim.txt > expasion_fm_one_gene_Ldim.txt
perl extract_gene_fm.pl contraction_fm_Ldim.txt > contraction_fm_one_gene_Ldim.txt

# the overlapped gene families between contracted gene families in Ldim and expasion gene families in Tbif 
perl extract_gene_fm.pl overlapped_con_Ldim_exp_Tbif_fm.txt >overlapped_con_Ldim_exp_Tbif_fm_one_gene.txt

# positive
# Kang@fishlab3 Tue Mar 22 16:21:32 /media/HDD/cleaner_fish/genome/gene_family_2/paml_input
perl extract_pos_Ldim_gene.pl >pos_Ldim_gene.txt
```

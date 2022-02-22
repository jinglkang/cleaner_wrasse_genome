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
less Ldim.codpot.lncRNA.gtf|perl -alne '($tr)=$_=~/transcript_id \"(.*?)\"/;print $tr'|sort -u|wc -l
# 8001 potential LncRNA transcripts

# CPAT
# Kang@fishlab3 Tue Feb 22 15:16:15 ~/Desktop/Ldim_LncRNA
less all_inds.gtf|perl -alne 'unless (/Ldim_g28013.t1|Ldim_g1829.t1|Ldim_g5019.t1|Ldim_g309.t2|Ldim_g19182.t1/){print}' >Ldim_all_inds_remove.gtf
~/software/gffread/gffread -w Ldim_all_inds_remove.fa -g Cleaner_wrasse_softmasked_ChaHeader.fasta Ldim_all_inds_remove.gtf
cp ~/Desktop/LncRNA/zebrafish_model ./
cpat.py -g Ldim_all_inds_remove.fa -d zebrafish_model/Zebrafish_logitModel.RData -x zebrafish_model/zebrafish_Hexamer.tsv -o Ldim_all_inds_remove
less Ldim_all_inds_remove|perl -alne 'print if $F[-1]<=0.38'|wc -l
# 17541 potential LncRNA transcripts

# CPC
# change phtyhon version to /usr/bin/python3.6
# Kang@fishlab3 Tue Feb 22 15:37:33 ~/software/CPC2_standalone-1.0.1
alias python='/usr/bin/python3.6'
sudo apt-get install python3-pip
python3.6 -m pip install biopython
# change the first line "#!/usr/bin/env python" in bin/CPC2.py to "#!/usr/bin/env python3.6"
~/software/CPC2_standalone-1.0.1/bin/CPC2.py -i Ldim_all_inds_remove.fa
# Kang@fishlab3 Tue Feb 22 15:54:35 ~/Desktop/Ldim_LncRNA
less cpc2output.txt.txt|perl -alne 'print if $F[-1] eq "noncoding"'|wc -l
# 23028 potential LncRNA transcripts
```

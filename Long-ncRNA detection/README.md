# Long non-coding RNA annotation
## 1. HISAT2 for mapping: finish
## 2. Stringtie to assemble transcripts
```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Feb 21 13:56:23 ~/genome/Gene_annotation/RNA-seq/RNA-align
mkdir LncRNA_detection; cd LncRNA_detection
cp ~/genome/Gene_annotation/combined/braker2+3_combined_renamed.gtf ./
perl run_stringtie.pl --bams ../ --ref_gtf braker2+3_combined_renamed.gtf --output all_inds.gtf
```

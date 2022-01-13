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

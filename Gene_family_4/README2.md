## Filtering genes with align ratio more than 70%
Get the input gene id   
```perl
# kang1234@celia-PowerEdge-T640 ~/genome/Gene_annotation/Thalassoma_bifasciatum/temp1.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $swis="/home/kang1234/swiss-prot/swiss_pro_info.txt";
my %swis;
open SWIS, $swis or die "can not open $swis\n$!\n";
while (<SWIS>) {
        chomp;
        my @a=split /\t/;
        $swis{$a[0]}=$a[-1];
}

my $blas=$ARGV[0];
open BLA, $blas or die "can not open $blas\n$!\n";
while (<BLA>) {
        chomp;
        my @a=split /\t/;
        (my $id)=$a[1]=~/sp\|(.*?)\|.*/;
        (my $len)=$swis{$id};
        my $aln=$a[3]/$len;
        $aln=sprintf("%.2f",$aln);
        print "$_\t$aln\n";
}
```

```bash
# length >= 50 && map ratio >=0.3
# (base) kang1234@celia-PowerEdge-T640 Mon Aug 01 11:07:51 ~/genome/Gene_annotation
perl Thalassoma_bifasciatum/temp1.pl Tautogolabrus_adspersus/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Thalassoma_bifasciatum/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Symphodus_melops/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Semicossyphus_pulcher/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Notolabrus_celidotus/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Labrus_bergylta/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl Cheilinus_undulatus/swis-blastp.result|perl -alne '($nm)=$F[0]=~/(.*)\..*/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl combined/Ldim_blastp.result.best.txt|perl -alne '($nm)=$F[0]=~/(.*)t\d+/;print $nm if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
perl Thalassoma_bifasciatum/temp1.pl ref-swis-blastp.uniq.result|perl -alne 'print $F[0] if $F[-1]>=0.3 && $F[3]>=50' >>genes_input_cafe.txt
```

```temp5.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $gene="genes_input_cafe.txt";
my %hash;
open GENE, $gene or die "can not open $gene\n$!\n";
while (<GENE>) {
	chomp;
	$hash{$_}++;
}

my $dump="dump.blast_output.mci.I30.fmid";
open DUMP, $dump or die "can not open $dump\n$!\n";
while (<DUMP>) {
	chomp;
	my @a=split;
	my $info=$a[0];
	my $info1;
	for (my $i = 1; $i < @a; $i++) {
		$info1.=$a[$i]."\t" if $hash{$a[$i]};
	}
	$info1=~s/\s+$// if $info1;
	print "$info1\n" if $info1;
}
```

```bash
# Kang@fishlab3 Wed Aug 03 09:49:25 /media/HDD/cleaner_fish/genome/gene_family_4
scp kang1234@147.8.76.177:~/genome/Gene_annotation/genes_input_cafe.txt ./
# Kang@fishlab3 Mon Aug 01 14:39:55 /media/HDD/cleaner_fish/genome/gene_family_4
perl temp5.pl >dump.blast_output.mci.I30.algn30
python mcl2rawcafe.py -i dump.blast_output.mci.I30.algn30 -o unfiltered_cafe_input_algn30.txt -sp "Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish Spul Cund Lber Tads Smel Ncel Tbif Ldim"
python cafetutorial_clade_and_size_filter.py -i unfiltered_cafe_input_algn30.txt -o filtered_cafe_input_algn30.txt -s
less filtered_cafe_input_algn30.txt|perl -alne 'if (/Desc/){print}else{my @a;my $i;for ($i = 2; $i <= 7; $i++){push @a, $F[$i] if $F[$i]>=1};my $info; for ($i = 2; $i <= @F; $i++){$info.=$F[$i]."\t"};$info=~s/\s+$//;$b=(sprintf "%05d", $F[1]);print"$F[0]\tFamily$b\t$info" if @a>=4}' >final_cafe_input_algn30.txt
# 12355 gene families
scp final_cafe_input_algn30.txt kang1234@147.8.76.177:~/genome/gene_family
mkdir reports_fm4_2
```

```run1_fm4_2.sh
#! cafe
load -i final_cafe_input_algn30.txt -t 20 -l reports_fm4_2/log_run1.txt -p 0.01 -r 10000
tree ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000):94.757281,Spottedgar:251.287281)
lambda -s -t ((((((((((1,1)1,1)1,1)1,((1,1)1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_fm4_2/report_run1
```

```bash
# (base) kang1234@celia-PowerEdge-T640 Mon Aug 01 15:39:25 ~/genome/gene_family
cafe run1_fm4_2.sh
python2 report_analysis.py -i reports_fm4_2/report_run1.cafe -o reports_fm4_2/summary_run1
```

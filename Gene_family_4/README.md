# Gene family detection: forth
## 1.1 prepare the matrix for CAFE   
```bash
# Kang@fishlab3 Sat Jun 04 16:37:08 /media/HDD/cleaner_fish/genome
mkdir gene_family_4; cd gene_family_4
cat /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/*.fasta >makeblastdb_input.fa
diamond makedb --in makeblastdb_input.fa -d blastdb
diamond blastp -q makeblastdb_input.fa -e 1e-5 --sensitive -d ./blastdb --out blast_output.txt
cut -f 1,2,11 blast_output.txt > blast_output.abc
mcxload -abc blast_output.abc --stream-mirror --stream-neg-log10 -stream-tf 'ceil(200)' -o blast_output.mci -write-tab blast_output.tab
mcl blast_output.mci -I 3
python mcl2rawcafe.py -i dump.blast_output.mci.I30 -o unfiltered_cafe_input.txt -sp "Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish Spul Cund Lber Tads Smel Ncel Tbif Ldim"

python cafetutorial_clade_and_size_filter.py -i unfiltered_cafe_input.txt -o filtered_cafe_input.txt -s
# Created two files: filtered cafe input.txt and large filtered cafe input.txt (>=100 gene copies)

# Obtain conserved gene family: exist among four reference species
less filtered_cafe_input.txt|perl -alne 'if (/Desc/){print}else{my @a;my $i;for ($i = 2; $i <= 7; $i++){push @a, $F[$i] if $F[$i]>=1};my $info; for ($i = 2; $i <= @F; $i++){$info.=$F[$i]."\t"};$info=~s/\s+$//;$b=(sprintf "%05d", $F[1]);print"$F[0]\tFamily$b\t$info" if @a>=4}' >final_cafe_input.txt
# 13345 gene families

# add gene family id
less dump.blast_output.mci.I30|perl -alne '$i++;$b=(sprintf "%05d", $i);print "Family$b\t$_"' >dump.blast_output.mci.I30.fmid

# large gene families
less large_filtered_cafe_input.txt|perl -alne 'if (/Desc/){print}else{my @a;my $i;for ($i = 2; $i <= 7; $i++){push @a, $F[$i] if $F[$i]>=1};my $info; for ($i = 2; $i <= @F; $i++){$info.=$F[$i]."\t"};$info=~s/\s+$//;$b=(sprintf "%05d", $F[1]);print"$F[0]\tFamily$b\t$info" if @a>=4}' >final_cafe_input_large.txt
```

## 1.2 run CAFE   
### 1.2.1 First time (for gene families with gene copies less than 100)   
```bash
# Kang@fishlab3 Sat Jun 04 21:06:30 /media/HDD/cleaner_fish/genome/gene_family_4
scp final_cafe_input.txt kang1234@147.8.76.177:~/genome/gene_family
# (base) kang1234@celia-PowerEdge-T640 Sat Jun 04 21:04:23 ~/genome/gene_family
mkdir reports_fm4
```

```run1_fm4.sh
#! cafe
load -i final_cafe_input.txt -t 20 -l reports_fm4/log_run1.txt -p 0.01 -r 10000
tree ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000):94.757281,Spottedgar:251.287281)
lambda -s -t ((((((((((1,1)1,1)1,1)1,((1,1)1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_fm4/report_run1
```

```bash
cafe run1_fm4.sh
python2 report_analysis.py -i reports_fm4/report_run1.cafe -o reports_fm4/summary_run1
# Plot the result: Rapid, Expansions, Contractions
python2 draw_tree.py -i reports_fm4/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_fm4/summary_run1_tree_rapid.png -y Rapid
python2 draw_tree.py -i reports_fm4/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_fm4/summary_run1_tree_Expansions.png -y Expansions
python2 draw_tree.py -i reports_fm4/summary_run1_node.txt -t '((((((((((Smel:12.2072,Tads:12.2072):4.22034,Lber:16.4275):16.1782,Cund:32.6058):3.79076,((Ldim:14.9751,Tbif:14.9751):11.654,Ncel:26.6291):9.76749):3.8225,Spul:40.219):26.5421,Stickleback:66.7612):7.42002,Fugu:74.1812):5.87774,(Platyfish:68.5231,Medaka:68.5231):11.5359):76.4711,Zebrafish:156.53):94.7573,Spottedgar:251.287)' -d '((((((((((Smel<0>,Tads<2>)<1>,Lber<4>)<3>,Cund<6>)<5>,((Ldim<8>,Tbif<10>)<9>,Ncel<12>)<11>)<7>,Spul<14>)<13>,Stickleback<16>)<15>,Fugu<18>)<17>,(Platyfish<20>,Medaka<22>)<21>)<19>,Zebrafish<24>)<23>,Spottedgar<26>)<25>' -o reports_fm4/summary_run1_tree_Contractions.png -y Contractions
```

### 1.2.2 Second time (for large gene families)   
Setting λ (0.00237430542557) to a previously estimated value to deal with families with large numbers of gene copies    
λ: 0.00237430542557   
```run2_fm4.sh
#! cafe
load -i final_cafe_input_large.txt -t 20 -l reports_fm4/log_run2.txt -p 0.01 -r 10000
tree ((((((((((Smel:12.207213,Tads:12.207213):4.220335,Lber:16.427548):16.178243,Cund:32.605791):3.790756,((Ldim:14.975052,Tbif:14.975052):11.654002,Ncel:26.629053):9.767494):3.822500,Spul:40.219047):26.542146,Stickleback:66.761193):7.420018,Fugu:74.181211):5.877738,(Platyfish:68.523066,Medaka:68.523066):11.535883):76.471051,Zebrafish:156.530000):94.757281,Spottedgar:251.287281)
lambda -l 0.00237430542557 -t ((((((((((1,1)1,1)1,1)1,((1,1)1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_fm4/report_run2
```

```bash
cafe run2_fm4.sh
# analyse CAFE results
python2 report_analysis.py -i reports_fm4/report_run2.cafe -o reports_fm4/summary_run2
```

### Assign the name to each gene family
Name of all genes in Zebrafish gene family will be used as the name of gene family (otherwise, the name would be "-\t-")   
```fm_ano.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $zeb="Zebrafish_gene.txt";
my %ano;
open ZEB, $zeb or die "can not open $zeb\n";
while (<ZEB>) {
        chomp;
        next if /^Gene/;
        s/\s+\[.*\]$//;
        my @a=split /\t/;
        my $name="Zebrafish_$a[0]";
        my ($name1, $des);
        $a[1]?($name1=$a[1]):($name1="-");
        $a[2]?($des=$a[2]):($des="-");
        $ano{$name}=$name1."(".$des.")";
}

my @spes=qw(Fugu Medaka Platyfish Spottedgar Stickleback Zebrafish Spul Cund Lber Tads Smel Ncel Tbif Ldim);
my $header="Family_id\t";
foreach my $spe (@spes) {
        $header.=$spe."\t";
}
$header.="gene_info";
print "$header\n";

my $list="dump.blast_output.mci.I30.fmid";
open LIST, $list or die "can not open $list";
while (<LIST>) {
        chomp;
        my @a=split;
        my $fm_id=$a[0];
        my (%nb, %ano1, %hash);
        for (my $i = 1; $i < @a; $i++) {
                (my $spe)=$a[$i]=~/(.*)\_/;
                $nb{$spe}++;
                if ($spe eq "Zebrafish" && $ano{$a[$i]}) {
                        my $fm_name=$ano{$a[$i]};
                        $hash{$fm_name}++;
                        $ano1{$fm_id}.=$fm_name.";" if $hash{$fm_name}==1;
                }
        }

        my $info=$fm_id."\t";
        foreach my $spe (@spes) {
                my $nmb;
                $nb{$spe}?($nmb=$nb{$spe}):($nmb=0);
                $info.=$nmb."\t";
        }

        my $final_nm;
        if ($ano1{$fm_id}) {
                $ano1{$fm_id}=~s/\;$//;
                $final_nm=$ano1{$fm_id};
        } else {
                $final_nm="-";
        }
        $info.=$final_nm;
        print "$info\n";
}
```

```bash
# Kang@fishlab3 Mon Jun 13 11:57:16 /media/HDD/cleaner_fish/genome/gene_family_4
perl fm_ano.pl >dump.blast_output.mci.I30.fmid.matrix.ano
```
### Extract the sig. extracted or contracted gene families for each species   
```bash
# Kang@fishlab3 Mon Jun 13 13:14:46 /media/HDD/cleaner_fish/genome/gene_family_4
scp dump.blast_output.mci.I30.fmid.matrix.ano kang1234@147.8.76.177:~/genome/gene_family/reports_fm4
```

```extract_sig_fm.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my %family1;
my $fam="dump.blast_output.mci.I30.fmid.matrix.ano";
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        my @a=split /\t/;
        next if /^Family_id/i;
        my ($info, $ano);
        for (my $i = 1; $i < @a-1; $i++) {
                $info.=$a[$i]."\t";
        }
        $info=~s/\s+$//;
        $ano=$a[-1];
        $family1{$a[0]}={
                'INFO'=>$info,
                'ANO' =>$ano
        };
}

my %family2;
my $final="final_cafe_input.txt";
open FINAL, $final or die "There is no $final\n";
while (<FINAL>) {
        chomp;
        next if /^Desc/;
        my @a=split;
        my $info;
        for (my $i = 2; $i < @a; $i++) {
                $info.=$a[$i]."\t";
        }
        $info=~s/\s+$//;
        $family2{$a[1]}=$info;
}

# sig. expansion and contraction gene family: /media/HDD/cleaner_fish/genome/gene_family_2/reports_2/summary_run2_fams.txt
my $sig_fm="summary_run1_fams.txt";
open SIG, "$sig_fm" or die "There is no $sig_fm\n";
while (<SIG>) {
        chomp;
        next if /^#|^Overall|^\</;
        my @a=split;
        (my $spe)=$a[0]=~/(\D+)\</;
        my $file=$spe.".sig.fm.txt";
        my $header_new="Family_id\tFugu\tMedaka\tPlatyfish\tSpottedgar\tStickleback\tZebrafish\tSpul\tCund\tLber\tTads\tSmel\tNcel\tTbif\tLdim\tgene_info\n";
        open SPE, ">$file" or die "can not create $file\n";
        print SPE "$header_new";
        my @b=split /\,/, $a[1];
        for (my $i = 0; $i < @b; $i++) {
                if ($b[$i]=~/(.*)\[(\+|\-)(\d+)\*\]/){
                        my ($id, $flag, $change)=($1, $2, $3);
                        my $ano=$family1{$id}->{'ANO'};
                        my ($mt1,$mt2);
                        $mt1=$family1{$id}->{'INFO'};
                        $mt2=$family2{$id};
                        if ($flag eq "+" && ($mt1 eq $mt2)) {
                                my $wd="expansion";
                                print SPE "$id\t$mt1\t$ano\t$wd\t+$change\n";
                        } elsif ($flag eq "-" && ($mt1 eq $mt2)) {
                                my $wd="contraction";
                                print SPE "$id\t$mt1\t$ano\t$wd\t-$change\n";
                        }
                }
        }
        close SPE;
}
```

```bash
perl extract_sig_fm.pl
```
### Focus on the result of "run1"
### Compare between Cleaner vs. Non-Cleaner
Three parameters in extract_fmsize_var.pl: 1. the first species; 2. the second species; 3. the reference node   
```extract_fmsize_var.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $fm_nb="summary_run1_anc.txt";
my $target1=$ARGV[0];
my $target2=$ARGV[1];
my $ref    =$ARGV[2];

my $ano="dump.blast_output.mci.I30.fmid.matrix.ano";
my %ANO;
open ANN, $ano or die "can not open $ano\n";
while (<ANN>) {
        chomp;
        next if /^Family_id/;
        my @a=split /\t/;
        $ANO{$a[0]}=$a[-1];
}

print "Fm_id\tRef$ref\t$target1\t$target2\t$target1\_Size_Var\t$target1\_Size_Change\t$target2\_Size_Var\t$target2\_Size_Change\tGene_info\n";
open NB, $fm_nb or die "can not open $fm_nb\n";
my %hash;
while (<NB>) {
        chomp;
        s/\<//g;
        s/\>//g;
        my @a=split /\t/;
        if (/ID/) {
                for (my $i = 1; $i < @a; $i++) {
                        $hash{$a[$i]}=$i;
                }
        } else {
                my $target1_nb=$a[$hash{$target1}];
                my $target2_nb=$a[$hash{$target2}];
                my $ref_nb    =$a[$hash{$ref}];
                my $change1=$target1_nb-$ref_nb;
                my $change2=$target2_nb-$ref_nb;
                my ($info1, $info2);
                ($change1 > 0)?($info1="Expasion\t+$change1"):($change1 < 0)?($info1="Contraction\t$change1"):($info1="Non\t$change1");
                ($change2 > 0)?($info2="Expasion\t+$change2"):($change2 < 0)?($info2="Contraction\t$change2"):($info2="Non\t$change2");
                print "$a[0]\t$ref_nb\t$target1_nb\t$target2_nb\t$info1\t$info2\t$ANO{$a[0]}\n";
        }
}
```
```bash
# (base) kang1234@celia-PowerEdge-T640 Tue Jun 14 10:33:55 ~/genome/gene_family/reports_fm4
perl extract_fmsize_var.pl Ldim8 Ncel12 11 >Clean_vs_NonClean_Ldim_Ncel.txt
perl extract_fmsize_var.pl Smel0 Cund6 5 >Clean_vs_NonClean_Smel_Cund.txt
```
**Get the gene familly information**   
```fm_ano.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $gene=$ARGV[0];
my $ano="dump.blast_output.mci.I30.fmid.matrix.ano";
my %ANO;
open ANN, $ano or die "can not open $ano\n";
while (<ANN>) {
        chomp;
        next if /^Family_id/;
        my @a=split /\t/;
        $ANO{$a[0]}=$a[-1];
}

open GENE, $gene or die "can not open $gene\n";
while (<GENE>) {
        chomp;
        print "$_\t$ANO{$_}\n";
}
```

## Gene family detection
**Download Zebrafish from Ensembl**   
```bash
# http://ftp.ensembl.org/pub/release-106/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa.gz
wget http://ftp.ensembl.org/pub/release-106/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa.gz
```

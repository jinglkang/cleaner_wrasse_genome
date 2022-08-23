# Gene Family (5)
## 1. Orthofinder
**There are 8 Labridae species with a genome assembly**   
**Tbif, Lber and Smel have a bad genome aseembly, espeacily Tbif**   
**This time, i will only select the 5 Labridae species with a chromosome level genome**   
### 1.1 Remove the sequences with length <= 50 && Remove the gap ('-'), period ('.'), asterix ('\*'), underscore ('\_')   
```filter_genes.pl
#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my @fas=</media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/*.fasta>;
foreach my $fas (@fas) {
	my ($fasta)=basename($fas);
#	my ($spe)  =$fasta=~/(.*)\.fasta/;
	open FASTA, $fas or die "can not open $fas\n";
	my %seq; my $gene; my @genes;
	while (<FASTA>) {
		chomp;
		if (/>/) {
			s/>//;
			$gene=$_;
			push @genes, $gene;
		} else {
			$seq{$gene}.=$_;
		}
	}
	close FASTA;

	open FILE, ">$fasta" or die "can not create $fasta\n";
#	my ($i, $j);
	foreach my $gene (@genes) {
#		$i++;
		my $len=length($seq{$gene});
		if ($len>=50) {
			$seq{$gene}=~s/\_//g;
			$seq{$gene}=~s/\.//g;
			$seq{$gene}=~s/\*//g;
			$seq{$gene}=~s/\-//g;
#			$j++;
			print FILE ">$gene\n$seq{$gene}\n";
		}
	}
#	print "$spe\t$i\t$j\n";

	close FILE;
}
```
## 2. Filter the count matrix
```Extract_conserved_gmfm.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $header="Family_id\tOrthogroup_id\t";
my @spes=qw(Spottedgar Zebrafish Medaka Platyfish Fugu Stickleback Semicossyphus_pulcher Cheilinus_undulatus Tautogolabrus_adspersus Notolabrus_celidotus Labroides_dimidiatus);
foreach my $spe (@spes) {
	$header.=$spe."\t";
}
$header=~s/\s+$//;

my @refs=qw(Spottedgar Zebrafish Medaka Platyfish Fugu Stickleback);

my $orthog="Orthogroups.GeneCount.tsv";
my (@heads, @orths);
my %nb;
open ORTH, $orthog or die "can not open $orthog\n$!\n";
while (<ORTH>) {
	chomp;
	my @a=split;
	if (/^Orthogroup/) {
		@heads=@a;
	} else {
		push @orths, $a[0];
		for (my $i = 1; $i < @a-1; $i++) {
			$nb{$heads[$i]}->{$a[0]}=$a[$i];
		}
	}
}

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

my $list="Orthogroups.tsv";
my %ano1;
open LIST, $list or die "can not open $list";
while (<LIST>) {
	next if /^Orthogroup/;
	chomp;
	s/\,//g;
    my @a=split;
    my $fm_id=$a[0];
    my (%nb1, %hash);
    for (my $i = 1; $i < @a; $i++) {
    	(my $spe)=$a[$i]=~/(.*)\_/;
        $nb1{$spe}++;
        if ($spe eq "Zebrafish" && $ano{$a[$i]}) {
        	my $fm_name=$ano{$a[$i]};
            $hash{$fm_name}++;
            $ano1{$fm_id}.=$fm_name.";" if $hash{$fm_name}==1;
        }
    }
    $ano1{$fm_id}=~s/\;$// if $ano1{$fm_id};
}

my $fmnb_ano="fm_nb_ano.txt";
my $fmnb    ="fm_nb.txt";
open FMNB_ANO, ">$fmnb_ano" or die "can not create $fmnb_ano\n$!\n";
open FMNB,     ">$fmnb"     or die "can not create $fmnb\n$!\n";

print FMNB_ANO "$header\tGene_name(Description)\n";
print FMNB     "Desc\tFamily ID\t$header\n";

foreach my $orth (@orths) {
	(my $id)=$orth=~/OG(\d+)/;
	$id="FM".$id;
	my $nb_info;
	foreach my $spe (@spes) {
		$nb_info.=$nb{$spe}->{$orth}."\t";
	}
	$nb_info=~s/\s+$//;
	my @nbs;
	foreach my $ref (@refs) {
		my $nb=$nb{$ref}->{$orth};
		if ($nb>=1) {
			push @nbs, $nb;
		}
	}
	my $annot;
	$ano1{$orth}?($annot=$ano1{$orth}):($annot="-");
	print FMNB_ANO "$id\t$orth\t$nb_info\t$annot\n" if @nbs==6;
	print FMNB     "(null)\t$id\t$nb_info\n" if @nbs==6;
}
```

```single_copy_genes.pl
#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my @spes=qw(Spottedgar Zebrafish Medaka Platyfish Fugu Stickleback Semicossyphus_pulcher Cheilinus_undulatus Tautogolabrus_adspersus Notolabrus_celidotus Labroides_dimidiatus);
my %hash=(
	'Spottedgar' =>'Spottedgar',
	'Zebrafish'  =>'Zebrafish',
	'Medaka'     =>'Medaka',
	'Platyfish'  =>'Platyfish',
	'Fugu'       =>'Fugu',
	'Stickleback'=>'Stickleback',
	'Spul'       =>'Semicossyphus_pulcher',
	'Cund'       =>'Cheilinus_undulatus',
	'Tads'       =>'Tautogolabrus_adspersus',
	'Ncel'       =>'Notolabrus_celidotus',
	'Ldim'       =>'Labroides_dimidiatus'
	);

my @fastas=</media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Single_Copy_Orthologue_Sequences/*.fa>;
system("mkdir Single_copy_align") unless -e "Single_copy_align";
system("mkdir Single_copy_trim") unless -e "Single_copy_trim";
foreach my $fasta (@fastas) {
	my $align=basename($fasta);
	system("muscle -in $fasta -out Single_copy_align/$align");
	system("trimal -in Single_copy_align/$align -out Single_copy_trim/$align -gt 0.8 -st 0.001 -cons 60");
}

# concatenate sequences
my %seq;
my @trims=</media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Single_copy_trim/*.fa>;
foreach my $trim (@trims) {
	my $spe;
	open FIL, "$trim" or die "can not open $trim\n";
	while (<FIL>) {
		chomp;
		if (/>/) {
			s/\>//;
			(my $id)=$_=~/(.*?)\_/;
			$spe=$hash{$id};
		} else {
			$seq{$spe}.=$_;
		}
	}
}

my $con="fm_single_copy_genes.fasta";
open CON, ">$con" or die "can not open $con\n$!\n";
foreach my $spe (@spes) {
	print CON ">$spe\n$seq{$spe}\n";
}
```

```generate_single_copy_genes_list.pl
#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

my %hash=(
	'Spottedgar' =>'Spottedgar',
	'Zebrafish'  =>'Zebrafish',
	'Medaka'     =>'Medaka',
	'Platyfish'  =>'Platyfish',
	'Fugu'       =>'Fugu',
	'Stickleback'=>'Stickleback',
	'Spul'       =>'Semicossyphus_pulcher',
	'Cund'       =>'Cheilinus_undulatus',
	'Tads'       =>'Tautogolabrus_adspersus',
	'Ncel'       =>'Notolabrus_celidotus',
	'Ldim'       =>'Labroides_dimidiatus'
	);

my $seq="/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/Orthogroups.tsv";
my @heads; my %orth;
open SEQ, $seq or die "can not open $seq\n$!\n";
while (<SEQ>) {
	chomp;
	s/\s+$//;
	my @a=split /\t/;
	if (/^Orthogroup/) {
		@heads=@a;
	} else {
		for (my $i = 1; $i < @heads; $i++) {
			$orth{$heads[$i]}->{$a[0]}=$a[$i];
		}
	}
}

my @spes=qw(Zebrafish Stickleback Spottedgar Platyfish Medaka Fugu Cund Ncel Tads Spul Ldim);
my $single_list="/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/Orthogroups_SingleCopyOrthologues.txt";
open SIN, $single_list or die "can not open $single_list\n$!\n";
while (<SIN>) {
	chomp;
	my @a=split;
	my $name=$a[0];
	my $info;
	foreach my $spe (@spes) {
		my $spe_new=$hash{$spe};
		my $gene=$orth{$spe_new}->{$name};
		die "no $gene, $spe $spe_new $name\n" if ! $gene;
		$info.=$gene."\t";
	}
	$info=~s/\s+$//;
	print "$name\t$info\n";
}
```

```bash
# Ensure all six reference species with at least one gene in the orthogroups
perl Extract_conserved_gmfm.pl
# output: fm_nb_ano.txt; fm_nb.txt (as the input of CAFE)
# Kang@fishlab3 Tue Jul 12 17:14:51 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
python clade_and_size_filter.py -i fm_nb.txt -o fm_nb_filtered.txt -s
# construct a phylogenetic tree based on single copy genes
# Kang@fishlab3 Wed Jul 13 09:10:08 /media/HDD/cleaner_fish/genome/gene_family_5
cat *.fasta >all.fasta
# Kang@fishlab3 Wed Jul 13 10:06:02 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11
nohup perl single_copy_genes.pl >single_copy_genes.process 2>&1 &
# [1] 24697
# Kang@fishlab3 Wed Jul 13 10:31:27 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11
fasta2phy.pl fm_single_copy_genes.fasta >fm_single_copy_genes.phy
# scp to SNORLAX for the phylogenetic tree
scp fm_single_copy_genes.phy kang1234@147.8.76.177:~/genome/gene_family
nohup raxmlHPC -T 22 -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 100 -s fm_single_copy_genes.phy -o Spottedgar -n fm_single_copy_genes > raxml.process 2>&1 &
# [1] 24757
# fm_nb_filtered.txt as the input of cafe
# Kang@fishlab3 Sat Jul 16 20:07:02 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
scp fm_nb_filtered.txt kang1234@147.8.76.177:~/genome/gene_family
# (base) kang1234@celia-PowerEdge-T640 Sun Jul 17 13:07:55 ~/genome/gene_family
mkdir reports_fm5
# Estimate the calibrated tree
# (base) kang1234@celia-PowerEdge-T640 Sun Jul 17 13:11:37 ~/genome/gene_family
scp RAxML_bestTree.fm_single_copy_genes Kang@147.8.76.231:/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
# Kang@fishlab3 Sun Jul 17 13:15:33 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
cp /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/Orthogroups/cafetutorial_prep_r8s.py ./
# Kang@fishlab3 Sun Jul 17 13:18:20 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
python cafetutorial_prep_r8s.py -i RAxML_bestTree.fm_single_copy_genes -o r8s_ctl_file.txt -s 638853 -p 'Zebrafish,Stickleback' -c '156.53'
r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt
tail -n 1 r8s_tmp.txt | cut -c 16- > r8s_ultrametric.txt
cat r8s_ultrametric.txt
# ((((((((Notolabrus_celidotus:27.006824,Labroides_dimidiatus:27.006824):10.572321,(Cheilinus_undulatus:32.669714,Tautogolabrus_adspersus:32.669714):4.909431):4.324584,Semicossyphus_pulcher:41.903729):26.999364,Stickleback:68.903094):7.897860,Fugu:76.800954):6.237146,(Medaka:71.555667,Platyfish:71.555667):11.482433):73.491900,Zebrafish:156.530000)ishack:94.658902,Spottedgar:251.188902);
```
## Run CAFE: fm_nb_filtered.txt as input
```run1_fm5.sh
#! cafe
load -i fm_nb_filtered.txt.2 -t 20 -l reports_fm5/log_run1.txt -p 0.01 -r 10000
tree ((((((((Notolabruscelidotus:27.006824,Labroidesdimidiatus:27.006824):10.572321,(Cheilinusundulatus:32.669714,Tautogolabrusadspersus:32.669714):4.909431):4.324584,Semicossyphuspulcher:41.903729):26.999364,Stickleback:68.903094):7.897860,Fugu:76.800954):6.237146,(Medaka:71.555667,Platyfish:71.555667):11.482433):73.491900,Zebrafish:156.530000):94.658902,Spottedgar:251.188902)
lambda -s -t ((((((((1,1)1,(1,1)1)1,1)1,1)1,1)1,(1,1)1)1,1)1,1)
report reports_fm5/report_run1
python2 report_analysis.py -i reports_fm5/report_run1.cafe -o reports_fm5/summary_run1
```

```extract_sig_fm.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my %family1;
my $fam="fm_nb_ano.txt";
open FAMILY, "$fam" or die "There is no $fam\n";
while (<FAMILY>) {
        chomp;
        my @a=split /\t/;
        next if /^Family_id/i;
        my ($info, $ano);
        for (my $i = 2; $i < @a-1; $i++) {
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
my $final="../fm_nb_filtered.txt.2";
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
        my $header_new="Family_id\tSpottedgar\tZebrafish\tMedaka\tPlatyfish\tFugu\tStickleback\tSemicossyphuspulcher\tCheilinusundulatus\tTautogolabrusadspersus\tNotolabruscelidotus\tLabroidesdimidiatus\tgene_info\n";
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
# (base) kang1234@celia-PowerEdge-T640 Sun Jul 17 13:54:50 ~/genome/gene_family
cafe run1_fm5.sh
perl extract_sig_fm.pl
```

## compare dedicated cleaner fish vs. non-cleaner, facultative cleaner fish vs. non-cleaner, facultative cleaner fish vs. the ancestor node
```temp7.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $fm_nb="summary_run1_anc.txt";
my $ano="fm_nb_ano.txt";
my %ANO;
open ANN, $ano or die "can not open $ano\n";
while (<ANN>) {
    chomp;
    next if /^Family_id/;
    my @a=split /\t/;
    $ANO{$a[0]}=$a[-1];
}

#print "Fm_id\tRef$ref\t$target1\t$target2\t$target3\t$target4\t$target5\t";
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
        my ($Ldim, $Ncel, $Tads, $Cund, $Spul, $Aces);
        $Ldim=$a[$hash{"Labroidesdimidiatus2"}];
        $Ncel=$a[$hash{"Notolabruscelidotus0"}];
        $Tads=$a[$hash{"Tautogolabrusadspersus6"}];
        $Cund=$a[$hash{"Cheilinusundulatus4"}];
        $Spul=$a[$hash{"Semicossyphuspulcher8"}];
        $Aces=$a[$hash{"3"}];
        my $cmp1 =$Ldim-$Ncel;
        my $cmp2 =$Tads-$Cund;
        my $cmp3 =$Spul-$Aces;
        my $ano  =$ANO{$a[0]};
        my ($info1, $info2, $info3);
        ($cmp1>0)?($info1="expansion"):($cmp1==0)?($info1="Nochange"):($info1="contraction");
        ($cmp2>0)?($info2="expansion"):($cmp2==0)?($info2="Nochange"):($info2="contraction");
        ($cmp3>0)?($info3="expansion"):($cmp3==0)?($info3="Nochange"):($info3="contraction");
        print "$a[0]\t$Ldim\t$Ncel\t$info1\t$Tads\t$Cund\t$info2\t$Spul\t$Aces\t$info3\t$ano\n" if abs($cmp1)>=3 ||abs($cmp2)>=3 ||abs($cmp3)>=3;
    }
}
```

```bash
# select the same results of the two comparison (facultative cleaner fish vs. non-cleaner, facultative cleaner fish vs. the ancestor node)
# (base) kang1234@celia-PowerEdge-T640 Thu Aug 11 17:10:54 ~/genome/gene_family/reports_fm5
perl temp7.pl|perl -alne 'my @F=split /\t/;$inf="$F[3]\t$F[6]\t$F[9]";$hash{$inf}++;END{foreach my $key (sort keys %hash){print "$key\t$hash{$key}"}}'|perl -alne 'print if $F[1] eq $F[2]'
# Nochange	expansion	expansion	4
# contraction	Nochange	Nochange	15
# contraction	contraction	contraction	9
# contraction	expansion	expansion	9
# expansion	Nochange	Nochange	3
# expansion	contraction	contraction	5
# expansion	expansion	expansion	3

# (base) kang1234@celia-PowerEdge-T640 Thu Aug 11 17:18:16 ~/genome/gene_family/reports_fm5
perl temp7.pl|perl -alne 'my @F=split /\t/;$inf="$F[3]\t$F[6]\t$F[9]";print if $inf eq "contraction\texpansion\texpansion"'|less
```

## Function enrichment of genes in sig. contracted and expanded gene families
```bash
# Kang@fishlab3 Thu Aug 11 11:53:22 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
perl extract_gene_from_fm.pl Ldim.exp.sig.gf.txt >Ldim.exp.sig.gf.ge.txt
perl extract_gene_from_fm.pl Ldim.con.sig.gf.txt >Ldim.exp.con.gf.ge.txt
# used as input in Omicsbox
```


## Divergence time estimation
```bash
# Kang@fishlab3 Wed Jul 13 11:09:16 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11
mkdir paml_input; cd paml_input
# Kang@fishlab3 Wed Jul 13 11:12:57 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/paml_input
rm Longest_Thalassoma_bifasciatum_cds.fasta Longest_Labrus_bergylta_cds.fasta Longest_Symphodus_melops_cds.fasta
cp /media/HDD/cleaner_fish/genome/gene_family_3/OrthoFinder/Results_May09/paml_input/correlation.txt ./
# Kang@fishlab3 Wed Jul 13 12:41:03 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/paml_input
perl generate_single_copy_genes_list.pl >single_copy_genes_list.txt
nohup perl prepare_input_paml_parallel.pl single_copy_genes_list.txt >prepare_input_paml.process 2>&1 &
# [1] 7362
```


## Assign representative annotations to orthogroup using using KinFin 1.0   
**Annotation by interproscan-5.56-89.0**   
```bash
# Kang@fishlab3 Thu Jul 07 22:05:46 /media/HDD/cleaner_fish/genome/All_genomes/longest_pep
cat Semicossyphus_pulcher.fasta Tautogolabrus_adspersus.fasta Notolabrus_celidotus.fasta Labroides_dimidiatus.fasta Cheilinus_undulatus.fasta Fugu.fasta Medaka.fasta Platyfish.fasta Spottedgar.fasta Stickleback.fasta Zebrafish.fasta >All_11fish_longest_pep.fasta
scp All_11fish_longest_pep.fasta kang1234@147.8.76.177:~/software/interproscan-5.56-89.0

# (base) kang1234@celia-PowerEdge-T640 Thu Jul 07 22:17:53 ~/software/interproscan-5.56-89.0
less All_11fish_longest_pep.fasta|perl -alne 'if (/>/){print}else{s/\_//g;s/\-//g;s/\*//g;s/\.//g;print}' >All_11fish_longest_pep.fasta.1
mv All_11fish_longest_pep.fasta.1 All_11fish_longest_pep.fasta
nohup ./interproscan.sh -i All_11fish_longest_pep.fasta -f tsv -appl pfam --goterms --cpu 12 >interproscan.process 2>&1 &
# [1] 32309
# Kang@fishlab3 Mon Jul 11 15:25:01 /media/HDD/cleaner_fish/genome/gene_family_5
scp kang1234@147.8.76.177:~/software/interproscan-5.56-89.0/All_11fish_longest_pep.fasta.tsv ./
# All_11fish_longest_pep.fasta.tsv convert to a file format readable by KinFin
# 4. Functional annotation file
~/software/kinfin/scripts/iprs2table.py -i All_11fish_longest_pep.fasta.tsv # output: functional_annotation.txt
less functional_annotation.txt|perl -alne 'my $info;for(my $i=1;$i<=@F;$i++){$info.=$F[$i]."\t"};$info=~s/\s+$//;if (/^#/){print}elsif(/^ENSDARG/){my $b="Zebrafish_$F[0]";print"$b\t$info"}elsif(/^ENSLOCG/){my $b="Spottedgar_$F[0]";print"$b\t$info"}elsif(/^ENSGACG/){my $b="Stickleback_$F[0]";print"$b\t$info"}elsif(/^ENSXMAG/){my $b="Platyfish_$F[0]";print"$b\t$info"}elsif(/^ENSORLG/){my $b="Medaka_$F[0]";print"$b\t$info"}elsif(/^ENSTRUG/){my $b="Fugu_$F[0]";print"$b\t$info"}else{print}' >functional_annotation_1.txt
```

```bash
# Kang@fishlab3 Mon Jul 11 10:47:09 /media/HDD/cleaner_fish/genome
mkdir gene_family_5; cd gene_family_5
# Kang@fishlab3 Mon Jul 11 10:53:29 /media/HDD/cleaner_fish/genome/gene_family_5
perl filter_genes.pl
# Kang@fishlab3 Mon Jul 11 11:00:25 /media/HDD/cleaner_fish/genome
nohup orthofinder -f gene_family_5 -a 32 >Orthofinder.process 2>&1 &
# [1] 26944
```

```Generate_sequenceID.pl
#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;

open SEQ, ">SequenceID.txt" or die "can not create SequenceID.txt\n$!\n";

my $spetxt="./OrthoFinder/Results_Jul11/WorkingDirectory/SpeciesIDs.txt";
open SPETXT, $spetxt or die "can not open $spetxt\n$!\n";
while (<SPETXT>) {
	chomp;
    next if /^#/;
    my @a=split;
    (my $id) =$a[0]=~/(.*?)\:/;
    open FASTA, $a[1] or die "can not open $a[1]\n$!\n";
    my $i;
    while (<FASTA>) {
        chomp;
        if (/>/) {
        	s/>//;
    		$i++;
    		my $info=$id."_".$i.": ".$_;
        	print SEQ "$info\n";
        }
    }
    close FASTA;
}
close SEQ;
```

```bash
# sig. expanded and contracted gene families
# (base) kang1234@celia-PowerEdge-T640 Wed Aug 03 15:14:40 ~/genome/gene_family/reports_fm5
less summary_run1_fams.txt|perl -alne 'next if /^#/ || /^over/i;my @a=split /\,/, $F[1];my $nb=@a;;my ($i, $j);foreach my $a(@a){($a=~/\+/)?($i++):($j++)};print "$F[0]\t$nb\t+$i\/-$j"'
perl temp7.pl|perl -alne 'my @F=split /\t/;$inf="$F[3]\t$F[6]\t$F[9]";print if $inf eq "contraction\tcontraction\tcontraction"'
perl temp7.pl|perl -alne 'my @F=split /\t/;$inf="$F[3]\t$F[6]\t$F[9]";$hash{$inf}++;END{foreach my $key (sort keys %hash){print "$key\t$hash{$key}"}}'
perl temp7.pl|perl -alne 'my @F=split /\t/;$inf="$F[3]\t$F[6]\t$F[9]";print if $inf eq "contraction\tcontraction\tcontraction"'
```

### Start run KinFin   
```bash
# Generate the input of KinFin
# 1. SpeciesID.txt
# Kang@fishlab3 Mon Jul 11 15:31:57 /media/HDD/cleaner_fish/genome/gene_family_5
find . -name "SpeciesIDs.txt"
# ./OrthoFinder/Results_Jul11/WorkingDirectory/SpeciesIDs.txt

# 2. config file
# Kang@fishlab3 Mon Jul 11 11:29:07 /media/HDD/cleaner_fish/genome/gene_family_5
echo '#IDX,TAXON' > config.txt
sed 's/: /,/g' ./OrthoFinder/Results_Jul11/WorkingDirectory/SpeciesIDs.txt | \
    cut -f 1 -d"." \
    >> config.txt

# 3. SequenceID.txt
perl Generate_sequenceID.pl # output: SequenceID.txt

# 4. Functional annotation file
~/software/kinfin/scripts/iprs2table.py -i All_11fish_longest_pep.fasta.tsv # output: functional_annotation.txt

# 5. Protein clustering file
# Kang@fishlab3 Mon Jul 11 16:06:55 /media/HDD/cleaner_fish/genome/gene_family_5
find . -name "Orthogroups.txt"
# /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/Orthogroups.txt

# 6. Run kinfin
# Kang@fishlab3 Mon Jul 11 16:07:07 /media/HDD/cleaner_fish/genome/gene_family_5
~/software/kinfin/kinfin -g /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/Orthogroups.txt -c config.txt -s SequenceID.txt -p /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/WorkingDirectory/SpeciesIDs.txt -f functional_annotation_1.txt --infer_singletons

# 7. Annotation to cluster
# Kang@fishlab3 Tue Jul 12 09:49:09 /media/HDD/cleaner_fish/genome/gene_family_5/kinfin_results
~/software/kinfin/scripts/functional_annotation_of_clusters.py all -f cluster_domain_annotation.GO.txt -c cluster_counts_by_taxon.txt -o Final
```

### OmicsBox do the enrichment analysis
#### Use One Zebrafish pep sequence (select the longest) as reference
**Use the conserved gene families**   
```bash
# Kang@fishlab3 Tue Jul 26 14:57:18 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
wc -l fm_nb_filtered.txt # 11061 conserved gene families
```

```extract_conserved_zebseq.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $confm="/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/fm_nb_filtered.txt";
my $seqdir="/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroup_Sequences";
open CON, $confm or die "can not open $confm\n$!\n";
while (<CON>) {
	chomp;
	my @a=split /\t/;
	if (/Desc/) {
		next;
	} else {
		my $fmid  =$a[1];
		(my $orth)=$fmid=~/FM(\d+)/;
		my $orthfa   ="OG".$orth.".fa";
		my $seq   ="$seqdir/$orthfa";
		my ($name, $spe); my (%hash, %hash1);
		open SEQ, $seq or die "can not open $seq\n$!\n";
		while (<SEQ>) {
			chomp;
			if (/\>/) {
				s/\>//;
				$name=$_;
			} else {
				$hash{$name}.=$_;
			}
		}
		foreach my $key (keys %hash) {
			($spe)=$key=~/(.*)\_/;
			(my $seqs)=$hash{$key};
			my $len=length($seqs);
			if ($hash1{$spe}) {
				unless ($len <= $hash1{$spe}->{'length'}) {
					$hash1{$spe}={
						'seqid' => $_,
						'seq'   => $seqs,
						'length'=> $len
					};
				}
			} else {
				$hash1{$spe}={
					'seqid' => $_,
					'seq'   => $seqs,
					'length'=> $len
				};
			}
		}
		print ">$fmid\n$hash1{'Zebrafish'}->{'seq'}\n";
	}
}
```

```bash
# Kang@fishlab3 Wed Jul 27 10:59:08 /media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups
perl extract_conserved_zebseq.pl >conserved_gnfm.fas # as input of omicsbox
# kangjingliang@kangjingliangdeMacBook-Pro 三  7 27 11:02:31 ~/Documents/2022/Ldim_genome/Gene_fm5
scp Kang@147.8.76.231:/media/HDD/cleaner_fish/genome/gene_family_5/OrthoFinder/Results_Jul11/Orthogroups/conserved_gnfm.fas ./
```

# Olfactory recerptors phylogeny
## only use the intact OR genes of eight Labridae species
```temp5.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
	'Cheilinus_undulatus'  =>  'Cund',
	'Cleaner_wrasse' =>  'Ldim',
	'Labrus_bergylta'  =>  'Lber',
	'Notolabrus_celidotus' =>  'Ncel',
	'Semicossyphus_pulcher' =>  'Spul',
	'Symphodus_melops' =>  'Smel',
	'Tautogolabrus_adspersus'=> 'Tads',
	'Thalassoma_bifasciatum' => 'Tbif',
	);

foreach my $spe (sort keys %species) {
    my $fas  ="/media/HDD/cleaner_fish/genome/OR_detection/$spe/group/filter.out.1.info.fasta";
    my (%gene, %class);
    my $spe1=$species{$spe};
    my ($gene_nm, $class_nm);
    open FAS, $fas or die "can not open $fas\n$!\n";
    while (<FAS>) {
    	chomp;
    	my $name=$spe1;
    	if (/\>.*\:C|\-C/) {
    		($gene_nm, $class_nm)=$_=~/Gene_name=\((.*?)\).*Class=\((.*?)\)/;
    		$gene{$gene_nm}++; $class{$class_nm}++;
    		$name.="_".$gene_nm."_$gene{$gene_nm}_".$class_nm."_$class{$class_nm}";
    		print ">$name\n";
    		my $line=<FAS>;
  			chomp($line);
    		print "$line\n";
    	}
    }
}
```

```bash
# Kang@fishlab3 Thu Aug 25 14:15:54 /media/HDD/cleaner_fish/genome/OR_detection
perl temp5.pl >ORs_Labridae.fas
cat ORs_Labridae.fas Non_OR_gene2.fasta >ORs_Labridae_phy.fas
muscle -in ORs_Labridae_phy.fas -out ORs_Labridae_phy_align.fas
FastTreeMP ORs_Labridae_phy_align.fas >ORs_Labridae_phy.tre
```
## Immunolobulin heavy
```temp3.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
        'Cheilinus_undulatus'  =>  'Cund',
        'Labroides_dimidiatus' =>  'Ldim',
        'Labrus_bergylta'  =>  'Lber',
        'Notolabrus_celidotus' =>  'Ncel',
        'Semicossyphus_pulcher' =>  'Spul',
        'Symphodus_melops' =>  'Smel',
        'Tautogolabrus_adspersus'=> 'Tads',
        'Thalassoma_bifasciatum' => 'Tbif',
        );

my (%hash1, %hash2, %hash3);
my @genes;
my $header;
open NM, "name.txt" or die "can not open name.txt\n$!\n";
while (<NM>) {
    chomp;
    my @a=split;
    $hash3{$a[0]}=$a[1];
}
foreach my $spe (sort keys %species) {
        $header.=$spe."\t";
    my $blafa  ="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering/3_phy.bla.fa";
    my $info;
    open BLAFA, $blafa or die "can not open $blafa\n$!\n";
    while (<BLAFA>) {
        chomp;
        my @a=split /\t/;
        if (/>/ && !/\:F/) {
                s/>//;
                $_=~s/sp\|(.*?)\|.*\_.*/sp\|($hash3{$_})\|.*\_.*/;
                $info=$_;
                print ">$info\n";
                my $line=<BLAFA>;
                        chomp($line);
                print "$line\n";
        }
    }
}
```

```bash
# Kang@fishlab3 Mon Aug 29 16:39:20 /media/HDD/cleaner_fish/genome/Immu_heavy
perl temp3.pl >Final_Immu_heavy.fas
muscle -in Final_Immu_heavy.fas -out Final_Immu_heavy_align.fas
FastTreeMP Final_Immu_heavy_align.fas >Final_Immu_heavy.tre
```

### Build the tree of Immu heavy genes for each species
#### Cund
only keep the genes without frameshift for phylogenetic tree construction   
```perl5.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
        'Cheilinus_undulatus'  =>  'Cund',
        'Labroides_dimidiatus' =>  'Ldim',
        'Labrus_bergylta'  =>  'Lber',
        'Notolabrus_celidotus' =>  'Ncel',
        'Semicossyphus_pulcher' =>  'Spul',
        'Symphodus_melops' =>  'Smel',
        'Tautogolabrus_adspersus'=> 'Tads',
        'Thalassoma_bifasciatum' => 'Tbif',
        'Zebrafish' => 'Zebrafish',
        'Fugu' => 'Fugu',
        'Medaka' => 'Medaka',
        'Platyfish' => 'Platyfish',
        'Spottedgar' => 'Spottedgar',
        'Stickleback' => 'Stickleback'
        );

my %hash1;
open NM, "name.txt" or die "can not open name.txt\n$!\n";
while (<NM>) {
    chomp;
    my @a=split;
    (my $id)=$a[0]=~/(.*?)\_.*/;
    $hash1{$id}=$a[1];
}

my $dir="/media/HDD/cleaner_fish/genome/Immu_heavy";
foreach my $spe (sort keys %species) {
        my $fas="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering/3_phy.bla.fa";
        open FAS, $fas or die "can not open $!\n$fas\n";
        my $fasnew="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering/$spe.fa";
        open NEW, ">$fasnew" or die "can not create $!\n$fasnew\n";
        while (<FAS>) {
                chomp;
                if (/\>.*?\_(.*?)\_.*/ && ! /\:F/) {
                        s/\>(.*?)\_(.*?)\_/\>$1\_$hash1{$2}\_/;
                        print NEW "$_\n";
                        my $line=<FAS>;
                        chomp($line);
                        print NEW "$line\n";
                }
        }
}
```
```bash
# Kang@fishlab3 Mon Sep 05 13:48:52 /media/HDD/cleaner_fish/genome/Immu_heavy
perl temp5.pl
cd /media/HDD/cleaner_fish/genome/Immu_heavy/Cheilinus_undulatus/filtering
# Kang@fishlab3 Mon Sep 05 13:58:30 /media/HDD/cleaner_fish/genome/Immu_heavy/Cheilinus_undulatus/filtering
muscle -in Cheilinus_undulatus.fa -out Cheilinus_undulatus_align.fas
FastTreeMP Cheilinus_undulatus_align.fas >Cheilinus_undulatus.tre
```

```temp1.pl
#!/usr/bin/perl
use strict;
use warnings;

my %gene=(
        'IGHV1' => '#ce7e00',
        'IGHV2' => '#f6b26b',
        'IGHV3' => '#f44336',
        'IGHV4' => '#000000',
        'IGHV5' => '#8fce00',
        'IGHV7' => '#6a329f',
        );

my %shape=(
        'intact' => '2',
        'part'   => '4'
        );
my %info;

my $fas=$ARGV[0];
open FAS, $fas or die "can not open $fas\n$!\n";
while (<FAS>) {
        chomp;
        if (/>/) {
                s/>//;
                my @a=split;
                my @b=split /\_/, $a[0];
                my @c=split /\-/, $b[1];
                my $gene=$c[0];
                my $color=$gene{$gene};
                my $sp;
                ($a[0]=~/C$/)?($sp=$shape{'intact'}):($sp=$shape{'part'});
                print "$a[0] $sp 1 $color 1 1\n";
        }
}
```

```bash
perl temp1.pl Cheilinus_undulatus_align.fas
```

**plot in itol (node_color_shape_itol.txt to annotation the phylogenetic tree)**    
```node_color_shape_itol.txt
DATASET_SYMBOL
#Symbol datasets allow the display of various symbols on the branches of the tree. For each node, one or more symbols can be defined.
#Each symbol's color, size and position along the branch can be specified.

#lines starting with a hash are comments and ignored during parsing
#=================================================================#
#                    MANDATORY SETTINGS                           #
#=================================================================#
#select the separator which is used to delimit the data below (TAB,SPACE or COMMA).This separator must be used throughout this file.
#SEPARATOR TAB
SEPARATOR SPACE
#SEPARATOR COMMA

#label is used in the legend table (can be changed later)
DATASET_LABEL example symbols
1 1

#dataset color (can be changed later)
COLOR #ffff00

#=================================================================#
#                    OPTIONAL SETTINGS                            #
#=================================================================#


#=================================================================#
#     all other optional settings can be set or changed later     #
#           in the web interface (under 'Datasets' tab)           #
#=================================================================#

#Each dataset can have a legend, which is defined using LEGEND_XXX fields below
#For each row in the legend, there should be one shape, color and label.
#Optionally, you can define an exact legend position using LEGEND_POSITION_X and LEGEND_POSITION_Y. To use automatic legend positioning, do NOT define these values
#Optionally, shape scaling can be present (LEGEND_SHAPE_SCALES). For each shape, you can define a scaling factor between 0 and 1.
#Optionally, shapes can be inverted (LEGEND_SHAPE_INVERT). When inverted, shape border will be drawn using the selected color, and the fill color will be white.
#To order legend entries horizontally instead of vertically, set LEGEND_HORIZONTAL to 1
#Shape should be a number between 1 and 6, or any protein domain shape definition.
#1: square
#2: circle
#3: star
#4: right pointing triangle
#5: left pointing triangle
#6: checkmark

#LEGEND_TITLE,Dataset legend
#LEGEND_POSITION_X,100
#LEGEND_POSITION_Y,100
#LEGEND_HORIZONTAL,0
#LEGEND_SHAPES,1,2,3
#LEGEND_COLORS,#ff0000,#00ff00,#0000ff
#LEGEND_LABELS,value1,value2,value3
#LEGEND_SHAPE_SCALES,1,1,0.5
#LEGEND_SHAPE_INVERT,0,0,0


#largest symbol will be displayed with this size, others will be proportionally smaller.
MAXIMUM_SIZE 10

#symbols can be filled with solid color, or a gradient
#GRADIENT_FILL,1

#Internal tree nodes can be specified using IDs directly, or using the 'last common ancestor' method described in iTOL help pages
#=================================================================#
#       Actual data follows after the "DATA" keyword              #
#=================================================================#
#the following fields are required for each node:
#ID,symbol,size,color,fill,position,label
#symbol should be a number between 1 and 5:
#1: rectangle
#2: circle
#3: star
#4: right pointing triangle
#5: left pointing triangle
#6: checkmark

#size can be any number. Maximum size in the dataset will be displayed using MAXIMUM_SIZE, while others will be proportionally smaller
#color can be in hexadecimal, RGB or RGBA notation. If RGB or RGBA are used, dataset SEPARATOR cannot be comma.
#fill can be 1 or 0. If set to 0, only the outline of the symbol will be displayed.
#position is a number between 0 and 1 and defines the position of the symbol on the branch (for example, position 0 is exactly at the start of node branch, position 0.5 is in the middle, and position 1 is at the end)

DATA
#Examples

#internal node will have a red filled circle in the middle of the branch
#9606|184922,2,10,#ff0000,1,0.5

#node 100379 will have a blue star outline at the start of the branch, half the size of the circle defined above (size is 5 compared to 10 above)
#100379,3,5,#0000ff,0,0
Cund_IGHV3-48_1T 4 1 #f44336 1 1
Cund_IGHV3-43_1T 4 1 #f44336 1 1
Cund_IGHV3-48_6T 4 1 #f44336 1 1
Cund_IGHV3-48_7T 4 1 #f44336 1 1
Cund_IGHV3-48_8T 4 1 #f44336 1 1
Cund_IGHV3-48_3C 2 1 #f44336 1 1
Cund_IGHV3-30-3_10T 4 1 #f44336 1 1
Cund_IGHV3-48_2T 4 1 #f44336 1 1
Cund_IGHV3-30-3_6T 4 1 #f44336 1 1
Cund_IGHV3-7_3T 4 1 #f44336 1 1
Cund_IGHV3-7_2T 4 1 #f44336 1 1
Cund_IGHV3-7_4T 4 1 #f44336 1 1
Cund_IGHV3-33_3T 4 1 #f44336 1 1
Cund_IGHV3-33_2P 4 1 #f44336 1 1
Cund_IGHV3-7_1T 4 1 #f44336 1 1
Cund_IGHV3-30-3_5T 4 1 #f44336 1 1
Cund_IGHV3-48_4T 4 1 #f44336 1 1
Cund_IGHV3-30-3_4T 4 1 #f44336 1 1
Cund_IGHV3-33_4T 4 1 #f44336 1 1
Cund_IGHV3-48_5T 4 1 #f44336 1 1
Cund_IGHV3-23_2T 4 1 #f44336 1 1
Cund_IGHV3-30-3_7T 4 1 #f44336 1 1
Cund_IGHV3-23_1T 4 1 #f44336 1 1
Cund_IGHV3-30-3_9T 4 1 #f44336 1 1
Cund_IGHV3-30-3_2T 4 1 #f44336 1 1
Cund_IGHV3-30-3_1C 2 1 #f44336 1 1
Cund_IGHV3-30-3_3T 4 1 #f44336 1 1
Cund_IGHV3-30-3_8T 4 1 #f44336 1 1
Cund_IGHV2-26_1C 2 1 #f6b26b 1 1
Cund_IGHV2-70D_1C 2 1 #f6b26b 1 1
Cund_IGHV2-5_1C 2 1 #f6b26b 1 1
Cund_IGHV2-5_2T 4 1 #f6b26b 1 1
Cund_IGHV3-33_1C 2 1 #f44336 1 1
Cund_IGHV2-70_1C 2 1 #f6b26b 1 1
Cund_IGHV4-38-2_1C 2 1 #000000 1 1
#node 100379 will also have a filled green rectangle in the middle of the branch, same size as the circle defined above (size is 10)
#100379,1,10,#00ff00,1,0.5
```
#### do the same things to other Labrodie species
```temp6.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
        'Labroides_dimidiatus' =>  'Ldim',
        'Labrus_bergylta'  =>  'Lber',
        'Notolabrus_celidotus' =>  'Ncel',
        'Semicossyphus_pulcher' =>  'Spul',
        'Symphodus_melops' =>  'Smel',
        'Tautogolabrus_adspersus'=> 'Tads',
        'Thalassoma_bifasciatum' => 'Tbif',
        );

foreach my $spe (sort keys %species) {
    my $dir  ="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering";
    system("cp /media/HDD/cleaner_fish/genome/Immu_heavy/Cheilinus_undulatus/filtering/temp1.pl $dir");
    my $fas="$dir/$spe.fa";
    my $align="$dir/$spe\_align.fa";
    my $tree="$dir/$spe.tre";
    system("muscle -in $fas -out $align");
    system("FastTreeMP $align >$tree");
}
```
```bash
# Kang@fishlab3 Mon Sep 05 14:24:24 /media/HDD/cleaner_fish/genome/Immu_heavy
perl temp6.pl
```
**then plot in itol, cp the tree file to Desktop**   
```temp1.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
        'Labroides_dimidiatus' =>  'Ldim',
        'Labrus_bergylta'  =>  'Lber',
        'Notolabrus_celidotus' =>  'Ncel',
        'Semicossyphus_pulcher' =>  'Spul',
        'Symphodus_melops' =>  'Smel',
        'Tautogolabrus_adspersus'=> 'Tads',
        'Thalassoma_bifasciatum' => 'Tbif',
        'Zebrafish' => 'Zebrafish',
        'Fugu' => 'Fugu',
        'Medaka' => 'Medaka',
        'Platyfish' => 'Platyfish',
        'Spottedgar' => 'Spottedgar',
        'Stickleback' => 'Stickleback'
        );

foreach my $spe (sort keys %species) {
    my $dir  ="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering";
    my $tree="$dir/$spe.tre";
    system("scp Kang\@147.8.76.231:$tree ./");
}
```
```bash
# kangjingliang@kangjingliangdeMacBook-Pro 一  9 05 16:26:34 ~/Desktop
perl temp1.pl
```
**Check the gene in some species**   
```temp7.pl
#!/usr/bin/perl
use strict;
use warnings;

my %species=(
        'Labroides_dimidiatus' =>  'Ldim',
        'Labrus_bergylta'  =>  'Lber',
        'Notolabrus_celidotus' =>  'Ncel',
        'Semicossyphus_pulcher' =>  'Spul',
        'Symphodus_melops' =>  'Smel',
        'Tautogolabrus_adspersus'=> 'Tads',
        'Thalassoma_bifasciatum' => 'Tbif',
#        'Zebrafish' => 'Zebrafish',
#        'Fugu' => 'Fugu',
#        'Medaka' => 'Medaka',
#        'Platyfish' => 'Platyfish',
#        'Spottedgar' => 'Spottedgar',
#        'Stickleback' => 'Stickleback'
        );

foreach my $spe (sort keys %species) {
    my $dir  ="/media/HDD/cleaner_fish/genome/Immu_heavy/$spe/filtering";
#    system("cp /media/HDD/cleaner_fish/genome/Immu_heavy/Cheilinus_undulatus/filtering/temp1.pl $dir");
    my $fas="$dir/$spe.fa";
    my $align="$dir/$spe\_align.fa";
    my $tree="$dir/$spe.tre";
    #system("muscle -in $fas -out $align");
        #       system("FastTreeMP $align >$tree");
    open FAS, $align or die "can not open $align\n$!\n";
    while (<FAS>) {
        chomp;
        if (/>/) {
            s/>//;
            my @a=split;
            my @b=split /\_/, $a[0];
            my @c=split /\-/, $b[1];
            my $gene=$c[0];
#            my $color=$gene{$gene};
            my $sp;
#            ($a[0]=~/C$/)?($sp=$shape{'intact'}):($sp=$shape{'part'});
            print "$gene\n";
        }
    }
}
```

```bash
# Kang@fishlab3 Mon Sep 05 23:22:07 /media/HDD/cleaner_fish/genome/Immu_heavy
perl temp7.pl|sort -u
```

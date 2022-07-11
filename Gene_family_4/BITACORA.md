# Olfactory receptors or other gene family
## 1. Olfactory receptors
## 2. Other gene family
### 2.1 Crystallin
```bash
# Kang@fishlab3 Tue Jun 21 10:16:56 /media/HDD/cleaner_fish/genome/Crystallin_detection_2
Gmfm_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader_final.fasta --species Cleaner_wrasse --keyword Crystallin --query /media/HDD/cleaner_fish/genome/Crystallin_detection_2/Crystallin_query.fasta --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
```

**nonlens, βγ-motif-containing sequences in our analysis as outgroups (Molecular Evolution of the βγ Lens Crystallin Superfamily: Evidence for
a Retained Ancestral Function in γN Crystallins?)**   
```fasta
>5-EP37L2-Outgroup
MTMNTITVYEHSNFQGLHKTFTADVPNLVNESFNDCISSVKIVGQPWILYQDINYSGQCLPLEEGEYSGISMNDGASSLRLITDDLSNPQITVYEHINSGGKALVLTQESNLAFGNMHDNISSHRVQRGAWALYEHINRGGRCIVARAGEYLANYCTIGFNDQVSHVYPLRAGKSSVTATILWDRKKVESERNVQIDQYFYTNNTSIEQQFTATSTKEFEKYVSHSFEFSNETTIKVGTSFTLKGVVDINTEVSDTFTVKKGETESFTTRKKAELSMPVKAPPRSKLTVNFMCKEVTISVPVELKIVRGSKTDIETGTYRCESGTETYIDVQSLPIS
>6-EP37L1-Outgroup
MNTITVYEHSNFQGLHKTFTSDVPNLVNESFNDCISSVKIVGQPWILHQDINYSGQCLPLEEGEYSGISMNDGASSLRLITDDLSNPQITVYEHVNGGGKALVLTEETNLAFGNMHDNISSHRVQRGAWALYEHINRGGRCIVARAGEYLANYCTIGFNDQVSHVYPLRAGKTSVTATILWDRKKVESERNVQIDQYFYTNNTSIEQQFTATSTKEFEKYVSHSFEFSNETSIKVGTSFTLKGVVDINTEVSNTFTVKKGETESFTTRKKAELSMPVKAPPRSKLTVNFMCKEITISVPVELKIVRGSKTDIETGTYRCESGTETYIDVQSLPIS
>7-EP37A1-Outgroup
MTMNTITVYEHSDFRGLYKTFTSDVPNLVYENFNDCISSVKIAGQPWVLYQDLHYQGQCLPLEEGEYSGISMNDGATSLRLITDDLSNPQITVYENSNSGGKSLVLTQESNLSFGGMQDNISSHSVQRGAWALYEHINKGGRCIVARAGEYLANYRDIGFNDQVSYVYPLRAGKSSVTATILWDRKTVESERNFEIDQYHYKNQSNVEQQFTATSSKEFEKFVSHSFEFSNETTIKVGTSFTLKGVVDINTELSNTFTVKKGETQSSTMRKKTELSMPVKAPPRSNVTVSFLCKEVTISVPVELKIVQGGNTRIETGTYRCQSGTETTIDVQCLPIG
>8-EP37A1-Outgroup
MNTITVYEHPNFQGLSRTFTTDVPRLSEHSFEDCISSAKVVGQPWLMYEHPNYQGWCTPLEEGEHSQTQMNDMGSSLILITEDLSNPMITVYEHPDYSGKAMVLTQEANLTLGDMNDKISSHKVQSGAWLLYEHPNRGGWSIRARAGEWLPNYWSNGFNDKVSHVYPLRPGKASATAKILWDKKKIESERNIQIDQYFYTNNTDIEQGFTATSTKEFEKHVSHSFEFGNETSVKVGTSFTLKGVVNIEAEASNTFTVKKGESESFTTRKKTELSMPVKAPPRTKVTVNFMCKEVTISVPVELKVAQGTKTVTESGTYRCESGTDTYIDVQSQAIGRH
>9-GEP-Outgroup
MDSITVYEGRKLRGLHKTFTADVPDLTKECFNDCISSVKVVGQPWILYEHPNYQGRCIALEEGEHSHLPFSFLSSLTDKISSLKLITDDLINPQITVYENMHEGGKALVLTQESDMVFGGMNNKISSHRVQSGAWVLYENREKRGRCIVARAGEYLANYCDIGFNDQVSYVYPLRPGECTVTATILWDKKVESVRNLQIEQYSYTNSTDTEQQFTVTCTKEFEKYASHSFEFSNDTSLRAGVAFPLNGIVNIEGEVSNTFRVTKGETKSFTMKNKSELSTPVTVTPGTKAIVNFFCKEITISVPVELKIIRGGKTYTETGTYRCESSTAINTDVQYLPVVTQNDGAPL
```
**Query proteins**  
```bash
# Kang@fishlab3 Tue Jun 21 11:39:35 ~/Desktop/Annotation_database/swiss-prot
less unprot_name_description.txt|grep -i 'Crystallin'|grep -Ei 'Gamma|Alpha|Beta'|grep -vi 'Rho'|perl -alne 'print $F[0]' >Crystallin_query.id
```

```extract_seq.pl
#!/usr/bin/perl -w
use strict;
use warnings;

my $uni="uniprot-filtered-reviewed_yes.fasta";
my %hash; my $name;
open UNI, $uni or die "can not open $!\n";
while (<UNI>) {
	chomp;
	if (/>/) {
		s/>//;
		my @a=split;
		$name=$a[0];
	} else {
		$hash{$name}.=$_;
	}
}

my $tar=$ARGV[0];
open TAR, $tar or die "can not open $!\n";
while (<TAR>) {
	chomp;
	if ($hash{$_}) {
		print ">$_\n$hash{$_}\n";
	}
}
```

```bash
# Kang@fishlab3 Tue Jun 21 11:48:55 ~/Desktop/Annotation_database/swiss-prot
perl extract_seq.pl Crystallin_query.id >Crystallin_query.fasta
mv Crystallin_query.fasta /media/HDD/cleaner_fish/genome/Crystallin_detection_2
# Kang@fishlab3 Tue Jun 21 11:52:22 /media/HDD/cleaner_fish/genome/Crystallin_detection_2
Gmfm_detect --genome /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader_final.fasta --species Cleaner_wrasse --keyword Crystallin --query /media/HDD/cleaner_fish/genome/Crystallin_detection_2/Crystallin_query.fasta --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
1.sh
```
***
## Put all genome related files in a dir (detect gene family by bitacora)
```bash
# Kang@fishlab3 Thu Jun 23 14:13:22 /media/HDD/cleaner_fish/genome
mkdir All_genomes; cd All_genomes
# Kang@fishlab3 Thu Jun 23 14:16:36 /media/HDD/cleaner_fish/genome/All_genomes

# genome fasta files
mv /media/HDD/cleaner_fish/genome/OR_detection/Cleaner_wrasse_softmasked_ChaHeader_final.fasta Labroides_dimidiatus.fasta
mv /media/HDD/cleaner_fish/genome/Thalassoma_bifasciatum.fasta ./
mv /media/HDD/cleaner_fish/genome/Notolabrus_celidotus.fasta ./
mv /media/HDD/cleaner_fish/genome/cheilinus_undulatus.fasta ./
mv /media/HDD/cleaner_fish/genome/smel_genome/Symphodus_melops_softmasked.fasta Symphodus_melops.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Semicossyphus_pulcher_softmasked_ChaHeader.fasta Semicossyphus_pulcher.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Tautogolabrus_adspersus_softmasked_ChaHeader.fasta Tautogolabrus_adspersus.fasta
mv /media/HDD/cleaner_fish/genome/Labrus_bergylta.fasta ./
mv /media/HDD/cleaner_fish/genome/OR_detection/Fugu.dna_sm.toplevel.fa Fugu.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Oryzias_latipes.ASM223467v1.dna_sm.toplevel.fa Medaka.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Gasterosteus_aculeatus.BROADS1.dna_sm.toplevel.fa Stickleback.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa Zebrafish.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Platyfish-male.dna_sm.toplevel.fa Platyfish.fasta
mv /media/HDD/cleaner_fish/genome/OR_detection/Spottedgar.dna_sm.toplevel.fa Spottedgar.fasta

# gtf files
scp kang1234@147.8.76.177:~/genome/Gene_annotation/combined/Ldim_chr_name.gtf Labroides_dimidiatus.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Cheilinus_undulatus/braker_renamed.gtf Cheilinus_undulatus.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Labrus_bergylta/braker_renamed.gtf Labrus_bergylta.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Notolabrus_celidotus/braker_renamed.gtf Notolabrus_celidotus.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Semicossyphus_pulcher/braker_renamed.gtf Semicossyphus_pulcher.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Symphodus_melops/braker_renamed.gtf Symphodus_melops.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Tautogolabrus_adspersus/braker_renamed.gtf Tautogolabrus_adspersus.gtf
scp kang1234@147.8.76.177:~/genome/Gene_annotation/Thalassoma_bifasciatum/braker_renamed.gtf Thalassoma_bifasciatum.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/danio_rerio/Danio_rerio.GRCz11.106.chr.gtf.gz|mv Danio_rerio.GRCz11.106.chr.gtf Zebrafish.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/takifugu_rubripes/Takifugu_rubripes.fTakRub1.2.106.chr.gtf.gz|mv Takifugu_rubripes.fTakRub1.2.106.chr.gtf Fugu.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/oryzias_latipes/Oryzias_latipes.ASM223467v1.106.chr.gtf.gz|mv Oryzias_latipes.ASM223467v1.106.chr.gtf Medaka.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/xiphophorus_maculatus/Xiphophorus_maculatus.X_maculatus-5.0-male.106.chr.gtf.gz|mv Xiphophorus_maculatus.X_maculatus-5.0-male.106.chr.gtf Platyfish.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/gasterosteus_aculeatus/Gasterosteus_aculeatus.BROADS1.106.chr.gtf.gz|mv Gasterosteus_aculeatus.BROADS1.106.chr.gtf Stickleback.gtf
wget http://ftp.ensembl.org/pub/release-106/gtf/lepisosteus_oculatus/Lepisosteus_oculatus.LepOcu1.106.chr.gtf.gz|mv Lepisosteus_oculatus.LepOcu1.106.chr.gtf Spottedgar.gtf

# longest pep per gene fasta files
# Kang@fishlab3 Thu Jun 23 14:47:41 /media/HDD/cleaner_fish/genome/All_genomes
mkdir longest_pep; cd longest_pep
# Kang@fishlab3 Thu Jun 23 14:50:42 /media/HDD/cleaner_fish/genome/All_genomes/longest_pep
cp /media/HDD/cleaner_fish/genome/gene_family_2/longest_pep/*.fasta ./
```

### 2.2 Cadherin gene family (including protocadherin)
```bash
# Kang@fishlab3 Tue Jun 21 14:07:54 ~/Desktop/Annotation_database/swiss-prot
less unprot_name_description.txt|grep -i 'cadherin'|perl -alne 'print $F[0]' > Cadherin_query.id
perl extract_seq.pl Cadherin_query.id >Cadherin_query.fasta
mv Cadherin_query.fasta /media/HDD/cleaner_fish/genome/Cadherin_detection
# Kang@fishlab3 Fri Jun 24 11:58:56 /media/HDD/cleaner_fish/genome/Cadherin_detection
mv Cadherin_query.fasta Cadherin_db.fasta
muscle -in Cadherin_db.fasta -out Cadherin_db.aln
hmmbuild Cadherin_db.hmm Cadherin_db.aln
~/software/bitacora/runBITACORA_command_line.sh -m full -sp ~/software/bitacora/Scripts/ -gp ~/software/bitacora/GeMoMa-1.7.1/GeMoMa-1.7.1.jar -n Labroides_dimidiatus -f /media/HDD/cleaner_fish/genome/All_genomes/Labroides_dimidiatus.gtf -p /media/HDD/cleaner_fish/genome/All_genomes/longest_pep/Labroides_dimidiatus.fasta -g /media/HDD/cleaner_fish/genome/All_genomes/Labroides_dimidiatus.fasta -q Cadherin_query.fasta -q ./ -t 32
```
#### CDH type 1
```bash
# if the name is same, use it
# Kang@fishlab3 Fri Jun 24 17:10:19 ~/Desktop/Annotation_database/swiss-prot
perl extract_seq_3.pl CDH_type1.id >CDH_type1.fasta
mv CDH_type1.fasta /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1_db.fasta
# Kang@fishlab3 Sun Jun 26 11:38:40 /media/HDD/cleaner_fish/genome/Cadherin_detection
muscle -in CDH_type1_db.fasta -out CDH_type1_db.aln
hmmbuild CDH_type1_db.hmm CDH_type1_db.aln
```
**RUN BITACORA**   
```bash
# Kang@fishlab3 Sun Jun 26 11:38:40 /media/HDD/cleaner_fish/genome/Cadherin_detection
nohup ~/software/bitacora/runBITACORA_command_line.sh -m full -sp ~/software/bitacora/Scripts/ -gp ~/software/bitacora/GeMoMa-1.7.1/GeMoMa-1.7.1.jar -n Labroides_dimidiatus -f /media/HDD/cleaner_fish/genome/All_genomes/Labroides_dimidiatus.gtf -p /media/HDD/cleaner_fish/genome/All_genomes/longest_pep/Labroides_dimidiatus.fasta -g /media/HDD/cleaner_fish/genome/All_genomes/Labroides_dimidiatus.fasta -q CDH_type1_db.fasta -q ./ -t 32 >runBITACORA.process 2>&1 &
```
**Filtering**   
```BITACORA_filter
#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use Cwd qw(cwd);
use Getopt::Long 'HelpMessage';

my $usage=<<_EOH_;;
----------------------------------------------------------------------------------------
This script is used to filter the output from BITACORA output
Note: please use the absolute directory for each input file.
Usage:
BITACORA_filter --query /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1_db.fasta
                --fasta /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1/CDH_type1_genomic_and_annotated_proteins_trimmed_idseqsclustered.fasta
                --gff3 /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1/CDH_type1_genomic_and_annotated_proteins_trimmed_idseqsclustered.gff3
                --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
Example:
1. --query: query fasta of the input for gene family detection
2. --fasta: the fasta file for filtering
3. --gff3: the gff3 file of fasta
4. --uniport: uniprot database
                                                Kang 2021-06-24
------------------------------------------------------------------------------------------
_EOH_
;

GetOptions(
        'query:s', \my $query, # query fasta file with uniprot identity
        'fasta:s', \my $fasta,
        'gff3:s', \my $gff,
        'uniprot:s', \ my $uniprot,
        );

unless ($query && $fasta && $gff && $uniprot) {
        die $usage;
}

mkdir "filtering" unless -d "filtering"; chdir "filtering";
my $dir = cwd;
print "Now i'm in $dir\n";
print "Now it's doing the filtering\n";
print "blastp to uniprot ... ...\n";

my %uni; my $uni_head;
open UNI, $uniprot or die "can not open $uniprot\n$!\n";
while (<UNI>) {
        chomp;
        if (/>/) {
                s/>//;
                my @a=split;
                $uni_head=$a[0];
        } else {
                $uni{$uni_head}.=$_;
        }
}

# align the resulted protein sequences to swissprot
system("blastp -outfmt 6 -query $fasta -out 1_bla -db $uniprot -num_threads 30");
my (%hash1, %hash2, %gff3);
my ($name1, $name2);
open AA, $fasta or die "can not open $fasta\n$!\n";
while (<AA>) {
        chomp;
        if (/>/) {
                s/>//;
                s/\_\d+dom$//;
                $name1=$_;
        } else {
                $hash1{$name1}.=$_;
        }
}
close AA;

open GFF, $gff or die "can not open $gff\n$!\n";
while (<GFF>) {
        chomp;
        my @a=split;
        if ($a[2] eq "mRNA") {
                (my $name)=$_=~/ID\=(.*?)\;/;
                if ($a[6] eq "+") {
                        $hash2{$name}=$a[0]."\t".$a[2]."\t".$a[3]."\t".$a[4]."\t+";
                } elsif ($a[6] eq "-") {
                        $hash2{$name}=$a[0]."\t".$a[2]."\t".$a[4]."\t".$a[3]."\t-";
                }
                $gff3{$name}=$_."\n";
        }
        if ($a[2] eq "CDS" && /Parent\=(.*?)\;/) {
                $gff3{$1}.=$_."\n";
        }
}
# result: 1_bla
close GFF;

# Get best blast
print "The blastp to uniprot is finished\n";

my (%best_bla, %num);
my @best;
open BLA, "1_bla" or die "can not open 1_bla\n$!\n";
while (<BLA>) {
        chomp;
        my @a=split;
        $num{$a[0]}++;
        push @best, $a[0] if $num{$a[0]}==1;
        if ($best_bla{$a[0]} && ($best_bla{$a[0]}->{'score'} < $a[-1])) {
                $best_bla{$a[0]}={
                        'score' => $a[-1],
                        'info'  => $_
                };
        } else {
                $best_bla{$a[0]}={
                        'score' => $a[-1],
                        'info'  => $_
                };
        }
}
close BLA;

open BEST, ">2_bestBla" or die "can not create 2_bestBla\n$!\n";
foreach my $best (@best) {
        print BEST "$best_bla{$best}->{'info'}\n";
}
# result: 2_bestBla
die "2_bestBla is empty\n" if (-z "2_bestBla");

# Filter the hit with "keyword" in annotation
my $SWIS_ano="/home/Kang/Desktop/Annotation_database/swiss-prot/unprot_name_description.txt";
my (%SWIS_ANO, %SWIS_ANO1);
open SWIS_ANO, $SWIS_ano or die "There is no $SWIS_ano\n$!\n";
while (<SWIS_ANO>) {
        chomp;
        my @a=split /\t/;
        (my $name)=$a[0]=~/sp\|.*\|(.*)\_.*/;
        (my $iden)=$a[0]=~/sp\|(.*)\|.*\_.*/;
        $SWIS_ANO{$a[0]}=$a[1];
        $SWIS_ANO1{$iden}=$name;
}
close SWIS_ANO;

my %que;
open QUE, $query or die "can not open $query\n$!\n";
while (<QUE>) {
        chomp;
        if (/>/) {
                s/>//;
                my $name=$SWIS_ANO1{$_};
                $que{$name}++;
        }
}

open BESTBLA, "$dir/2_bestBla" or die "can not open 2_bestBla\n$!\n";
open POTEN, ">$dir/3_poten" or die "can not create 3_poten$!\n"; # result: 3_poten
while (<BESTBLA>) {
        chomp;
        my @a=split /\t/;
        (my $name)=$a[1]=~/sp\|.*\|(.*)\_/;
        my $info=$SWIS_ANO{$a[1]};
        if ($que{$name}) {
                my $iden =$a[2];
                $a[0]=~s/\_\d+dom$//;
                my $len1=length($hash1{$a[0]});
                my $len2=length($uni{$a[1]});
                my $align=($a[7]-$a[6])/$len1*100;
                $align=sprintf("%.3f", $align);
                print POTEN "$a[0]\t$len1\t$len2\t$hash2{$a[0]}\t$iden\t$align\t$a[1]\t$info\n";
        }
}
chdir "../";
close BESTBLA;
close POTEN;

open SORTA, ">$dir/4_sort" or die "can not create 4_sort\n$!\n";
print SORTA "pep_id\tLen_query\tLen_subject\tChr\tStart/Stop\tStart/Stop\tDirection\tAlign_ratio\tGene_name\tGene_info\n";
system("sort -k4,5n $dir/3_poten >> $dir/4_sort");
close SORTA;

open SORTA, "$dir/4_sort" or die "can not open 4_sort\n$!\n";
open SORTA_AA, ">$dir/4_sort_aa.fa" or die "can not create 4_sort_aa.fa\n$!\n";
open SORTA_GTF, ">$dir/4_sort.gtf" or die "can not create 4_sort.gtf\n$!\n";
# create the fasta and gff
while (<SORTA>) {
        chomp;
        my @a=split /\t/;
        my $name=$a[0];
        print SORTA_AA ">$name\n$hash1{$name}\n" if $hash1{$name};
        print SORTA_GTF "$gff3{$name}" if $hash2{$name};
}

close SORTA;
close SORTA_AA;
close SORTA_GTF;
```
```bash
# /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1
BITACORA_filter --query /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1_db.fasta --fasta /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1/CDH_type1_genomic_and_annotated_proteins_trimmed_idseqsclustered.fasta --gff3 /media/HDD/cleaner_fish/genome/Cadherin_detection/CDH_type1/CDH_type1_genomic_and_annotated_proteins_trimmed_idseqsclustered.gff3 --uniprot ~/Desktop/Annotation_database/swiss-prot/uniprot-filtered-reviewed_yes.fasta
cd filtering
```

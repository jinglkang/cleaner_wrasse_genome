use strict;
use warnings;

use File::Basename;
use Getopt::Long 'HelpMessage';

my $usage=<<_EOH_;;
--------------------------------------------------------------------------------------------------------------------------------
This script is used to prepare the input for PAML
Usage: 
perl prepare_input_paml.pl --input ortho_list.txt --seq_dir . --cor_list correlation.txt --output .
Example:
1. --input:
the first column is the protein sequence id of reference, the other columns are the nucleotide sequences of each species
# orth_id	reference_protein	spe1_nuc	spe2_nuc	spe3_nuc	spe4_nuc	spe5_nuc	spe6_nuc
OG0000014	sp|O62714|CASR_PIG	Apoly_6299	Padel_40993	Daru_99354	Acura_116661	Ocomp_39102	Pmol_166022
OG0000021	sp|Q9JHX4|CASP8_RAT	Apoly_3749	Padel_10792	Daru_24893	Acura_7918	Ocomp_30861	Pmol_46346
OG0000035	sp|O14936|CSKP_HUMAN	Apoly_14462	Padel_8374	Daru_143421	Acura_125242	Ocomp_155787	Pmol_97813
OG0000047	sp|P30568|GSTA_PLEPL	Apoly_17254	Padel_33286	Daru_13087	Acura_32119	Ocomp_171369	Pmol_47987
2. --seq_dir:
directory of sequences
3. --cor_list:
refer 	reference_protein.fasta		# the first row of cor_list (the column 1 of input) are the id of reference protein sequences
spe1 	spe1.fasta					# the second row of cor_list (the column 2 of input) are the nucleotide sequences of spe1
spe2 	spe2.fasta					# the third row of cor_list (the column 3 of input) are the nucleotide sequences of spe2
... 	...							...
Options:
	--input			the list of orthologous genes, which should include the reference protein sequences id
					and the nucleotide sequences per species
	--seq_dir		the directory of nucleotide sequences and reference protein sequences
	--cor_list		the corresponding list between species and sequence fasta file
	--output,-o 	the directory of the output results
	--help,-h 		Print this help
								
								Kang 2021-7-12
--------------------------------------------------------------------------------------------------------------------------------
_EOH_
;

GetOptions('input:s', \ my $input,
	'seq_dir:s', \ my $seq_dir,
	'cor_list:s', \ my $cor_list,
	'output:s', \ my $output,
	'help', \ my $help
	);

if ($help || (! $input) || (! $seq_dir) || (! $cor_list) || (! $output)) {
	die $usage; # all of these options are mandatory requirements
}

my $pwd=`pwd`;
chomp($pwd);

open COR, "$cor_list" or die "can not open $cor_list\n";
my $i=0;
my (%seq, %spe);
my @spe;
while (<COR>) {
	chomp; $i++; my @a=split;
	my $seq_id;
	my $seq; 
	my $species=$a[0];
	push @spe, $species if $i > 1;
	$spe{$i}=$species;
	open FIL, "$seq_dir/$a[1]" or die "can not open $seq_dir/$a[1]\n";
	while (<FIL>) {
		chomp;
		if (/>/) {
			s/>//; my @a=split;
			$seq_id=$a[0];
		} else {
			$seq{$i}->{$seq_id} .= $_;
		}
	}
}

mkdir $output unless (-e $output);

open INPUT, "$input" or die "can not open $input\n";
while (<INPUT>) {
	chomp;
	my @a=split;
	my $orth_id=$a[0];
	for (my $i = 0; $i < @a; $i++) {
		if ($i==0) {
			mkdir "$output/$a[0]" unless (-e "$output/$a[0]");
		} else {
			my $species=$spe{$i};
			my $seq_id=$a[$i];
			my $seq=$seq{$i}->{$seq_id};
			my $file=$species.".fasta";
			open FILE, ">$output/$a[0]/$file" or die "can not create $output/$a[0]/$file\n";
			print FILE ">$species\n$seq\n";
		}
	}
	open TEMP, ">$output/$a[0]/temp_wise";
	foreach my $spe (@spe) {
		my $genewise=`genewise -quiet -genesf -pseudo -both $output/$a[0]/refer.fasta $output/$a[0]/$spe.fasta`;
		print TEMP $genewise;
		# output: multiple_sequence.out temp_wise
	}
	chdir "$output/$a[0]/";
	`perl /home/Kang/software/bin/DealGeneWise_both.pl -i temp_wise -q refer.fasta`;
	# clustal && Gblocks
	open FIL1, "multiple_sequence.out" or die "can not open multiple_sequence.out\n";
	open OUTPUT, ">multiple_sequence.out.mod-1" or die "can not create multiple_sequence.out.mod-1";
	while (<FIL1>) {
        chomp;
        if (/^[A-Z]/) {
        	my @a=split;
            (my $spe)=$a[0];
            $a[1]=~s/N/-/gi;
            $a[1]=~s/\d/-/gi;
            print OUTPUT ">$spe\n$a[1]\n";
        }
    }
    `clustalo -i multiple_sequence.out.mod-1 -t DNA -o multiple_sequence.out.mod --outfmt=fa`;
    `Gblocks multiple_sequence.out.mod -b4=10 -b5=n -b3=5 -t=c`; # output "multiple_sequence.out.mod-gb"
    open FIL2, "multiple_sequence.out.mod-gb" or die "can not open multiple_sequence.out.mod-gb\n";
    open FIL3, ">multiple_sequence.out.mod-gb-1" or die "can not create multiple_sequence.out.mod-gb-1\n";
    open FIL4, ">final_alignment.fa" or die "can not create multiple_sequence.out.mod-gb-1\n";
    my $SPE; my (%hash1, %hash2);
    while (<FIL2>) {
    	chomp;
    	if (/>/) {
    		s/>//; $SPE=$_;
    	} else {
    		s/ //g; s/\d/-/g;
    		$hash1{$SPE}.=$_;
    	}
    }
    my $i=0;
    foreach my $spe (@spe) {
    	my $seq=$hash1{$spe};
    	for (my $i = 0; $i < length($seq); $i+=3) {
    		my $codon=substr($seq,$i,3);
    		if ($codon=~/taa/i||$codon=~/tga/i||$codon=~/tag/i) {
    			$codon="---"; # replace stop codon to gap
    		}
    		$hash2{$spe}.=$codon;
    	}
    	$i++; if ($i==1) {
    		my $num=@spe; my $len=length($hash2{$spe});
    		print FIL3 "$num  $len\n";
    		print FIL3 "$spe  $hash2{$spe}\n";
    		print FIL4 ">$spe\n$hash2{$spe}\n";
    	} else {
    		print FIL3 "$spe  $hash2{$spe}\n";
    		print FIL4 ">$spe\n$hash2{$spe}\n";
    	}
    }
    # check gaps in the sequences
    open FIL3, "multiple_sequence.out.mod-gb-1";
    open FIL5, ">>$pwd/final_orth_input_paml.txt";
    my $j=-1;
    while (<FIL3>) {
    	chomp;
    	my @a=split; $j++;
    	my $len=$a[1] if $j==1 && $a[1];
    	if ($a[1]=~/n|-/i) {
    		last;
    	}
    	if ($j==@spe && $len && $len>=150) {
    		print FIL5 "$orth_id\n";
    	}
    }
    `mv multiple_sequence.out.mod-gb-1 final_alignment.phy`;
    `rm multiple_sequence.out.mod-1 multiple_sequence.out.mod-gb`;
    chdir "$pwd";
}

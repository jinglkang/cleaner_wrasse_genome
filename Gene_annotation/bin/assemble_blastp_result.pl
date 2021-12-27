#!/usr/bin/perl
use strict;
use warnings;

my %query;
my $name;
my @names;
open FASTA, "braker2+3_combined_renamed.aa.long.fa";
while (<FASTA>) {
        chomp;
        if (/>/) {
                s/>//;
                my @a=split;
                (my $name1)=$a[0]=~/(.*g\d+)t\d+/;
                (my $name2)=$a[0]=~/.*g\d+(t\d+)/;
                $name=$name1.".".$name2;
                push @names, $name;
        } else {
                $query{$name}=length($_);
        }
}

my (%swis_blastp, %swis_info);
my $swis_info="/home/kang1234/swiss-prot/swiss_pro_info.txt";
open SWIS_INFO, $swis_info or die "can not open $swis_info\n";
while (<SWIS_INFO>) {
        chomp;
        my @a=split /\t/;
        my $uni_acc=$a[0];
        $swis_info{$uni_acc}={
                'gene_name' => $a[1],
                'length' => $a[2]
        };
}


my $swis="Ldim_blastp.result.best.txt";
open SWIS, $swis or die "can not open $swis\n";
while (<SWIS>) {
        chomp;
        my @a=split;
        (my $q_name1)=$a[0]=~/(.*g\d+)t\d+/;
        (my $q_name2)=$a[0]=~/.*g\d+(t\d+)/;
        my $q_name=$q_name1.".".$q_name2;
        my $iden=$a[2];
        my $q_a_len=$a[7]-$a[6]+1;
        my $s_a_len=$a[9]-$a[8]+1;
        my @b=split /\|/, $a[1];
        my $uni_acc=$b[1];
        $swis_blastp{$q_name}={
                'uni_acc' => $uni_acc,
                'iden' => $iden,
                'q_a_len' => $q_a_len,
                's_a_len' => $s_a_len
        };
}

my (%ref_blastp, %ref_info);
my $ref_info="/home/kang1234/refseq_vert_other/ref_pro_info.txt";
open REF_INFO, $ref_info or die "can not open $ref_info\n";
while (<REF_INFO>) {
        chomp;
        my @a=split /\t/;
        my $ref_acc=$a[0];
        $ref_info{$ref_acc}={
                'gene_name' => $a[1],
                'length' => $a[2]
        };
}

my $ref="Ldim_refseq_diamond.result.txt";
open REF, $ref or die "can not open $ref\n";
while (<REF>) {
        chomp;
        my @a=split;
        (my $q_name1)=$a[0]=~/(.*g\d+)t\d+/;
        (my $q_name2)=$a[0]=~/.*g\d+(t\d+)/;
        my $q_name=$q_name1.".".$q_name2;
        my $iden=$a[2];
        my $q_a_len=$a[7]-$a[6]+1;
        my $s_a_len=$a[9]-$a[8]+1;
        my $ref_acc=$a[1];
        $ref_blastp{$q_name}={
                'ref_acc' => $ref_acc,
                'iden' => $iden,
                'q_a_len' => $q_a_len,
                's_a_len' => $s_a_len
        };
}

foreach my $name (@names) {
        my $q_len=$query{$name};
        (my $newname)=$name=~/(.*)\.t\d+/;
        if ($swis_blastp{$name}) {
                my $uni_acc=$swis_blastp{$name}->{'uni_acc'};
                my $sub_len=$swis_info{$uni_acc}->{'length'};
                my $s_a_len=$swis_blastp{$name}->{'s_a_len'};
                my $q_a_len=$swis_blastp{$name}->{'q_a_len'};
                my $iden=$swis_blastp{$name}->{'iden'};
                my $scov=($s_a_len/$sub_len)*100;
                my $genename=$swis_info{$uni_acc}->{'gene_name'};
                $scov=sprintf("%.2f",$scov);
                my $qcov=($q_a_len/$q_len)*100;
                $qcov=sprintf("%.2f",$qcov);
                print "$newname\tqcov=\"$qcov\";scov=\"$scov\";identity=\"$iden\";qlenth=\"$q_len\";slenth=\"$sub_len\";db_accession=\"$uni_acc\";db=\"swiss-prot\"\tName=\"$genename\"\n";
        } elsif ($ref_blastp{$name}) {
                my $ref_acc=$ref_blastp{$name}->{'ref_acc'};
                my $sub_len=$ref_info{$ref_acc}->{'length'};
                my $s_a_len=$ref_blastp{$name}->{'s_a_len'};
                my $q_a_len=$ref_blastp{$name}->{'q_a_len'};
                my $iden=$ref_blastp{$name}->{'iden'};
                my $scov=($s_a_len/$sub_len)*100;
                my $genename=$ref_info{$ref_acc}->{'gene_name'};
                $scov=sprintf("%.2f",$scov);
                my $qcov=($q_a_len/$q_len)*100;
                $qcov=sprintf("%.2f",$qcov);
                print "$newname\tqcov=\"$qcov\";scov=\"$scov\";identity=\"$iden\";qlenth=\"$q_len\";slenth=\"$sub_len\";db_accession=\"$ref_acc\";db=\"refseq\"\tName=\"$genename\"\n";
        } else {
                print "$newname\tqcov=\"-\";scov=\"-\";identity=\"-\";qlenth=\"-\";slenth=\"-\";db_accession=\"-\";db=\"-\"\tName=\"-\"\n";
        }
}

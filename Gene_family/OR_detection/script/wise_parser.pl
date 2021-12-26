#!/usr/bin/perl
my $usage=<<EOF;
-------------------------------------------
Before everything, maybe you should use best_genewise_finder.pl2 to get the best genewise result first.

Feed me with the text output of genewise (-pseudo -genesf). I'll give you four files: a gff file, three fasta files with protein, cds and dna sequences repectively, both are extended to start and stop codon. When trying to extend it to the start codon, if stop codon pop out first, then the process is given up.

Usage: perl $0 assembly *wise
        In the last column of gff file, 'F' stands for frame shift; 'P' premature stop codon; 'C' complete structure; 'T' truncated structure.
        In the aa sequence, ! stands for a frameshift, X a premature stop codon in alignment, * a premature stop codon in extention sequence, x an unknow aa in the extention sequence.

It's OK to have message like "Use of uninitialized value \$aheadaa/\$appendaa"
                                                                                Du Kang 2017-10-05
----------------------------------------------
EOF

$ARGV[1] or die $usage;
`cp $ARGV[1] tmp20171006`;
system (q#cat tmp20171006 |perl -ane 'chomp; print "\n" if /genewise \$Name:/;print $F[2]."\t" if /^Query protein/; if (/^Target Sequence/){$flag= length($F[2])>10? substr($F[2],0,10) : $F[2];print $F[2]."\t"} print $F[1]."\t" if /^Strand/; print $1."\t" if /^Score (.*) bits over entire alignment/; if(defined $flag&&/^$flag/){$pre =~ s/[A-Z|-]:([A-Z|x])\[[a-z]+\]/$1/g; $pre =~ s/\s|-//g; print $pre} print "\t" if /Gene 1$/; if (/Exon/){$F[4]=~tr/12/21/;print "$F[1]_$F[4],$F[2];"} $pre=$_' >tmp20171007#);

open FA, $ARGV[0] or die $usage;
while (<FA>) {
        chomp;
        if (/>/) {
                s/>//g;
                @_=split;
                $name=$_[0];
        }else{
                $seq{$name}.=$_;
        }
}

open WISE, "tmp20171007" or die $usage;
while (<WISE>) {
        next if /^\s+$/;
        chomp;
        @_=split /\t/, $_;
        $protein=$_[0];
        $scaf=$_[1];
        $strand=$_[2] eq 'forward'? '+' : '-';
        $score=$_[3];
        $aa=$_[4];
        $pos= $_[-1];
        chop $pos;
        @pos=split /,/, $pos;
        $first_phase=chop $pos[0];
        chop $pos[0];
        $start= $strand eq '+'? $pos[0]-1 : $pos[-1]-1;
        $oldstart=$start;
        $end= $strand eq '+'? $pos[-1]-1 : $pos[0]-1;
        $oldend=$end;

        # if on the forward strand
        if ($strand eq '+') {
                $refseq=$seq{$scaf};
                $reflen= length($refseq);

                # for loop to locate the start codon
                for ($i=$oldstart; $i>=0; $i-=3) {
                        $flag=substr($refseq,$i,3);
                        if ($flag=~/TAG|TAA|TGA/i){             # if stop codon was found earlier than start codon, then give up.  2019.02.08
                                last;
                        }elsif($flag=~/ATG/i){
                                $start=$i;
                                last;
                        }
                }

                # for loop to locate the stop codon
                for ($i=$oldend+1; $i<$reflen; $i+=3) {
                        $flag=substr($refseq,$i,3);
                        if ($flag=~/TAG|TAA|TGA/i) {
                                $end=$i+2;
                                last;
                        }
                }

                # get the dna sequence
                $dnaseq = substr ($refseq,$start,$end-$start+1);

                # get the aa sequence
                $ahead = substr ($refseq, $start, $oldstart-$start);
                $aheadaa = &cds2aa($ahead);
                $append = substr ($refseq, $oldend+1, $end-$oldend);
                $appendaa = &cds2aa($append);
                $aaseq=$aheadaa.$aa.$appendaa;

#               $fflag= ($aaseq=~/^M.*\*$/ && $aaseq!~/\*\S/ && $aaseq!~/\!/ && $aaseq!~/X/)? 'F' : 'P';
#               $fflag= $aaseq=~/\!/ ? 'F' : $aaseq=~/\*\S|X|x/ ? 'P' : $aaseq=~/^M.*\*$/ ? 'C' : 'T';
                $fflag= $aaseq=~/\!/ ? 'F' : $aaseq=~/\*\S/ ? 'P' : $aaseq=~/x/i ? 'P' : $aaseq=~/^M.*\*$/ ? 'C' : 'T';

                # rebuild the position information and make the first line of gff
                $newstart=$start+1;
                $pos[0]=$newstart."_$first_phase";
                $pos[-1]=$end+1;
                $name="$scaf:$newstart:$pos[-1]-$fflag:$strand";
                $pos=join (",",@pos);
                $gff = "$scaf\tGeneWise\tmatch\t$newstart\t$pos[-1]\t$score\t$strand\t\.\t$name-$protein\n";

                # get the cds sequence and rest of gff
                @newpos=split /;/, $pos;
                foreach $block (@newpos) {
                        $block =~ /(\d+)_(\d),(\d+)/;
                        $s=$1; $e=$3; $phase=$2;
                        $intronend=$s-1;
                        $gff .= "$scaf\tGeneWise\tintron\t$intronstart\t$intronend\t0.00\t$strand\t\.\t$name-$protein\n" if defined $intronstart;
                        $gff .= "$scaf\tGeneWise\tcds\t$s\t$e\t0.00\t$strand\t$phase\t$name-$protein\n";
                        $intronstart=$e+1;
                        $a=$s-1;
                        $b=$e-1;
                        $cdsseq .= substr($refseq,$a,$b-$a+1);
                }
        }

        # if on the reverse strand
        if ($strand eq '-') {
                $seq{$scaf} =~ tr /atcgATCG/tagcTAGC/;
                $refseq=$seq{$scaf};
                $reflen=length($refseq);

                # for loop to locate the start codon
                for ($i=$oldend-2; $i<$reflen;$i+=3) {
                        $flag=reverse (substr($refseq,$i,3));
                        if ($flag=~/TAG|TAA|TGA/i){             # 2019.02.08
                                last;
                        }elsif ($flag=~/ATG/i){
                                $end=$i+2;
                                last;
                        }
                }

                # for loop to locate the end codon
                for ($i=$oldstart; $i>=0; $i-=3) {
                        $flag=reverse (substr($refseq,$i,3));
                                if ($flag=~/TAG|TAA|TGA/i) {
                                        $start=$i;
                                        last;
                                }
                }

                # get the dna sequence
                $dnaseq = reverse (substr ($refseq,$start,$end-$start+1));

                # get the aa sequence
                $append = reverse (substr ($refseq, $start, $oldstart-$start));
                $appendaa = &cds2aa($append);
                $ahead = reverse (substr ($refseq, $oldend+1, $end-$oldend));
                $aheadaa = &cds2aa($ahead);
                $aaseq=$aheadaa.$aa.$appendaa;

#               $fflag= ($aaseq=~/^M.*\*$/ && $aaseq!~/\*\S/ && $aaseq!~/\!/ && $aaseq!~/X/)? 'F' : 'P';
#               $fflag= $aaseq=~/\!/ ? 'F' : $aaseq=~/\*\S|X|x/ ? 'P' : $aaseq=~/^M.*\*$/ ? 'C' : 'T';
                $fflag= $aaseq=~/\!/ ? 'F' : $aaseq=~/\*\S|X/ ? 'P' : $aaseq=~/^M.*\*$/ ? 'C' : 'T';

                # rebuild the position information and make the first line of gff
                $newstart=$end+1;
                $pos[0]=$newstart."_$first_phase";
                $pos[-1]=$start+1;
                $name="$scaf:$newstart:$pos[-1]-$fflag:$strand";
                $pos=join (",",@pos);
                $gff = "$scaf\tGeneWise\tmatch\t$newstart\t$pos[-1]\t$score\t$strand\t\.\t$name-$protein\n";

                # get the cds sequence and the rest of gff
                @newpos=split /;/, $pos;
                foreach $block (@newpos) {
                        $block =~ /(\d+)_(\d),(\d+)/;
                        $s=$1;$e=$3;$phase=$2;
                        $intronend=$s+1;
                        $gff .= "$scaf\tGeneWise\tintron\t$intronstart\t$intronend\t0.00\t$strand\t\.\t$name-$protein\n" if defined $intronstart;
                        $gff .= "$scaf\tGeneWise\tcds\t$s\t$e\t0.00\t$strand\t$phase\t$name-$protein\n";
                        $intronstart=$e-1;
                        $a=$s-1;
                        $b=$e-1;
                        $cdsseq = substr($refseq,$b,$a-$b+1).$cdsseq;
                }
                $cdsseq=reverse $cdsseq;

                $seq{$scaf} =~ tr /atcgATCG/tagcTAGC/;
                # very important here, restore the sequence, otherwise, if this scaffold shows up again, the sequence you have would not be the orignal one. No wander the wrong result always happened in scaffolds showing up multiple times.
        }
        $gff .= "\/\/\n";

        # print out to four files, *aa, *cds, *dna and *gff.
        $fileout= $ARGV[1]=~/.*\/(.*)/ ? $1 : $ARGV[1];
        open AA, ">>$fileout\.aa" or die $!;
        print AA ">$name\n$aaseq\n";
        close AA;
        open CDS, ">>$fileout\.cds" or die $!;
        print CDS ">$name\n$cdsseq\n";
        close CDS;
        open DNA, ">>$fileout\.dna" or die $!;
        print DNA ">$name\n$dnaseq\n";
        close DNA;
        open GFF, ">>$fileout\.gff" or die $!;
        print GFF $gff;
        close GFF;

        undef $dnaseq;
        undef $aaseq;
        undef $cdsseq;
        undef $gff;
        undef $intronstart;
}

`rm tmp20171006 tmp20171007`;

# ---------------------------------------------------------------- subroutine
sub cds2aa {
        undef $out;
        my $in = uc(shift @_);
        my(%genetic_code) = (
        'TCA' => 'S',    # Serine
        'TCC' => 'S',    # Serine
        'TCG' => 'S',    # Serine
        'TCT' => 'S',    # Serine
        'TTC' => 'F',    # Phenylalanine
        'TTT' => 'F',    # Phenylalanine
        'TTA' => 'L',    # Leucine
        'TTG' => 'L',    # Leucine
        'TAC' => 'Y',    # Tyrosine
        'TAT' => 'Y',    # Tyrosine
        'TAA' => '*',    # Stop
        'TAG' => '*',    # Stop
        'TGC' => 'C',    # Cysteine
        'TGT' => 'C',    # Cysteine
        'TGA' => '*',    # Stop
        'TGG' => 'W',    # Tryptophan
        'CTA' => 'L',    # Leucine
        'CTC' => 'L',    # Leucine
        'CTG' => 'L',    # Leucine
        'CTT' => 'L',    # Leucine
        'CCA' => 'P',    # Proline
        'CCC' => 'P',    # Proline
        'CCG' => 'P',    # Proline
        'CCT' => 'P',    # Proline
        'CAC' => 'H',    # Histidine
        'CAT' => 'H',    # Histidine
        'CAA' => 'Q',    # Glutamine
        'CAG' => 'Q',    # Glutamine
        'CGA' => 'R',    # Arginine
        'CGC' => 'R',    # Arginine
        'CGG' => 'R',    # Arginine
        'CGT' => 'R',    # Arginine
        'ATA' => 'I',    # Isoleucine
        'ATC' => 'I',    # Isoleucine
        'ATT' => 'I',    # Isoleucine
        'ATG' => 'M',    # Methionine
        'ACA' => 'T',    # Threonine
        'ACC' => 'T',    # Threonine
        'ACG' => 'T',    # Threonine
        'ACT' => 'T',    # Threonine
        'AAC' => 'N',    # Asparagine
        'AAT' => 'N',    # Asparagine
        'AAA' => 'K',    # Lysine
        'AAG' => 'K',    # Lysine
        'AGC' => 'S',    # Serine
        'AGT' => 'S',    # Serine
        'AGA' => 'R',    # Arginine
        'AGG' => 'R',    # Arginine
        'GTA' => 'V',    # Valine
        'GTC' => 'V',    # Valine
        'GTG' => 'V',    # Valine
        'GTT' => 'V',    # Valine
        'GCA' => 'A',    # Alanine
        'GCC' => 'A',    # Alanine
        'GCG' => 'A',    # Alanine
        'GCT' => 'A',    # Alanine
        'GAC' => 'D',    # Aspartic Acid
        'GAT' => 'D',    # Aspartic Acid
        'GAA' => 'E',    # Glutamic Acid
        'GAG' => 'E',    # Glutamic Acid
        'GGA' => 'G',    # Glycine
        'GGC' => 'G',    # Glycine
        'GGG' => 'G',    # Glycine
        'GGT' => 'G',    # Glycine
        );
        for $codon ($in =~ /(...)/g) {
                $out .= exists $genetic_code{$codon}? $genetic_code{$codon} : 'x';
        }
        return $out;
}

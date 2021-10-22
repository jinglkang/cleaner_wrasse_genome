# Phylogeny
-----------
## Mitochondrial genes: COI, 12S, 16S
### Species (NCBI: Nucleotide --> search "Thamnaconus septentrionalis mitochondrion, complete genome")
**Labridae** (10 species): 5 Labroides; 1 Symphodus; 1 Labrus; 1 Thalassoma; 1 Cheilinus; 1 Notolabrus.     
*Labrodies dimdiatus* (sequences from our genome and a individual from NCBI), *L. phthirophagus*, *L. bicolor*, *L. pectoralis*, *L. rubrolabiatus*     
Symphodus melops, Labrus bergylta, *Thalassoma bifasciatum*, *Cheilinus undulatus*, *Notolabrus celidotus*    
**outgroup**: Eupercaria ()     
Eupercaria; Perciformes; Serranoidei; Serranidae; Epinephelinae; Epinephelini; Epinephelus; Epinephelus fuscoguttatus    
Eupercaria; Centrarchiformes; Centrarchoidei; Centrarchidae; Micropterus; Micropterus salmoides    
Eupercaria; Lutjaniformes; Lutjanidae; Lutjanus; Lutjanus erythropterus     
Eupercaria; Sciaenidae; Sciaenops; Sciaenops ocellatus     
Eupercaria; Chaetodontiformes; Chaetodontidae; Chelmon; Chelmon rostratus     
Eupercaria; Tetraodontiformes; Monacanthidae; Thamnaconus; Thamnaconus septentrionalis     
Eupercaria; Lophiiformes; Antennarioidei; Antennariidae; Antennarius; Antennarius maculatus       
Eupercaria; Scatophagidae; Scatophagus; Scatophagus argus        
Eupercaria; Spariformes; Sparidae; Acanthopagrus; Acanthopagrus latus      
Eupercaria; Lobotiformes; Datnioididae; Datnioides; Datnioides undecimradiatus     
Eupercaria; Moronidae; Morone; Morone chrysops     
Eupercaria; Pempheriformes; Lateolabracidae; Lateolabrax; Lateolabrax maculatus  
Danio rerio (zebrafish)     
***
### before concatenated the sequences of three mito genes
working dir: my own workstation (~/Desktop/cleaner_fish/mito_phy)    
download the sequences, and put all sequences to one file according genes      
```perl
#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
        'fasta:s{1,}', \my @fasta,      # the overall reads number matrix
        );

if (! @fasta) {
        die "pls give me some fasta file with required names\n";
}

foreach my $fa (@fasta) {
        open FA, "$fa" or die "can not open $fa\n";
        (my $spe)=$fa=~/(.*?)\..*\.fasta/;
        my $seq;
        while (<FA>) {
                chomp;
                next if /^\>/ || /^\s+/;
                $seq.=uc($_);
        }
        $seq=~s/^\s+//;
        print ">$spe\n$seq\n";
}
```

```bash
perl temp1.pl --fasta *.12S.fasta >12S.fasta
perl temp1.pl --fasta *.16S.fasta >16S.fasta
perl temp1.pl --fasta *.COI.fasta >COI.fasta
```
**align by Muscle**    
trim flanking regions, for COI (keep the sequences can be translated to pep), for 12S and 16S (delete the postion if any species includes a gap), and concatenated the sequences of three genes per species       
```perl
#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long 'HelpMessage';

GetOptions(
        'fasta:s{1,}', \my @fasta,      # the overall reads number matrix
        'out:s', \my $out # prefix name of the output
        );

if (! @fasta || (! $out) ) {
        die "pls give me some fasta file with required names, or did you forget the output name\n";
}

my %hash;
my (@spe);
my $j;
foreach my $fa (@fasta) {
        $j++;
        open FA, "$fa" or die "can not open $fa\n";
        (my $gene)=$fa=~/(.*?)_align.*\.fasta/;
        my ($spe, $seq);
        my $i;
        while (<FA>) {
                chomp;
                if (/>/) {
                        s/>//;
                        $i++;
                        $spe=$_;
                        push @spe, $spe if $j==1;
                } elsif ($hash{$spe}) {
                        $hash{$spe} .= $_;
                        my $len=length($_);
                        print "$gene\t$len\n" if $i==1;
                } else {
                        $hash{$spe} = $_;
                        my $len=length($_);
                        print "$gene\t$len\n" if $i==1;
                }
        }
        close FA;
}

my $output=$out.".fasta";
open OUTPUT, ">$output" or die "can not create $output";

foreach my $spe (@spe) {
        print OUTPUT ">$spe\n$hash{$spe}\n";
}
close OUTPUT;
```
```bash

```

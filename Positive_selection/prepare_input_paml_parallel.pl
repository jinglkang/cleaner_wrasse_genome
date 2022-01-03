use strict;
use warnings;
use Parallel::ForkManager;

# prepare_input_paml.pl
my $fm=$ARGV[0];
system("mkdir temp");

my @cmds;
open FM, $fm or die "can not open $fm\n";
while (<FM>) {
	chomp; my @a=split;
	my $temp=$a[0].".txt";
	open TEMP, ">temp/$temp" or die "can not create >temp/$temp\n";
	print TEMP "$_\n";
	my $cmd="perl prepare_input_paml.pl --input temp/$temp --seq_dir . --cor_list correlation.txt --output .";
	push @cmds, $cmd;
}

my $manager = new Parallel::ForkManager(10);
foreach my $cmd (@cmds) {
	$manager->start and next;
	system($cmd);
	$manager->finish;
}
$manager -> wait_all_children;
system("rm -rf temp/");

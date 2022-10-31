#!\strawberry\perl\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl renameheaders.pl <filename>.fasta

use 5.22.1;
use warnings;
use diagnostics;

my $file = $ARGV[0];

open (IN, "<", $file)
	or die "Couldn\'t open infile: $!\n"; 
my $root = substr $file, 0, -6;
my $outfile = $root.'.renamed.fasta';
my $outfile2 = $root.'.legend.txt';
open (OUT, ">", "$outfile") 
	or die "Couldn\'t save fasta: $!\n";
open (OUT2, ">", "$outfile2") 
	or die "Couldn\'t save txt: $!\n";
my $count = 0;
for (my $line = <IN>; $line; $line = <IN>) {					#read input line by line
	chomp ($line);
	if (substr ($line, 0, 1) eq '>') {
		$count++;
		my @checkcount = split "_", $line;
		if (defined $checkcount[1]) {
			my $value = $checkcount[1];
			print OUT '>File'."$root".'.seq'."$count".'_'."$value\n";
		} else {
			print OUT '>File'."$root".'.seq'."$count".'_'."1\n";
		};
		print OUT2 "$checkcount[0]\t".'>File'."$root".'-seq'."$count\n";
	} else {
		print OUT "$line\n";
	};
};
close (IN);
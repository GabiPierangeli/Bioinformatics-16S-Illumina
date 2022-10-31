#!\strawberry\perl\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl checkforseqswithN.pl <filename>.fasta

use 5.22.1;
use warnings;
use diagnostics;

my $file = $ARGV[0];

open (IN, "<", $file)
	or die "Couldn\'t open infile: $!\n"; 
my $root = substr $file, 0, -6;
my $outfile = $root.'.ok.fasta';

open (OUT, ">", "$outfile") 
	or die "Couldn\'t save fasta: $!\n";

my $header = undef;
my $count = 0;
my $Ncount = 0;

for (my $line = <IN>; $line; $line = <IN>) {					#read input line by line
	chomp ($line);
	if (substr ($line, 0, 1) eq '>') {
		$count++;
		$header = $line;
	} else {
		if ($line !~ tr/ACGT//c) {
			print OUT "$header\n";
			print OUT "$line\n";
		} else {
			$Ncount++;
		};
	};
};
close (IN);

say "From a total of $count sequences, $Ncount had N characters and were removed"
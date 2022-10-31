#!\strawberry\perl\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl fastqtofasta.pl <filename>.fastq

use 5.22.1;
use warnings;
use diagnostics;

my $file = $ARGV[0];

open (OUT, ">", "$file.fasta")
	or die "Couldn\'t open file out: $!\n";

open (IN, "<", "$file")
	or die "Couldn\'t open file in: $!\n"; 


my $total = 0;
my $count = 1;

say "Reading file $file";

#Prepare another hash with IDs and sequences
	for (my $line = <IN>; $line; $line = <IN>) {					#read input line by line
		chomp ($line);
		$total++;
		if ($count == 1) {
			$count++;
			print OUT "$line\n";
		} elsif ($count == 2) {
			$count++;
			print OUT "$line\n";
		} elsif ($count == 3) {
			$count++;
		} elsif ($count == 4) {
			$count = 1;
		};
	};

$total = $total/4;
close(IN);
close (OUT);

say "$total sequences were transcribed"; 

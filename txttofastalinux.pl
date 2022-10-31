#!\usr\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl txttofastalinux.pl <filename-txt singlets>.txt

use 5.12.2;
use warnings;
use diagnostics;

# definitions
my $file = $ARGV[0];
my $outfile = undef;
my $total = 0;
my $header = undef;
my $fullheader = undef;
my $seq = undef;
my $readlength = 0;

say "Checking file $file";

open (IN, "<", "$file")
	or die "Couldn\'t open file 1: $!\n";
$outfile = substr $file, 0, -9;
$outfile = $outfile . '.singlets.fasta';

say "OK";

open (OUT, ">>", "$outfile")
	or die "Could\'t write file 1: $!\n'";

while (my $line = <IN>) {
	chomp ($line);
	if (substr ($line, 0, 1) eq ">") {					#see if line is a header
		$header = undef;
		$seq = undef;
		$fullheader = undef;
		$readlength = 0;
		$total ++;
		$header = $line;
	} else {
		$seq = $line;
		$seq =~ tr/-//;
		$readlength = length $seq;
		$fullheader = $header.':'.$readlength.'bp';
		print OUT "$fullheader\n";
		print OUT "$seq\n";
	}; 
};

close (IN);
close (OUT);

say "$total reads were copied into $outfile file."

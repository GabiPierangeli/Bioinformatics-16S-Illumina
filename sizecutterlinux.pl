#!\usr\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl sizecutterlinux.pl <filename>.fastq


use 5.12.2;
use warnings;
use diagnostics;

# definitions
my $counter = 1;
my @reads;
my $seq = undef;
my $file = $ARGV[0];
my $outfile = undef;
my $total = 0;
my $okreads =0;
my $cutreads =0;

say "Checking file $file";

open (IN, "<", $file)			
	or die "Couldn\'t open file 1: $!\n";
$outfile = substr $file, 0, -13;
$outfile = $outfile . 'cut.fastq';

say "OK";

my $cuttoffsize = 75;						#Change HERE for a different cuttoff; 75 bp for Illumina 2x250 or 2x300; 40bp for 2x100

open (OUT, ">>", $outfile)		
	or die "Could\'t write file 1: $!\n'";

while (my $line = <IN>) {
	chomp ($line);
	if ($counter == 1) {					#see if line is a header
			$total ++;
			@reads = undef;
			$seq = undef;
			$reads[0] = $line;
			$counter ++;
		} elsif ($counter == 2) {
			$reads[1] = $line;
			$seq = $line;
			$counter ++;
		} elsif ($counter == 3){
			$reads[2] = $line;
			$counter ++;
		} elsif ($counter == 4) {
			$reads[3] = $line;
			if (length $seq >= $cuttoffsize) {
				$okreads ++;
				print OUT "$reads[0]\n";
				print OUT "$reads[1]\n";
				print OUT "$reads[2]\n";
				print OUT "$reads[3]\n";
			} else {
				$cutreads ++;
			};
			$counter =1;
		};
	};

close (IN);
close (OUT);

say "From a total of $total reads, $okreads were greater than or equal $cuttoffsize base pairs and were copied into $outfile file. $cutreads reads were excluded."

#!\strawberry\perl\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl taxsummarytoexcel.pl <filename>.tax.summary

use 5.22.1;
use warnings;
use diagnostics;

my $file = $ARGV[0];

open (OUT, ">", "$file.tsv")
	or die "Couldn\'t open file out: $!\n";

print OUT "Domain\tPhylum\tClass\tOrder\tFamily\tGenus\tTotal\n";
	
open (IN, "<", $file)
	or die "Couldn\'t open file in: $!\n"; 

my $rank1 = undef;
my $rank2 = undef;
my $rank3 = undef;
my $rank4 = undef;
my $rank5 = undef;
my $rank6 = undef;
my $total = 0;
my $count = 0;
my @brokenline = undef;

say "Reading file $file";

#Prepare another hash with IDs and sequences
	for (my $line = <IN>; $line; $line = <IN>) {					#read input line by line
		chomp ($line);
		@brokenline = undef;
		@brokenline = split "\t", $line;
		if ($brokenline[0] eq "taxlevel") {
			next;
		};
		if ($brokenline[0] == 0) {
			$total = $brokenline[4];
		} elsif ($brokenline[0] ==1) {
			$rank1 = $brokenline[2];
		} elsif ($brokenline[0] ==2) {
			$rank2 = $brokenline[2];
		} elsif ($brokenline[0] ==3) {
			$rank3 = $brokenline[2];
		} elsif ($brokenline[0] ==4) {
			$rank4 = $brokenline[2];
		} elsif ($brokenline[0] ==5) {
			$rank5 = $brokenline[2];
		} elsif ($brokenline[0] ==6) {
			print OUT "$rank1\t$rank2\t$rank3\t$rank4\t$rank5\t$brokenline[2]\t$brokenline[4]\n";
			$count += $brokenline[4];
		};
	};

close(IN);
close (OUT);

say "$count sequences were counted; the expected total was $total"; 

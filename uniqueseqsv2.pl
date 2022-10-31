#!\strawberry\perl\bin\perl

#Program designed by Gustavo B. Gregoracci (gregoracci@unifesp,br) - DCMar - IMar - UNIFESP BS - Brazil
#Usage: perl uniqueseqs2.pl <filename>.fasta

use 5.21.1;
use warnings;
use diagnostics;

my $file = $ARGV[0];

open (IN, "<", "$file") 
	or die "Couldn\'t open table: $!\n";
my $root = substr $file, 0, -6;
my $outputlocation = "$root".'.unique.fasta';
open (OUT1, ">", "$outputlocation") 
	or die "Couldn\'t save outfile: $!\n";
my $outputlocation2 = "$root".'.list.names';
open (OUT2, ">", "$outputlocation2") 
	or die "Couldn\'t save outfile2: $!\n";

say 'Reading fasta file';

my %hugehash = ();
my $count = 0;
my $header = undef;

for (my $line = <IN>; $line; $line = <IN>) {					#read input line by line
	chomp $line;
	if (substr ($line, 0, 1) eq '>') {
		$count++;
		$header = substr $line, 1;
	} else {
		my $reverse = reverse $line;
		my $complement = $line;
		$complement =~ tr/ATGCatgc/TACGtacg/;
		my $reversecomplement = $reverse;
		$reversecomplement =~ tr/ATGCatgc/TACGtacg/;
		if (exists $hugehash{$line}) {
			if (defined $hugehash{$line}) {
				my @headerlist = split ";", $hugehash{$line};
				push @headerlist, $header;
				my $newheaderlist = join ";", @headerlist;
				$hugehash{$line} = $newheaderlist;
			} else {
				delete $hugehash{$line};
			};
		} elsif (exists $hugehash{$reverse}) {
			if (defined $hugehash{$reverse}) {
				my @headerlist = split ";", $hugehash{$reverse};
				push @headerlist, $header;
				my $newheaderlist = join ";", @headerlist;
				$hugehash{$reverse} = $newheaderlist;
			} else {
				delete $hugehash{$reverse};
			};
		} elsif (exists $hugehash{$complement}) {
			if (defined $hugehash{$complement}) {
				my @headerlist = split ";", $hugehash{$complement};
				push @headerlist, $header;
				my $newheaderlist = join ";", @headerlist;
				$hugehash{$complement} = $newheaderlist;
			} else {
				delete $hugehash{$complement};
			};
		} elsif (exists $hugehash{$reversecomplement}) {
			if (defined $hugehash{$reversecomplement}) {
				my @headerlist = split ";", $hugehash{$reversecomplement};
				push @headerlist, $header;
				my $newheaderlist = join ";", @headerlist;
				$hugehash{$reversecomplement} = $newheaderlist;
			} else {
				delete $hugehash{$reversecomplement};
			};
		} else {
			$hugehash{$line} = $header;
		};
	};
};

close (IN);

say "$count headers were read";
my $checkcount = keys %hugehash;
say "$checkcount unique sequences were found";

foreach my $sequence (sort keys %hugehash) {
	my @headerlist = split ";", $hugehash{$sequence};
	my $reps = scalar @headerlist;
	my @modelheader = split "\_", $headerlist[0];
	my $model = $modelheader[0];
	print OUT1 ">$model".'_'."$reps\n";
	my $allheaders = $hugehash{$sequence};
	$sequence =~ tr/-//d;
	print OUT1 "$sequence\n";
	print OUT2 "$model".'_'."$reps\t$allheaders\n";
};

close (OUT1);
close (OUT2);
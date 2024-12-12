#!/usr/bin/perl
use strict;
use warnings;

open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my @array1 = ();
my @array2 = ();

foreach my $line (@input) {
    my ($digit1, $digit2) = $line =~ /(\d+)\s+(\d+)/g;
    push @array1, $digit1;
    push @array2, $digit2;
}

@array1 = sort(@array1);
@array2 = sort(@array2);

my $sum = 0;

for (my $cur = 0; $cur < scalar(@array1); $cur++) {
  $sum += abs($array1[$cur] - $array2[$cur]);
}

print "$sum\n";

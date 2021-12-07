#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

open F, "q06_input.txt" or die;
chomp(my @input = <F>);
close F;

my @lanternFishes = ($input[0] =~ /(\d+)/g);

my $remainingDays = 256;

# Must be done mathematically
my %hash;

foreach my $digit (@lanternFishes) {
    $hash{$digit}++;
}

foreach my $day (0..($remainingDays - 1)) {
    # The amount of 8s need to be appended to the end of array, equal to zeroes
    my $zeroes = 0;
    $zeroes = $hash{0} if (defined($hash{0}));

    # Shift all digits by 1;
    foreach my $digit (1..8) {
        $hash{$digit - 1} = $hash{$digit};
    }

    # Add 8s
    $hash{8} = $zeroes;

    # Add the current zeroes to 6s
    $hash{6} += $zeroes;
}

my $count = 0;

foreach my $value (values %hash) {
    $count += $value;
}

print "$count\n";

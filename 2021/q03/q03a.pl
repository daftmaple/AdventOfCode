#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
chomp(my @input = <F>);
close F;

# Array<Map<Bit, Count>>
my @array = ();

foreach my $line (@input) {
    # Array<Bit>
    my @bits = ($line =~ /(\d)/g);

    for (my $idx = 0; $idx < scalar(@bits); $idx++) {
        my $bit = $bits[$idx];

        if (!defined($array[$idx]{$bit})) {
            $array[$idx]{$bit} = 1;
        } else {
            $array[$idx]{$bit}++;
        }
    }
}

my $gamma = 0;
my $epsilon = 0;

# Ref<Map<Bit, Count>>
foreach my $hashRef (@array) {
    $gamma *= 2;
    $epsilon *= 2;
    # Map<Bit,Count>
    if ($$hashRef{0} > $$hashRef{1}) {
        $epsilon++;
    } else {
        $gamma++;
    }
}

my $result = $gamma * $epsilon;

print "$result\n";

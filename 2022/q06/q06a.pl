#!/usr/bin/perl
use strict;
use warnings;

open F, "q06_input.txt" or die;
chomp(my @input = <F>);
close F;

my ($line) = @input;

my @chars = split //, $line;

my $result = 0;

for (my $index = 3; $index < $#chars; $index++) {
    my %hashTable;
    $hashTable{$chars[$index]} += 1;
    $hashTable{$chars[$index - 1]} += 1;
    $hashTable{$chars[$index - 2]} += 1;
    $hashTable{$chars[$index - 3]} += 1;

    my $highestValue = 0;
    
    foreach my $key (keys %hashTable) {
        $highestValue = $hashTable{$key} if $hashTable{$key} > $highestValue;
    }

    if ($highestValue == 1) {
        $result = $index + 1;
        last;
    }
}

print "$result\n";

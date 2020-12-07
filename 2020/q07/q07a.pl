#!/usr/bin/perl
use strict;
use warnings;

my %bagKeys;
open F, "q07_input.txt" or die;
while (<F>) {
    chomp;
    my $container = ($_ =~ /(\w+ \w+) bags contain/)[0];
    my @bags = ($_ =~ /\d+ (\w+ \w+) bags?/g);
    foreach my $bag (@bags) {
        $bagKeys{$container}{$bag}++;
    }
}
close F;

my $result = 0;
foreach my $col (keys %bagKeys) {
    $result++ if recursiveSearch($col) > 0;
}

print "$result\n";

sub recursiveSearch {
    my ($col) = @_;
    my $result = 0;
    foreach my $k (keys %{$bagKeys{$col}}) {
        if ($k eq "shiny gold") {
            $result++;
        } else {
            $result += recursiveSearch($k);
        }
    }
    return $result;
}
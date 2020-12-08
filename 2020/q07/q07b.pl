#!/usr/bin/perl
use strict;
use warnings;

my %bagKeys;
open F, "q07_input.txt" or die;
while (<F>) {
    chomp;
    my $container = ($_ =~ /(\w+ \w+) bags contain/)[0];
    my @bags = ($_ =~ /(\d+ \w+ \w+) bags?/g);
    foreach my $bag (@bags) {
        my $col = ($bag =~ /\d+ (\w+ \w+)/)[0];
        my $num = ($bag =~ /(\d+)/)[0];
        $bagKeys{$container}{$col} = $num;
    }
}
close F;

my $result = recursiveSearch("shiny gold");
print "$result\n";

sub recursiveSearch {
    my ($col) = @_;
    my $result = 0;
    foreach my $k (keys %{$bagKeys{$col}}) {
        $result += $bagKeys{$col}{$k} + $bagKeys{$col}{$k} * recursiveSearch($k);
    }
    return $result;
}
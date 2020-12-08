#!/usr/bin/perl
use strict;
use warnings;

open F, "<q08_input.txt" or die;
chomp(my @strings = <F>);
close F;

my $literal = 0;
my $minus = 0;
my $hex = 0;
while (@strings) {
    my $word = shift (@strings);
    $literal += length($word);
    
    # Remove enclosing quotes
    my $simplifiedWord = ($word =~ /^\"(.*)\"$/)[0];

    # Capture all escaped
    my @escaped = ($simplifiedWord =~ /(\\)[\\"]/g);

    # Capture all hexes
    my @hexes = ($simplifiedWord =~ /(\\x[0-9a-f]{2})/g);

    # Length must be length of word minus:
    # - 2 from quotes
    # - size of all escaped
    # - 3 * size of all hexes
    my $mem = length($word) - (2 + scalar(@escaped) + 3 * scalar(@hexes));
    $minus += $mem;
}

my $result = $literal - $minus;

print "$result\n";

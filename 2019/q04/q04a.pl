#!/usr/bin/perl
use strict;
use warnings;

die if (@ARGV != 1);
my $inp = $ARGV[0];

my $from = ($inp =~ /(\d+)/)[0];
my $to = ($inp =~ /\d+-(\d+)/)[0];

my $result = 0;

while ($from <= $to) {
    my @str = (int($from/100000), int($from/10000) % 10, int($from/1000) % 10, int($from/100) % 10, int($from/10) % 10, $from % 10);
    my $i = 0;
    my $match = 0;
    my $right = 1;
    while ($i < (@str) - 1) {
        if ($str[$i + 1] < $str[$i]) {
            $right = 0;
            last;
        }
        $match++ if $str[$i] == $str[$i + 1];
        $i++;
    }

    $result++ if $match && $right;
    $from++;
}

print "$result\n";

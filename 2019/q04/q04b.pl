#!/usr/bin/perl
use strict;
use warnings;

die if (@ARGV != 1);
my $inp = $ARGV[0];

my $from = ($inp =~ /(\d+)/)[0];
my $to = ($inp =~ /\d+-(\d+)/)[0];

my $result = 0;

while ($from <= $to) {
    $result++ if check($from);
    $from++;
}

print "$result\n";

sub check {
    my $no = shift @_;
    my @str = (int($no/100000), int($no/10000) % 10, int($no/1000) % 10, int($no/100) % 10, int($no/10) % 10, $no % 10);
    my $match = okDouble(@str);
    my $i = 0;
    my $right = 1;
    while ($i < (@str) - 1) {
        if ($str[$i + 1] < $str[$i]) {
            $right = 0;
            last;
        }
        $i++;
    }
    return 1 if $match && $right;
    return 0;
}

sub okDouble {
    my $i = 0;
    my $hasDouble = 0;
    while ($i < (@_) - 1) {
        if ($_[$i] == $_[$i + 1]) {
            $hasDouble = 1 if count($_[$i], @_) == 2;
        }
        $i++;
    }
    return $hasDouble;
}

sub count {
    my $ts = shift @_;
    my $c = 0;
    foreach my $k (@_) {
        $c++ if $k == $ts;
    }
    return $c;
}
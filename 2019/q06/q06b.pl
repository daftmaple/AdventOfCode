#!/usr/bin/perl
use strict;
use warnings;

open F, "<q06_input.txt" or die;

my %dictionary;
my $total = -2;
my $common = '';

while (<F>) {
    chomp;
    my @split = split /\)/, $_;
    $dictionary{$split[1]} = $split[0];
}
close F;

my @san;
my @you;

$e = $dictionary{'SAN'};
while (exists $dictionary{$e}) {
    push @san, $e;
    $e = $dictionary{$e};
}

$f = $dictionary{'YOU'};
while (exists $dictionary{$f}) {
    push @you, $f;
    $f = $dictionary{$f};
}

my $i = 0;
foreach my $y (@you) {
    $i++;
    my $j = 0;
    foreach my $s (@san) {
        $j++;
        if ($y eq $s) {
            $total += ($i + $j);
        }
    }
    last if ($total >= 0);
}

print "$total\n";

#!/usr/bin/perl
use strict;
use warnings;

my @array = ();
my $index = 0;
open F, "q04_input.txt" or die;
while (<F>) {
    chomp;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= " " . $_;
    }
}
close F;

my $count = 0;

for (@array) {
    my @t = ($_ =~ /(byr|iyr|eyr|hgt|hcl|ecl|pid)/g);
    if (scalar @t == 7) {
        $count++;
    }
}

print "$count\n";

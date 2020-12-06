#!/usr/bin/perl
use strict;
use warnings;

my @array = ();
my $index = 0;
open F, "q06_input.txt" or die;
while (<F>) {
    chomp $_;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= $_;
    }
}
close F;

my $count = 0;
foreach my $str (@array) {
    my @chars = split //, $str;
    my %hash;
    @hash{@chars} = 1;
    my $ct = scalar keys %hash;
    $count += $ct;
}

print "$count\n";

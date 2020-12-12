#!/usr/bin/perl
use strict;
use warnings;

open F, "q10_input.txt" or die;
chomp(my @nums = <F>);
close F;

push @nums, 0;
my @sorted = sort { $a <=> $b } @nums;
push @sorted, ($sorted[-1] + 3);

my %array;
foreach my $num (@sorted) {
    $array{$num}++;
}

my %diff;

foreach my $key (keys %array) {
    if (defined $array{$key + 1}) {
        $diff{1} += $array{$key} * $array{$key + 1};
    } elsif (defined $array{$key + 2}) {
        $diff{2} += $array{$key} * $array{$key + 2};
    } elsif (defined $array{$key + 3}) {
        $diff{3} += $array{$key} * $array{$key + 3};
    }
}

my $result = $diff{1} * $diff{3};
print "$result\n";

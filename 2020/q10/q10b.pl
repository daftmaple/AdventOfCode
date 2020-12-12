#!/usr/bin/perl
use strict;
use warnings;

open F, "q10_input.txt" or die;
chomp(my @nums = <F>);
close F;

push @nums, 0;
my @sorted = sort { $a <=> $b } @nums;
push @sorted, ($sorted[-1] + 3);

my %diff;
$diff{0} = 1;

# Find diff{last number} which is equal to different way to arrange from 0 to last number (x)
# To solve this, we need to reduce it down to smaller pieces

# diff{x} will be equal to sum of different way to arrange:
# - from 0 to x-1 (if number exists), and every way to arrange this 
# will end with one step from x-1 to x (because 1 jolt difference) = diff{x-1}.
# - from 0 to x-2, will end with one step from x-2 to x (2 jolts difference) = diff{x-2}
# (we already counted the step between x-2 to x-1 in the previous iteration)
# - from 0 to x-3, will end with one step from x-3 to x (3 jolts difference) = diff{x-3}
# (we already counted the step between x-3 to x-1 in the previous two iterations)

# Since number exists doesn't mean diff{x - k} exists, we have to calculate diff{x - k} first
# This can be done by calculating from the firstmost item

foreach my $i (@sorted) {
    my $sq = 0;
    if (!defined $diff{$i}) {
        $sq += $diff{$i - 1} if defined $diff{$i - 1};
        $sq += $diff{$i - 2} if defined $diff{$i - 2};
        $sq += $diff{$i - 3} if defined $diff{$i - 3};
        $diff{$i} = $sq;
    }
}

my $result = $diff{$sorted[-1]};
print "$result\n";

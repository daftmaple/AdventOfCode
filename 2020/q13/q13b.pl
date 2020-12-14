#!/usr/bin/perl
use strict;
use warnings;

open F, "q13_input.txt" or die;
chomp(my @input = <F>);
close F;

my ($ignored, $ids) = @input;

my %hash;
my $i = 0;
foreach my $v (split /,/, $ids) {
    if ($v ne 'x') {
        $hash{$v} = $i;
    }
    $i++;
}

my $result = crt();
print "$result\n";

# We need to find out t
# Where t (mod $key) === $hash{$key} 
# or (t + $hash{$key}) (mod $key) == 0
# for all $key in keys %hash
# Use Chinese Remainder Theorem

sub crt {
    my $t = 0;
    my $step = 1;
    foreach my $key (keys %hash) {
        while (($t + $hash{$key}) % $key != 0) {
            $t += $step;
        }
        $step *= $key;
    }
    return $t;
}

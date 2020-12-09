#!/usr/bin/perl
use strict;
use warnings;

open F, "q09_input.txt" or die;
chomp(my @numbers = <F>);
close F;

for (my $i = 25; $i < @numbers; $i++) {
    if (!findWithin($i)) {
        my $qA = $numbers[$i];
        print "Part 1: $qA\n";
        my $qB = findSum($i);
        print "Part 2: $qB\n";
        last;
    }
}

sub findWithin {
    my ($i) = @_;
    foreach my $numA (@numbers[($i - 25) .. ($i - 1)]) {
        foreach my $numB (@numbers[($i - 25) .. ($i - 1)]) {
            return 1 if $numA + $numB == $numbers[$i];
        }
    }
    return 0;
}

sub findSum {
    my ($a) = @_;
    my $num = $numbers[$a];
    for (my $first = 0; $first < scalar(@numbers); $first++) {
        for (my $last = $first + 2; $last < scalar(@numbers); $last++) {
            if (sumCont($first, $last) == $num) {
                return sumMinMax($first, $last);
            }
        }
    }
    die "Can't find sum";
}

sub sumCont {
    my ($first, $last) = @_;
    my $result = 0;
    foreach my $val (@numbers[$first .. $last]) {
        $result += $val;
    }
    return $result;
}

sub sumMinMax {
    my ($first, $last) = @_;
    my @array = sort { $a <=> $b } @numbers[$first .. $last];   
    return $array[0] + $array[scalar @array - 1];
}

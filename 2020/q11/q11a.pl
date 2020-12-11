#!/usr/bin/perl
use strict;
use warnings;

open F, "q11_input.txt" or die;
chomp(my @flatSeats = <F>);
close F;

my @dSeats = ();
my @nSeats = ();
foreach my $seats (@flatSeats) {
    my @seats = split //, $seats;
    my @seats2 = split //, $seats;
    push @dSeats, \@seats;
    push @nSeats, \@seats2;
}

my $change = 1;
my $round = 0;
while ($change) {
    $change = modifySeats();
    # Copy nSeats to dSeats
    for (my $i = 0; $i < scalar(@dSeats); $i++) {
        my $ref = $dSeats[$i];
        for (my $j = 0; $j < scalar(@$ref); $j++) {
            $dSeats[$i][$j] = $nSeats[$i][$j];
        }
    }
    $round++;
}

my $occupied = 0;
for (my $i = 0; $i < scalar(@dSeats); $i++) {
    my $ref = $dSeats[$i];
    for (my $j = 0; $j < scalar(@$ref); $j++) {
        $occupied++ if $dSeats[$i][$j] eq '#';
    }
}

print "$occupied\n";

sub modifySeats {
    my $return = 0;
    for (my $i = 0; $i < scalar(@dSeats); $i++) {
        my $ref = $dSeats[$i];
        for (my $j = 0; $j < scalar(@{$dSeats[$i]}); $j++) {
            $return += switchSeat($i, $j);
        }
    }
    return $return;
}

sub switchSeat {
    my ($x, $y) = @_;
    my $seat = $dSeats[$x][$y];
    return 0 if $seat eq '.';

    my $adjacent = 0;
    for my $s (-1 .. 1) {
        for my $t (-1 .. 1) {
            if (!($s == 0 and $t == 0)
            and 0 <= $x + $s and $x + $s < scalar(@dSeats) 
            and 0 <= $y + $t and $y + $t < scalar(@{$dSeats[$x]})) {
                $adjacent++ if $dSeats[$x + $s][$y + $t] eq '#';
            }
        }
    }

    if ($seat eq 'L' and $adjacent == 0) {
        $nSeats[$x][$y] = '#';
        return 1;
    }
    if ($seat eq '#' and $adjacent >= 4) {
        $nSeats[$x][$y] = 'L';
        return 1;
    }
    return 0;
}

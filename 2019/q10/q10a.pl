#!/usr/bin/perl
use strict;
use warnings;

open F, "<q10_input.txt" or die;
%hash;
my $y = 0;
foreach my $line (<F>) {
    chomp $line;
    my $x = 0;
    my @t = split//, $line;
    foreach my $loc (@t) {
        if ($loc eq '#') {
            $hash{$y}{$x} = 1;
        } else {
            $hash{$y}{$x} = 0;
        }
        $x++;
    }
    $y++;
}
close F;

foreach my $cY (keys %hash) {
    foreach my $cX (keys %{$hash{$cY}}) {
        next if $hash{$cY}{$cX} == 0;
        proc($cX, $cY);
    }
}

$max = 0;
foreach my $cY (keys %hash) {
    foreach my $cX (keys %{$hash{$cY}}) {
        if ($hash{$cY}{$cX} > $max) {
            $max = $hash{$cY}{$cX};
        }
    }
}

print "$max\n";

sub proc {
    my ($currX, $currY) = @_;
    my $t = 0;
    foreach my $sY (keys %hash) {
        foreach my $sX (keys %{$hash{$sY}}) {
            # Get diff between two points
            my $diffX = $currX - $sX;
            my $diffY = $currY - $sY;

            next if ($diffX == 0 && $diffY == 0);
            next if ($hash{$sY}{$sX} == 0);

            my $gcd = abs(gcd($diffX, $diffY));
            if ($gcd == 1) {
                $t++;
            } else {
                my $hX = $diffX / $gcd;
                my $hY = $diffY / $gcd;
                my $proc = $gcd - 1;
                my $dup = 0;
                while ($proc > 0) {
                    $dup = 1 if $hash{$currY - $hY * $proc}{$currX - $hX * $proc} > 0;
                    last if $dup;
                    $proc--;
                }
                $t += 1 if $dup == 0;
            }
        }
    }
    $hash{$currY}{$currX} = $t;
}

sub gcd {
    my ($a, $b) = @_;
    return $b if $a == 0;
    return gcd($b % $a, $a);
}

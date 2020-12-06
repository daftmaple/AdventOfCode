#!/usr/bin/perl
use strict;
use warnings;

@instr = ();
open F, "<q06_input.txt" or die;
while (<F>) {
    chomp;
    push @instr, $_;
}
close F;

%lights;

foreach my $inst (@instr) {
    my @num = $inst =~ /(\d+)/g;
    my @turn = $inst =~ /(\w+)\s(\w+)/;
    my $fY = $num[1];
    my $gX = $num[2];
    my $gY = $num[3];
    my $stX = $num[0];
    my $stY = $num[1];
    if ($turn[0] eq 'turn') {
        if ($turn[1] eq 'on') {
            # Turn on
            while ($stX <= $gX) {
                $stY = $fY;
                while ($stY <= $gY) {
                    $lights{$stX}{$stY} = 1;
                    $stY++;
                }
                $stX++;
            }
        } else {
            # Turn off
            while ($stX <= $gX) {
                $stY = $fY;
                while ($stY <= $gY) {
                    $lights{$stX}{$stY} = 0;
                    $stY++;
                }
                $stX++;
            }
        }
    } elsif ($turn[0] eq 'toggle') {
        while ($stX <= $gX) {
            $stY = $fY;
            while ($stY <= $gY) {
                if (defined $lights{$stX}{$stY} and $lights{$stX}{$stY} == 1) {
                    $lights{$stX}{$stY} = 0;
                } else {
                    $lights{$stX}{$stY} = 1;
                }
                $stY++;
            }
            $stX++;
        }
    }
}

$c = 0;
foreach my $a (keys %lights) {
    foreach my $v (values %{$lights{$a}}) {
        $c++ if $v;
    }
}

print "$c\n";

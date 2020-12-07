#!/usr/bin/perl
use strict;
use warnings;

die "Need prog input" if (@ARGV != 1);
open F, "<q05_input.txt" or die;
my @arr = split /,/, <F>;
close F;

my $input = $ARGV[0];

my $output = 0;

my $a = 0;     # Instruction pointer
while ($a < (@arr)) {
    my $inst = $arr[$a];

    my $op = $inst % 100;
    my $m1 = int($inst / 100) % 10;
    my $m2 = int($inst / 1000) % 10;
    my $m3 = int($inst / 10000) % 10;

    last if $op == 99;
    my $reg1 = $arr[$a + 1];
    my $reg2 = $arr[$a + 2];
    my $reg3 = $arr[$a + 3];

    my $v1 = $reg1;
    $v1 = $arr[$reg1] if $m1 == 0;

    my $v2 = $reg2;
    $v2 = $arr[$reg2] if $m2 == 0;

    if ($op == 1) {
        $arr[$reg3] = $v1 + $v2;
        $a += 4;
    } elsif ($op == 2) {
        $arr[$reg3] = $v1 * $v2;
        $a += 4;
    } elsif ($op == 3) {
        $arr[$reg1] = $input;
        $a += 2;
    } elsif ($op == 4) {
        $output = $arr[$reg1];
        $a += 2;
    } elsif ($op == 5) {
        if ($v1 != 0) {
            $a = $v2;
        } else {
            $a += 3;
        }
    } elsif ($op == 6) {
        if ($v1 == 0) {
            $a = $v2;
        } else {
            $a += 3;
        }
    } elsif ($op == 7) {
        if ($v1 < $v2) {
            $arr[$reg3] = 1;
        } else {
            $arr[$reg3] = 0;
        }
        $a += 4;
    } elsif ($op == 8) {
        if ($v1 == $v2) {
            $arr[$reg3] = 1;
        } else {
            $arr[$reg3] = 0;
        }
        $a += 4;
    } else {
        # Something is wrong (?)
        last;
    }
}

print "$output\n";

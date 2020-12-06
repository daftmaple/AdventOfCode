#!/usr/bin/perl
use strict;
use warnings;

open F, "<q09_input.txt" or die;
@arr = split /,/, <F>;
close F;

my @io = ();
push @io, $ARGV[0] if (@ARGV > 0);    # Test mode

$a = 0;     # Instruction pointer
$rbase = 0;

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
    $v1 = $arr[$reg1 + $rbase] if $m1 == 2;

    my $v2 = $reg2;
    $v2 = $arr[$reg2] if $m2 == 0;
    $v2 = $arr[$reg2 + $rbase] if $m2 == 2;
    
    my $v3 = $reg3;
    $v3 += $rbase if $m3 == 2;
    
    if ($op == 1) {
        $arr[$v3] = $v1 + $v2;
        $a += 4;
    } elsif ($op == 2) {
        $arr[$v3] = $v1 * $v2;
        $a += 4;
    } elsif ($op == 3) {
        $arr[$v3] = shift @io;
        $a += 2;
    } elsif ($op == 4) {
        push @io, $v1;
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
            $arr[$v3] = 1;
        } else {
            $arr[$v3] = 0;
        }
        $a += 4;
    } elsif ($op == 8) {
        if ($v1 == $v2) {
            $arr[$v3] = 1;
        } else {
            $arr[$v3] = 0;
        }
        $a += 4;
    } elsif ($op == 9) {
        # Modify rbase
        $rbase += $v1;
        $a += 2;
    } else {
        # Something is wrong (?)
        last;
    }    
}

print "@io\n";

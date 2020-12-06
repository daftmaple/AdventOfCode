#!/usr/bin/perl
use strict;
use warnings;

use Algorithm::Permute;

open F, "<q07_input.txt" or die;
my @original = split /,/, <F>;
close F;

my @possible = 0 .. 4;

my $iter = Algorithm::Permute->new ( \@possible );

my @result;
my $max = 0;
while (my @chk = $iter->next) {
    my $i = 0;
    my $pass = 0;
    while ($i < 5) {
        # $chk[$i] == phase setting
        # $pass == input signal
        my @copyArr = @original;
        $tk = amplifier($chk[$i], $pass, @copyArr);
        $pass = $tk;
        $i++;
    }
    if ($pass > $max) {
        $max = $pass;
        @result = @chk;
    }
}

print "$max\n";

sub amplifier {
    my ($input1, $input2, @arr) = @_;

    my $output = 0;

    my $a = 0;     # Instruction pointer
    my $inputCount = 0;
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
            if ($inputCount == 0) {
                $arr[$reg1] = $input1;
                $inputCount++;
            } else {
                $arr[$reg1] = $input2;
                $inputCount++;
            }
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

    return $output;
}

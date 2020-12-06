#!/usr/bin/perl
use strict;
use warnings;

open F, "<q02_input.txt" or die;
@arr = split /,/, <F>;
close F;

$noun = 0;
$verb = 0;
$fin = 0;

while ($noun < 100) {
    $verb = 0;
    while ($verb < 100) {
        my @copy = @arr;
        $copy[1] = $noun;
        $copy[2] = $verb;

        my $a = 0;

        while (4 * $a < (@copy + 4)) {
            my $t = $copy[4 * $a];
            my $i1 = $copy[4 * $a + 1];
            my $i2 = $copy[4 * $a + 2];
            my $o = $copy[4 * $a + 3];
            last if $t == 99;
            $copy[$o] = $copy[$i1] + $copy[$i2] if ($t == 1);
            $copy[$o] = $copy[$i1] * $copy[$i2] if ($t == 2);
            $a++;
        }

        $fin = 1 if $copy[0] == 19690720;
        last if $fin;
        $verb++;
    }
    last if $fin;
    $noun++;
}


printf ("%d\n", 100 * $noun + $verb);
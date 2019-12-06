#!/usr/bin/perl

open F, "<q02_input.txt" or die;

@arr = split /,/, <F>;

$arr[1] = 12;
$arr[2] = 2;

my $a = 0;

while (4 * $a < (@arr + 4)) {
    my $t = $arr[4 * $a];
    my $i1 = $arr[4 * $a + 1];
    my $i2 = $arr[4 * $a + 2];
    my $o = $arr[4 * $a + 3];
    last if $t == 99 || $t == 0;
    $arr[$o] = $arr[$i1] + $arr[$i2] if ($t == 1);
    $arr[$o] = $arr[$i1] * $arr[$i2] if ($t == 2);
    $a++;
}

print "$arr[0]\n";
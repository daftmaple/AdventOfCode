#!/usr/bin/perl -w

die "Need prog input" if (@ARGV != 1);
open F, "<q05_input.txt" or die;
@arr = split /,/, <F>;
close F;

my $input = $ARGV[0];

my $output = 0;

$a = 0;
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
    } else {
        # Something is wrong (?)
        last;
    }
}

print "$output\n";

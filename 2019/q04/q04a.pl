#!/usr/bin/perl -w

die if (@ARGV != 1);
$inp = $ARGV[0];

$from = ($inp =~ /(\d+)/)[0];
$to = ($inp =~ /\d+-(\d+)/)[0];

$result = 0;

while ($from <= $to) {
    @str = (int($from/100000), int($from/10000) % 10, int($from/1000) % 10, int($from/100) % 10, int($from/10) % 10, $from % 10);
    $i = 0;
    $match = 0;
    $right = 1;
    while ($i < (@str) - 1) {
        if ($str[$i + 1] < $str[$i]) {
            $right = 0;
            last;
        }
        $match++ if $str[$i] == $str[$i + 1];
        $i++;
    }

    $result++ if $match && $right;
    $from++;
}

print "$result\n";

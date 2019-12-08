#!/usr/bin/perl -w

open F, "<q08_input.txt" or die;
$str = <F>;
close F;

@arr = ();

$layer = 25 * 6;

$i = 0;
while ($i < length($str) / $layer) {
    $input = substr($str, $i * $layer, $layer);
    push @arr, $input;
    $i++;
}

$zeros = 100;
$leastidx = 0;
$i = 0;
foreach $k (@arr) {
    $count = count($k, 0);
    if ($count < $zeros) {
        $leastidx = $i;
        $zeros = $count;
    }
    $i++;
}

print count($arr[$leastidx], 1) * count($arr[$leastidx], 2);
print "\n";

sub count {
    $chk = shift @_;
    $no = shift @_;
    @chopped = split //, $chk;
    $ct = 0;
    foreach $char (@chopped) {
        $ct++ if ($char == $no);
    }
    return $ct;
}

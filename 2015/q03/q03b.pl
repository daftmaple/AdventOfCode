#!/usr/bin/perl -w

open F, "<q03_input.txt" or die;
@methods = split //, <F>;
close F;

%coord;

$currXa = 0;
$currYa = 0;
$currXb = 0;
$currYb = 0;

$coord{$currXa}{$currYa}++;

$bin = 0;
foreach my $method (@methods) {
    if ($bin) {
        $bin = 0;
        $currXa-- if $method eq '<';
        $currXa++ if $method eq '>';
        $currYa++ if $method eq '^';
        $currYa-- if $method eq 'v';
        $coord{$currXa}{$currYa}++;
    } else {
        $bin = 1;
        $currXb-- if $method eq '<';
        $currXb++ if $method eq '>';
        $currYb++ if $method eq '^';
        $currYb-- if $method eq 'v';
        $coord{$currXb}{$currYb}++;
    }
}

$c = 0;
foreach my $X (keys %coord) {
    foreach my $v (values %{$coord{$X}}) {
        $c++;
    }
}

print "$c\n";

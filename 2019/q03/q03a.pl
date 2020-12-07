#!/usr/bin/perl
use strict;
use warnings;

open F, "<q03_input.txt" or die;

my $m0 = <F>;
chomp $m0;
my $m1 = <F>;
chomp $m1;
my @method0 = split /,/, $m0;
my @method1 = split /,/, $m1;

close F;

my %array;

my $cursX = 0;
my $cursY = 0;
for my $k (@method0) {
    strwrite($k);
}

$cursX = 0;
$cursY = 0;
for my $k (@method1) {
    strwrite($k);
}

my $d = 1;
while (1) {
    $cursX = $d;
    while ($cursX >= 0) {
        $cursY = $d - $cursX;
        # print "$cursX, $cursY\n";
        if (!defined $array{$cursX}{$cursY}) {
            $cursX--;
            next;
        }
        print "$d\n" and exit if $array{$cursX}{$cursY} > 1;
        $cursX--;
    }
    $d++;
}

sub strwrite {
    my $str = shift @_;
    my $w = ($str =~ /([RDLU])/)[0];
    my $d = ($str =~ /(\d+)/)[0];
    my $i = 0;
    if ($w eq 'R'){
        while ($i < $d) {
            $i++;
            $cursX++;
            incr($cursX, $cursY);
        }
    }
    if ($w eq 'D'){
        while ($i < $d) {
            $i++;
            $cursY--;
            incr($cursX, $cursY);
        }
    }
    if ($w eq 'L'){
        while ($i < $d) {
            $i++;
            $cursX--;
            incr($cursX, $cursY);
        }
    }
    if ($w eq 'U'){
        while ($i < $d) {
            $i++;
            $cursY++;
            incr($cursX, $cursY);
        }
    }
    return;
}

sub incr {
    my $cursX = shift @_;
    my $cursY = shift @_;
    $array{$cursX}{$cursY}++;
}


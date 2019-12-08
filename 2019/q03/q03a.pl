#!/usr/bin/perl -w

open F, "<q03_input.txt" or die;

$m0 = <F>;
chomp $m0;
$m1 = <F>;
chomp $m1;
@method0 = split /,/, $m0;
@method1 = split /,/, $m1;

close F;

my %array;

$cursX = 0;
$cursY = 0;
for $k (@method0) {
    strwrite($k);
}

$cursX = 0;
$cursY = 0;
for $k (@method1) {
    strwrite($k);
}

$d = 1;
while (1) {
    $cursX = $d;
    while ($cursX >= 0) {
        $cursY = $d - $cursX;
        # print "$cursX, $cursY\n";
        if (!defined $array->{$cursX}{$cursY}) {
            $cursX--;
            next;
        }
        print "$d\n" and exit if $array->{$cursX}{$cursY} > 1;
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
    $array->{$cursX}{$cursY}++;
}


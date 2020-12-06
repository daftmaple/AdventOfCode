#!/usr/bin/perl
use strict;
use warnings;

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
    $j = strwrite($k);
    last if $j;
}

@list = ();
move(@method0);

$c = -1;
foreach my $pointer (@list) {
    my $pX = @{$pointer}[0];
    my $pY = @{$pointer}[1];
    my $count0 = counter($pX, $pY, @method0);
    my $count1 = counter($pX, $pY, @method1);
    $c = $count0 + $count1 if $c == -1 or $count0 + $count1 < $c;
}

print "$c\n";

sub move {
    $cursX = 0;
    $cursY = 0;
    foreach my $str (@_) {
        my $w = ($str =~ /([RDLU])/)[0];
        my $d = ($str =~ /(\d+)/)[0];
        my $i = 0;
        if ($w eq 'R'){
            while ($i < $d) {
                $i++;
                $cursX++;
                if ($array{$cursX}{$cursY} >= 2) {
                    my @coord = ($cursX, $cursY);
                    push @list, \@coord;
                }
            }
        }
        if ($w eq 'D'){
            while ($i < $d) {
                $i++;
                $cursY--;
                if ($array{$cursX}{$cursY} >= 2) {
                    my @coord = ($cursX, $cursY);
                    push @list, \@coord;
                }
            }
        }
        if ($w eq 'L'){
            while ($i < $d) {
                $i++;
                $cursX--;
                if ($array{$cursX}{$cursY} >= 2) {
                    my @coord = ($cursX, $cursY);
                    push @list, \@coord;
                }
            }
        }
        if ($w eq 'U'){
            while ($i < $d) {
                $i++;
                $cursY++;
                if ($array{$cursX}{$cursY} >= 2) {
                    my @coord = ($cursX, $cursY);
                    push @list, \@coord;
                }
            }
        } 
    }
}

sub counter {
    my $tX = shift @_;
    my $tY = shift @_;
    $cursX = 0;
    $cursY = 0;
    my $count = 0;
    foreach my $str (@_) {
        my $w = ($str =~ /([RDLU])/)[0];
        my $d = ($str =~ /(\d+)/)[0];
        my $i = 0;
        my $done = 0;
        if ($w eq 'R'){
            if (!($cursX <= $tX && $tX <= $cursX + $d && $cursY == $tY)) {
                $cursX += $d;
                $count += $d;
            } else {
                while ($i < $d) {
                    $i++;
                    $cursX++;
                    $count++;
                    if ($cursX == $tX && $cursY == $tY) {
                        $done = 1;
                        last;
                    }
                }
            }
        }
        if ($w eq 'D'){
            if (!($cursY - $d <= $tY && $tY <= $cursY && $cursX == $tX)) {
                $cursY -= $d;
                $count += $d;
            } else {
                while ($i < $d) {
                    $i++;
                    $cursY--;
                    $count++;
                    if ($cursX == $tX && $cursY == $tY) {
                        $done = 1;
                        last;
                    }
                }
            }
        }
        if ($w eq 'L'){
            if (!($cursX - $d <= $tX && $tX <= $cursX && $cursY == $tY)) {
                $cursX -= $d;
                $count += $d;
            } else {
                while ($i < $d) {
                    $i++;
                    $cursX--;
                    $count++;
                    if ($cursX == $tX && $cursY == $tY) {
                        $done = 1;
                        last;
                    }
                }
            }
        }
        if ($w eq 'U'){
            if (!($cursY <= $tY && $tY <= $cursY + $d && $cursX == $tX)) {
                $cursY += $d;
                $count += $d;
            } else {
                while ($i < $d) {
                    $i++;
                    $cursY++;
                    $count++;
                    if ($cursX == $tX && $cursY == $tY) {
                        $done = 1;
                        last;
                    }
                }
            }
        }        
        last if $done;
    }
    return $count;
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
    return 0;
}

sub incr {
    my $cursX = shift @_;
    my $cursY = shift @_;
    $array{$cursX}->{$cursY}++;
    return 0;
}


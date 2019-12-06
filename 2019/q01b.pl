#!/usr/bin/perl -w

open F, "<q01_input.txt" or die;

$a = 0;

while (<F>) {
    $a += recsum($_);
}

sub recsum {
    my $f = int($_[0] / 3) - 2;
    if ($f > 0) {
        return (recsum($f) + $f);
    } else {
        return 0;
    }
}

print "$a\n";
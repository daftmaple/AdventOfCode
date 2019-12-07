#!/usr/bin/perl -w

use Algorithm::Permute;

open F, "<q07_input.txt" or die;
my @original = split /,/, <F>;
close F;

my @possible = 5 .. 9;

my $iter = Algorithm::Permute->new ( \@possible );

my @result;
my $max = 0;
while (my @chk = $iter->next) {
    my $i = 0;
    my @array0 = @original;
    my @array1 = @original;
    my @array2 = @original;
    my @array3 = @original;
    my @array4 = @original;
    my @whole = (\@array0, \@array1, \@array2, \@array3, \@array4);
    
    my @halt = (0, 0, 0, 0, 0);
    my @a = (0, 0, 0, 0, 0);
    my $nothalt = 1;

    my @visited = (0, 0, 0, 0, 0);
    my @queue;

    # my $k = 0;
    while ($nothalt) {
        if ($visited[$i] == 0) {
            if ($i == 0) {
                push @queue, $chk[$i];
                push @queue, 0;
            } else {
                unshift @queue, $chk[$i];
            }
        }
        $visited[$i]++;

        last if !checkhalt(@halt);
        if ($halt[$i]) {
            $i++;
            $i = 0 if $i == 5;
            next;
        }
        my $proc = $whole[$i];
        ($proghalt, $anew) = amplifier(\@queue, $a[$i], $proc);
        $halt[$i] = 1 if $proghalt;
        $a[$i] = $anew;
        $i++;
        $i = 0 if $i == 5;
        $nothalt = checkhalt(@halt);
    }

    $pass = shift @queue;
    if ($pass > $max) {
        $max = $pass;
        @result = @chk;
    }
}

print "$max\n";

sub checkhalt {
    foreach my $t (@_) {
        return 1 if $t == 0;
    }
    return 0;
}

sub amplifier {
    my ($ptr, $start, $arr) = @_;

    my $a = $start;
    my $output = 0;

    while ($a < (@{$arr})) {
        my $inst = $arr->[$a];

        my $op = $inst % 100;
        my $m1 = int($inst / 100) % 10;
        my $m2 = int($inst / 1000) % 10;
        my $m3 = int($inst / 10000) % 10;

        return (1, $a) if $op == 99;
        my $reg1 = $arr->[$a + 1];
        my $reg2 = $arr->[$a + 2];
        my $reg3 = $arr->[$a + 3];

        my $v1 = $reg1;
        $v1 = $arr->[$reg1] if $m1 == 0;

        my $v2 = $reg2;
        $v2 = $arr->[$reg2] if $m2 == 0;

        if ($op == 1) {
            $arr->[$reg3] = $v1 + $v2;
            $a += 4;
        } elsif ($op == 2) {
            $arr->[$reg3] = $v1 * $v2;
            $a += 4;
        } elsif ($op == 3) {
            $arr->[$reg1] = shift @{$ptr};
            $a += 2;
        } elsif ($op == 4) {
            push @{$ptr}, $arr->[$reg1];
            $a += 2;
            return (0, $a);
        } elsif ($op == 5) {
            if ($v1 != 0) {
                $a = $v2;
            } else {
                $a += 3;
            }
        } elsif ($op == 6) {
            if ($v1 == 0) {
                $a = $v2;
            } else {
                $a += 3;
            }
        } elsif ($op == 7) {
            if ($v1 < $v2) {
                $arr->[$reg3] = 1;
            } else {
                $arr->[$reg3] = 0;
            }
            $a += 4;
        } elsif ($op == 8) {
            if ($v1 == $v2) {
                $arr->[$reg3] = 1;
            } else {
                $arr->[$reg3] = 0;
            }
            $a += 4;
        } else {
            # Something is wrong (?)
            last;
        }
    }

    return (0, $a);
}

#!/usr/bin/perl -w

@array = ();
open F, "<q03_input.txt" or die;
while (<F>) {
    chomp $_;
    push @array, $_;
}
close F;

my $result = count(1, 1) * count(3, 1) * count(5, 1) * count(7, 1) * count(1, 2);

print "$result\n";

sub count {
    my $right = shift @_;
    my $down = shift @_;
    my $r = 0;
    my $d = 0;
    my $ct = 0;
    my $len;
    while ($d < scalar @array) {
        $len = length($array[$d]) if !defined $len;
        my $id = $r % $len;
        if (substr($array[$d], $id, 1) eq "#") {
            $ct++;
        }
        $r += $right;
        $d += $down;
    }
    return $ct;
}

#!/usr/bin/perl
use strict;
use warnings;

@alist = ();
open F, "<q05_input.txt" or die;
while (<F>) {
    chomp;
    push @alist, $_;
}
close F;

$count = 0;
foreach my $str (@alist) {
    $count++ if nice($str);
}

print "$count\n";

sub nice {
    my $str = shift @_;
    my $vowel = (() = $str =~ /[aieou]/g) >= 3;
    my $const = ($str =~ /(.)(?=\1)/);
    my $nice = ($str =~ /ab|cd|pq|xy/) == 0;
    return $vowel && $const && $nice;
}

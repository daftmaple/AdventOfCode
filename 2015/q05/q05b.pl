#!/usr/bin/perl
use strict;
use warnings;

my @alist = ();
open F, "<q05_input.txt" or die;
while (<F>) {
    chomp;
    push @alist, $_;
}
close F;

my $count = 0;
foreach my $str (@alist) {
    $count++ if nice($str);
}

print "$count\n";

sub nice {
    my $str = shift @_;
    my $twice = (() = $str =~ /(.{2}).*(?=\1)/g);
    my $repeat = ($str =~ /(.).(?=\1)/);
    return $twice && $repeat;
}

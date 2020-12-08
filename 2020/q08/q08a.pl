#!/usr/bin/perl
use strict;
use warnings;

open F, "q08_input.txt" or die;
chomp(my @lines = <F>);
close F;

my %hash;
my $acc = 0;
my $pointer = 0;

while (my $line = $lines[$pointer]) {
    last if defined $hash{$pointer};

    $hash{$pointer}++;
    my ($inst, $sym, $arg) = $line =~ /^(\w+) ([+-])(\d+)$/g;
    $arg *= -1 if $sym eq "-";
    
    if ($inst eq "acc") {
        $acc += $arg;
        $pointer++;
    } elsif ($inst eq "jmp") {
        $pointer += $arg;
    } else {
        $pointer++;
    }
}

print "$acc\n";

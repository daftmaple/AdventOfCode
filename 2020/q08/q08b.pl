#!/usr/bin/perl
use strict;
use warnings;

open F, "q08_input.txt" or die;
chomp(my @lines = <F>);
close F;

my $result;

for (my $i = 0; $i < scalar(@lines) and !defined $result; $i++) {
    next if ($lines[$i] =~ /^(\w+) [+-]\d+$/)[0] eq "acc";
    my ($check, $value) = reloop($i);
    $result = $value if $check eq "found";
}

print "$result\n";

sub reloop {
    my ($swap) = @_;
    my %hash;
    my $acc = 0;
    my $pointer = 0;

    while (my $line = $lines[$pointer]) {
        if (defined $hash{$pointer}) {
            return ("none", 0);
        }

        $hash{$pointer}++;
        my ($inst, $sym, $arg) = $line =~ /^(\w+) ([+-])(\d+)$/g;
        $arg *= -1 if $sym eq "-";
        
        if ($pointer == $swap) {
            $inst = "jmp" if $inst eq "nop";
            $inst = "nop" if $inst eq "jmp";
        }

        if ($inst eq "acc") {
            $acc += $arg;
            $pointer++;
        } elsif ($inst eq "jmp") {
            $pointer += $arg;
        } elsif ($inst eq "nop") {
            $pointer++;
        }
    }

    return ("found", $acc);
}
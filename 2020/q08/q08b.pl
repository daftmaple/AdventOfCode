#!/usr/bin/perl
use strict;
use warnings;

open F, "q08_input.txt" or die;
chomp(my @lines = <F>);
close F;

my $result = 0;

for (my $i = 0; $i < scalar(@lines); $i++) {
    my $inst = ($lines[$i] =~ /^(\w+) [+-]\d+$/)[0];
    next if $inst eq "acc";
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
        
        if ($inst eq "acc") {
            $acc += $arg;
            $pointer++;
        } elsif ($inst eq "jmp") {
            if ($pointer == $swap) {
                $pointer++;
            } else {
                $pointer += $arg;
            }
        } elsif ($inst eq "nop") {
            if ($pointer == $swap) {
                $pointer += $arg;
            } else {
                $pointer++;
            }
        }
    }

    return ("found", $acc);
}
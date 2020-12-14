#!/usr/bin/perl
use strict;
use warnings;

open F, "q14_input.txt" or die;
chomp(my @input = <F>);
close F;

my $mask;
my %mem;

foreach my $string (@input) {
    my ($mode) = ($string =~ /^(\w+)/);
    if ($mode eq 'mask') {
        my ($currentMask) = ($string =~ /^\w+ = (\w+)$/);
        $mask = $currentMask;
        # print "new mask: $mask\n";
    } else {
        my ($address, $value) = ($string =~ /^\w+\[(\d+)\] = (\d+)$/);
        $mem{$address} = parseMask($value);
        # print "$address, $mem{$address}\n";
    }
}

my $result = 0;
foreach my $address (keys %mem) {
    $result += $mem{$address};
}

print "$result\n";

sub parseMask {
    my ($value) = @_;
    for (my $i = length($mask) - 1; $i >= 0; $i--) {
        my $char = substr($mask, $i, 1);
        if ($char eq 'X') {
            # ignore
        } elsif ($char == 0) {
            my $masking = 1 << (length($mask) - 1 - $i);
            $value &= ~$masking;
        } elsif ($char == 1) {
            my $masking = 1 << (length($mask) - 1 - $i);
            $value |= $masking;
        }
    }
    return $value;
}
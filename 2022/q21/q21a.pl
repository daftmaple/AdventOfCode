#!/usr/bin/perl
use strict;
use warnings;

open F, "q21_input.txt" or die;
chomp(my @input = <F>);
close F;

my %monkey;

foreach my $line (@input) {
    my ($monkeyId, $monkeyOp) = $line =~ /(\w+): (.*)/g;
    $monkey{$monkeyId} = $monkeyOp;
}

sub getValue {
    my ($monkeyId) = @_;

    my $eval = $monkey{$monkeyId};

    return $eval if $eval =~ m/\d+/;

    my ($monkeyId1, $op, $monkeyId2) = $eval =~ /(\w+) (\S) (\w+)/g;

    my $value1 = getValue($monkeyId1);
    my $value2 = getValue($monkeyId2);

    return eval "$value1 $op $value2";
}

my $result = getValue('root');

print "$result\n";

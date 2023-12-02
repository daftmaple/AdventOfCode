#!/usr/bin/perl
use strict;
use warnings;

use POSIX;
use List::Util qw(reduce);
require "./Monkey.pm";

open F, "q11_input.txt" or die;
chomp(my @input = <F>);
close F;

my @monkeys = ();

my @testArrays = ();

while (@input) {
    my ($monkey) = (shift @input) =~ /Monkey (\d+)/;
    my ($startingItems) = (shift @input) =~ /Starting items: (.*)/;
    my ($operation) = (shift @input) =~ /Operation: new = (.*)/;
    my ($test) = (shift @input) =~ /divisible by (\d+)/;
    my ($testIfTrue) = (shift @input) =~ /throw to monkey (\d+)/;
    my ($testIfFalse) = (shift @input) =~ /throw to monkey (\d+)/;

    $monkeys[$monkey] = new Monkey($monkey, $startingItems, $operation, $test, $testIfTrue, $testIfFalse);
    $testArrays[$monkey] = $test;

    shift @input;
}

# Put lcm function inside reduce
my $lcmTest = reduce { ($a * $b) / gcd($a, $b) } @testArrays;

my $iteration = 10000;

for (my $i = 0; $i < $iteration; $i++) {
    foreach (my $monkeyIndex = 0; $monkeyIndex < @monkeys; $monkeyIndex++) {
        my $monkey = $monkeys[$monkeyIndex];
        my $monkeyItems = $monkey->getItems();
        foreach my $digit (@$monkeyItems) {
            # This combines the divisible by test of all monkeys
            # $d % _test == ($d % $lcmTest) % _test
            my $operationResult = $monkey->runOperation($digit) % $lcmTest;
            my $receiver = $monkey->runTestAndReturnReceiver($operationResult);

            $monkeys[$receiver]->receiveItem($operationResult);
        }
        $monkey->endOfTurn();
    }
}


my @turns = sort { $b <=> $a } (map { $_->getOperationCount() } @monkeys);
my $result = $turns[0] * $turns[1];

print "$result\n";

sub gcd {
    my ($a, $b) = @_;

    return $b != 0 ? gcd($b, $a % $b) : $a;
}

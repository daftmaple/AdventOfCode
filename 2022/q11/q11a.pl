#!/usr/bin/perl
use strict;
use warnings;

use POSIX;
require "./Monkey.pm";

open F, "q11_input.txt" or die;
chomp(my @input = <F>);
close F;

my @monkeys = ();

while (@input) {
    my ($monkey) = (shift @input) =~ /Monkey (\d+)/;
    my ($startingItems) = (shift @input) =~ /Starting items: (.*)/;
    my ($operation) = (shift @input) =~ /Operation: new = (.*)/;
    my ($test) = (shift @input) =~ /divisible by (\d+)/;
    my ($testIfTrue) = (shift @input) =~ /throw to monkey (\d+)/;
    my ($testIfFalse) = (shift @input) =~ /throw to monkey (\d+)/;

    $monkeys[$monkey] = new Monkey($monkey, $startingItems, $operation, $test, $testIfTrue, $testIfFalse);

    shift @input;
}

my $iteration = 20;

for (my $i = 0; $i < $iteration; $i++) {
    foreach my $monkey (@monkeys) {
        my $monkeyItems = $monkey->getItems();
        foreach my $digit (@$monkeyItems) {
            my $operationResult = floor($monkey->runOperation($digit) / 3);
            my $receiver = $monkey->runTestAndReturnReceiver($operationResult);

            $monkeys[$receiver]->receiveItem($operationResult);
        }
        $monkey->endOfTurn();
    }
}

my @turns = sort { $b <=> $a } (map { $_->getOperationCount() } @monkeys);
my $result = $turns[0] * $turns[1];

print "$result\n";

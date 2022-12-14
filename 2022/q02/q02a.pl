#!/usr/bin/perl
use strict;
use warnings;

open F, "q02_input.txt" or die;
chomp(my @input = <F>);
close F;

my $totalScore = 0;

while (@input) {
    my $round = shift (@input);

    my ($opponent, $self) = ($round =~ /(\w)\s(\w)/);

    $totalScore += getScore($opponent, $self);
}

sub getScore {
    my ($opponent, $self) = @_;

    my $totalPoint = 0;

    $totalPoint += 4 if ($self eq "X" and $opponent eq "A");
    $totalPoint += 1 if ($self eq "X" and $opponent eq "B");
    $totalPoint += 7 if ($self eq "X" and $opponent eq "C");
    $totalPoint += 8 if ($self eq "Y" and $opponent eq "A");
    $totalPoint += 5 if ($self eq "Y" and $opponent eq "B");
    $totalPoint += 2 if ($self eq "Y" and $opponent eq "C");
    $totalPoint += 3 if ($self eq "Z" and $opponent eq "A");
    $totalPoint += 9 if ($self eq "Z" and $opponent eq "B");
    $totalPoint += 6 if ($self eq "Z" and $opponent eq "C");
    
    return $totalPoint;
}

print "$totalScore\n";

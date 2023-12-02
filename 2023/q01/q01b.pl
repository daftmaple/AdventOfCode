#!/usr/bin/perl
use strict;
use warnings;


open F, "q01_input.txt" or die;
chomp(my @input = <F>);
close F;

my $sum = 0;

my %digitHash;

# The reason behind this is to cover overlap like "eightwo", so inserting the number inbetween word will make sure that it's not going to end up with "8wo" or "eigh2" while either solution might be correct if we iterate from left or right of the string 
$digitHash{'one'} = 'on1e';
$digitHash{'two'} = 'tw2o';
$digitHash{'three'} = 'th3ree';
$digitHash{'four'} = 'fo4ur';
$digitHash{'five'} = 'fi5ve';
$digitHash{'six'} = 'si6x';
$digitHash{'seven'} = 'se7ven';
$digitHash{'eight'} = 'ei8ght';
$digitHash{'nine'} = 'ni9ne';

foreach my $line (@input) {
    my $newLine = replaceInLine($line);

    my @firstDigit = $newLine =~ /(\d).*/;
    my @lastDigit = $newLine =~ /.*(\d)/;

    my $lineDigit = join '', ($firstDigit[0], $lastDigit[0]);
    $sum = $sum + $lineDigit;
}

print "$sum\n";

sub replaceInLine {
    my $str = shift @_;
    foreach my $key (keys %digitHash) {
        my $replacer = $digitHash{$key};
        $str =~ s/$key/$replacer/g;
    }

    return $str;
}
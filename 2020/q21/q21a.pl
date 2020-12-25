#!/usr/bin/perl
use strict;
use warnings;

use experimental 'smartmatch';

open F, "q21_input.txt" or die;
chomp(my @input = <F>);
close F;

my %hash;

foreach my $line (@input) {
    my ($i, $a) = ($line =~ /^(.*) \(contains (.*)\)$/g);
    my @ingredients = ($i =~ /(\w+)+/g);
    my @allergens = ($a =~ /(\w+)+/g);
    
    foreach my $allergen (@allergens) {
        if (!defined($hash{$allergen})) {
            # If allergen is not found in hash, create 2d hash
            # Add all ingredients in the hash
            $hash{$allergen} = \@ingredients;
        } else {
            # Otherwise, you want to find intersect between ingredients
            # existing in the hash itself and the list of ingredients
            # in this loop
            my @prevIngredients = @{$hash{$allergen}};
            my %validIngredients;

            $validIngredients{$_}++ foreach @prevIngredients;
            $validIngredients{$_}++ foreach @ingredients;

            my @stored = ();
            foreach my $item (keys %validIngredients) {
                push @stored, $item if $validIngredients{$item} == 2;
            }
            $hash{$allergen} = \@stored;
        }
    }
}

# Flatten the hash
my %possible;
foreach my $allergen (keys %hash) {
    my @i = @{$hash{$allergen}};
    $possible{$_}++ foreach @i;
}

my $result = 0;
foreach my $line (@input) {
    my ($i) = ($line =~ /^(.*) \(contains .*\)$/g);
    my @ingredients = ($i =~ /(\w+)+/g);
    foreach my $item (@ingredients) {
        $result++ if !defined($possible{$item});
    }
}

print "$result\n";

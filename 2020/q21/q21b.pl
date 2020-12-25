#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw(reduce);

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

# Find the corresponding ingredient for the allergen
# Map of allergen -> ingredient
my %map;
my %mappedIngredient;

while (scalar(keys %map) < scalar(keys %hash)) {
    # Loop through list of ingredients until all ingredients are found
    foreach my $allergen (keys %hash) {
        # Allergen that is already mapped can be skipped
        next if defined($map{$allergen});
        my @i = @{$hash{$allergen}};
        if (scalar(@i) == 1) {
            # Item in this array corresponds to the allergen
            my $ingredient = shift @i;
            $map{$allergen} = $ingredient;
            $hash{$allergen} = \@i;
            $mappedIngredient{$ingredient}++;
        } else {
            # Loop through @i, remove any item that is already in %mappedIngredient
            # Use a new array
            my @newI = ();
            foreach my $item (@i) {
                unshift @newI, $item if !defined $mappedIngredient{$item};
            }
            $hash{$allergen} = \@newI;
        }
    }
}

my @allergens = sort keys %map;
my @ingredients = ();
push @ingredients, $map{$_} foreach @allergens;

my $result = reduce {"$a,$b"} @ingredients;

print "$result\n";

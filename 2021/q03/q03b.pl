#!/usr/bin/perl
use strict;
use warnings;

open F, "q03_input.txt" or die;
# Array<BitString>
chomp(my @input = <F>);
close F;

my $oxygenGeneratorRating = convertBase2ToBase10(mostCommonValue(\@input, 0, 1));
my $carbonDioxideGeneratorRating = convertBase2ToBase10(mostCommonValue(\@input, 0, 0));

my $result = $oxygenGeneratorRating * $carbonDioxideGeneratorRating;

print "$result\n";

# arg1 Ref<Array<BitString>>
# arg2 Position (number)
# arg3 MostCommon (boolean)
# return BitString
sub mostCommonValue {
    my ($arrayRef, $position, $mostCommon) = @_;
    
    my $arrayLength = scalar(@$arrayRef);

    if ($arrayLength <= 0) {
        die "Invalid input\n";
    } elsif ($arrayLength == 1) {
        my $value = shift(@$arrayRef);
        return $value;
    }

    # Generate bit storage and get most/least common digit on the Position
    my $bitStorageRef = generateBitStorage($arrayRef);

    my $commonDigitOnPosition = getMostCommonDigitOnPosition($bitStorageRef, $position, $mostCommon);

    # Put all BitString that has the common digit on the position
    # Array<BitString>
    my @newArray = ();

    # BitString
    for (my $bitStringIndex = 0; $bitStringIndex < $arrayLength; $bitStringIndex++) {
        if ($bitStorageRef->[$bitStringIndex]{$position} == $commonDigitOnPosition) {
            unshift @newArray, $arrayRef->[$bitStringIndex];
        }
    }

    $position++;

    return mostCommonValue(\@newArray, $position, $mostCommon);
}

# arg1 Ref<Array<BitString>>
# return Ref<Array<Map<BitPosition, Bit>>>
sub generateBitStorage {
    my ($bitStringArrayRef) = @_;

    # Array<Map<BitPosition, Bit>>
    my @bitStorage = ();

    for (my $bitIndex = 0; $bitIndex < scalar(@$bitStringArrayRef); $bitIndex++) {
        # Array<Bit>
        my @bits = ($bitStringArrayRef->[$bitIndex] =~ /(\d)/g);

        for (my $bitPosition = 0; $bitPosition < scalar(@bits); $bitPosition++) {
            my $bit = $bits[$bitPosition];
            
            $bitStorage[$bitIndex]{$bitPosition} = $bit;
        }
    }

    return \@bitStorage;
}

# arg1 Ref<Array<Map<BitPosition, Bit>>>
# arg2 Position (number)
# arg3 MostCommon (boolean)
# return Bit
sub getMostCommonDigitOnPosition {
    my ($bitStorageRef, $position, $mostCommon) = @_;

    my $bitCount0 = 0;
    my $bitCount1 = 0;

    # Ref<Map<BitPosition, Bit>>
    foreach my $bitPositionRef (@$bitStorageRef) {
        my %bitPosition = %$bitPositionRef;
        if ($bitPosition{$position} == 0) {
            $bitCount0++;
        } else {
            $bitCount1++;
        }
    }

    if ($bitCount0 > $bitCount1) {
        return 0 if ($mostCommon);
        return 1 if (!$mostCommon);
    } else {
        return 1 if ($mostCommon);
        return 0 if (!$mostCommon);
    }
}

# arg1 BitString
# return number
sub convertBase2ToBase10 {
    my ($bitString) = @_;
    
    my $number = 0;

    my @bits = ($bitString =~ /(\d)/g);
    foreach my $bit (@bits) {
        $number *= 2;
        $number += $bit;
    }

    return $number;
}

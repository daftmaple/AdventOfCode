#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

my $debug = 0;

if (@ARGV > 0) {
    $debug = 1 if ($ARGV[0] == 1);
}

open F, "q04_input.txt" or die;
chomp(my @input = <F>);
close F;

my $firstLine = shift @input;

my $bingoIteration = 0;

# Array<number>
my @bingoNumberSequence = ($firstLine =~ /(\d+)/g);

my $bingoTables = generateBingoTables();
my $result = findResult($bingoTables);

print "$result\n";

# typedef BingoTable = Ref<Array<Ref<Array<number>>>>

# return Ref<Array<BingoTable>>
sub generateBingoTables {
    # Array<BingoTable>
    my @bingoTables = ();
    my @currentBingoTable = ();

    while (@input) {
        my $line = shift @input;

        if (length($line) != 0) {
            # Push the line (current bingo row) to the currentBingoTable
            # Array<number>
            my @numbers = ($line =~ /(\d+)/g);
            push @currentBingoTable, \@numbers;
        }

        if (scalar(@currentBingoTable) == 5) {
            # Push the stored currentBingoTable because it is complete
            push @bingoTables, [@currentBingoTable];
            
            @currentBingoTable = ();
        }
    }

    return \@bingoTables;
}

# arg1 Ref<Array<BingoTable>>
sub findResult {
    my ($bingoTablesRef) = @_;

    my $iteration = 0;
    my $unmarkedNumberSum = 0;

    # Loop through each iteration of the bingo number sequence
    while ($iteration < scalar(@bingoNumberSequence)) {
        printf "Turn %2d, playing %2d\n", $iteration, $bingoNumberSequence[$iteration] 
            if ($debug == 1);

        # Check every bingo tables. If the current table is bingo
        foreach my $bingoTable (@$bingoTablesRef) {
            if (isBingo($bingoTable, $iteration)) {
                print "Found solution\n" if ($debug == 1);
                print Dumper $bingoTable if ($debug == 1);

                $unmarkedNumberSum = sumUnmarkedNumber($bingoTable, $iteration);
                last;
            }
        }

        if ($unmarkedNumberSum != 0) {
            last;
        }

        $iteration++;
    }

    die "Could not find result\n" if ($iteration >= scalar(@bingoNumberSequence));

    my $result = $unmarkedNumberSum * $bingoNumberSequence[$iteration];

    return $result;
}

# arg1 BingoTable
# arg2 BingoNumberIteration (number)
# return boolean
sub isBingo {
    my ($bingoTableRef, $iteration) = @_;

    my $h = isBingoHorizontally($bingoTableRef, $iteration);
    my $v = isBingoVertically($bingoTableRef, $iteration);
    # my $d = isBingoDiagonally($bingoTableRef, $iteration);

    print Dumper ($h, $v) if ($debug == 1 and ($h + $v) > 0);

    return ($h + $v) > 0 ? 1 : 0;
}

# arg1 BingoTable
# arg2 BingoNumberIteration (number)
# return boolean
sub isBingoHorizontally {
    my ($bingoTableRef, $iteration) = @_;

    # Ref<Array<number>>
    foreach my $row (@$bingoTableRef) {
        my $required = scalar(@$row);

        foreach my $bingoSequenceDigit (@bingoNumberSequence[0..$iteration]) {
            # number
            foreach my $bingoNumber (@$row) {
                $required-- if ($bingoNumber == $bingoSequenceDigit);
            }
        }

        return 1 if ($required == 0);
    }

    return 0;
}

# arg1 BingoTable
# arg2 BingoNumberIteration (number)
# return boolean
sub isBingoVertically {
    my ($bingoTableRef, $iteration) = @_;

    for (my $columnIndex = 0; $columnIndex < scalar(@{$bingoTableRef->[0]}); $columnIndex++) {
        my $required = scalar(@{$bingoTableRef->[0]});

        # Array<number>
        my @sequence = @bingoNumberSequence[0..$iteration];
        
        foreach my $bingoSequenceDigit (@sequence) {
            for (my $rowIndex = 0; $rowIndex < scalar(@$bingoTableRef); $rowIndex++) {
                my $bingoNumber = $bingoTableRef->[$rowIndex][$columnIndex];

                $required-- if ($bingoNumber == $bingoSequenceDigit);
            }
        }
        
        return 1 if ($required == 0);
    }

    return 0;
}

# arg1 BingoTable
# arg2 BingoNumberIteration (number)
# return boolean
# Apparently bingo doesn't work diagonally so this subroutine is useless
sub isBingoDiagonally {
    my ($bingoTableRef, $iteration) = @_;

    die "Invalid bingo table\n" 
        if (scalar(@$bingoTableRef) != scalar(@{$bingoTableRef->[0]}));

    my $diagonalDownRightRequired = scalar(@$bingoTableRef);
    foreach (my $diagonalIndex = 0; $diagonalIndex < scalar(@$bingoTableRef); $diagonalIndex++) {
        my $bingoNumber = $bingoTableRef->[$diagonalIndex][$diagonalIndex];

        # Array<number>
        my @sequence = @bingoNumberSequence[0..$iteration];
        
        foreach my $bingoSequenceDigit (@sequence) {
            $diagonalDownRightRequired-- if ($bingoNumber == $bingoSequenceDigit);
        }
    }

    return 1 if ($diagonalDownRightRequired == 0);

    my $diagonalDownLeftRequired = scalar(@$bingoTableRef);
    foreach (my $diagonalIndex = 0; $diagonalIndex < scalar(@$bingoTableRef); $diagonalIndex++) {
        my $bingoNumber = $bingoTableRef->[scalar(@$bingoTableRef) - ($diagonalIndex + 1)][$diagonalIndex];

        # Array<number>
        my @sequence = @bingoNumberSequence[0..$iteration];
        
        foreach my $bingoSequenceDigit (@sequence) {
            $diagonalDownLeftRequired-- if ($bingoNumber == $bingoSequenceDigit);
        }
    }
    
    return 1 if ($diagonalDownLeftRequired == 0);
    
    return 0;
}

# arg1 BingoTable
# return number
sub sumUnmarkedNumber {
    my ($bingoTableRef, $iteration) = @_;
    
    my $sum = 0;

    # Ref<Array<number>>
    foreach my $row (@$bingoTableRef) {
        foreach my $number (@$row) {
            $sum += $number if (isUnmarkedNumber($number, $iteration) == 1);
        }
    }

    return $sum;
}

# arg1 BingoNumber (number)
# arg2 BingoNumberIteration (number)
# return boolean
sub isUnmarkedNumber {
    my ($number, $iteration) = @_;

    foreach my $bingoSequenceDigit (@bingoNumberSequence[0..$iteration]) {
        return 0 if ($number == $bingoSequenceDigit);
    }

    return 1;
}
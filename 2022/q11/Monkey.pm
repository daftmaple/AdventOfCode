#!/usr/bin/perl

package Monkey;

sub new {
    my $class = shift;

    my $self = {
        _monkeyIndex => shift,
        _items => _getStartingItemsFromString(shift), # Comma separated value of starting items
        _operation => shift, # Leave only "old + ..." part of the op
        _test => shift, # Leave only the digit divisible
        _receiverIfTrue => shift, # Leave only the digit of receiving monkey
        _receiverIfFalse => shift, # Leave only the digit of receiving monkey
        _operationCount => 0,
    };
    bless $self, $class;

    return $self;
}

sub _getStartingItemsFromString {
    my ($string) = @_;
    my @items = $string =~ /(\d+)/g;

    return \@items;
}

sub runOperation {
    my ($self, $item) = @_;

    $self->{_operationCount} += 1;

    my $mathExp = $self->{_operation} =~ s/old/$item/gr;
    return eval $mathExp;
}

sub endOfTurn {
    my ($self) = @_;

    my @empty = ();
    $self->{_items} = \@empty;
    return; 
}

sub runTestAndReturnReceiver {
    my ($self, $item) = @_;

    return $item % $self->{_test} == 0 ? $self->{_receiverIfTrue} : $self->{_receiverIfFalse};
}

# Will be reference to array
sub getItems {
    my ($self) = @_;

    return $self->{_items};
}

sub receiveItem {
    my ($self, $item) = @_;
    
    push @{$self->{_items}}, $item;

    return;
}

sub getOperationCount {
    my ($self) = @_;

    return $self->{_operationCount};
}

1;

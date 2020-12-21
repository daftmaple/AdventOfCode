#!/usr/bin/perl
use strict;
use warnings;

use List::Util qw(reduce);

my %regexes;
my @tests = ();
my $test = 0;

open F, "q19_input.txt" or die;
while (<F>) {
    chomp;
    if (!$test) {
        if (length($_) == 0) {
            $test = 1;
        } else {
            my ($k, $v) = ($_ =~ /^(\d+):\s(.*)$/);
            $regexes{$k} = $v;
        }
    } else {
        push @tests, $_;
    }
}
close F;

my $regex = simplifySameCharRegex(simplifyDotRegex(getRegex(0)));
$regex = "^$regex\$";

my $result = 0;
foreach my $item (@tests) {
    $result++ if $item =~ /$regex/;
}

print "$result\n";

sub getRegex {
    my ($key) = @_;
    my $re = $regexes{$key};
    
    if ($key == 8) {
        # 8: 42 | 42 8
        # This is equal to 8: 42 | 42 (42 | 42 8)
        # Equal to 8: 42{1} | 42{2} | 42{2} | 42{3} | ...
        # Which means 8: (42)+

        $re = getRegex(42);
        $re = "$re+";
    } elsif ($key == 11) {
        # 11: 42 31 | 42 11 31
        # This is equal to 11: 42 11? 31
        # Which is equal to 11: (42 (?1)? 31)
        
        $re = "(" . getRegex(42) . "(?1)?" . getRegex(31) . ")";
    } else {
        if ($re =~ /(\d)/) {
            my @reg = ();
            # Stuff is not parsed yet
            # Grab all items, split by pipe. This will be regex
            my @vs = ($re =~ /(\d+(?:\s\d+)*)+/g);
            foreach my $v (@vs) {
                # $v is one part of regex (86 83)
                my @item = split / /, $v;
                my $result = "";
                foreach my $it (@item) {
                    $result .= getRegex($it);
                }
                push @reg, $result;
            }
            # Combine multiple items in regex
            $re = reduce {"$a|$b"} @reg;
            # Form regex
            $re = "(?:$re)";
        } else {
            # Is character. If \" exists, replace
            $re =~ s/"//g;
        }
    }

    $regexes{$key} = $re;
    return $re;
}

sub simplifyDotRegex {
    # Because (?:b|a) or (?:a|b) is equal to .
    my ($regex) = @_;
    $regex =~ s/\(\?\:b\|a\)/./g;
    $regex =~ s/\(\?\:a\|b\)/./g;
    return $regex;
}

sub simplifySameCharRegex {
    # If prefix or suffix is equal, group them
    # Sadly, my mind can't think of regex which simplify non-capture group regex
    my ($regex) = @_;
    $regex =~  s/\(\?\:ab\|aa\)/a./g;
    $regex =~  s/\(\?\:aa\|ab\)/a./g;
    $regex =~  s/\(\?\:bb\|ba\)/b./g;
    $regex =~  s/\(\?\:ba\|bb\)/b./g;
    $regex =~  s/\(\?\:aa\|ba\)/.a/g;
    $regex =~  s/\(\?\:ba\|aa\)/.a/g;
    $regex =~  s/\(\?\:ab\|bb\)/.b/g;
    $regex =~  s/\(\?\:bb\|ab\)/.b/g;
    return $regex;
}
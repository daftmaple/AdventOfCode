#!/usr/bin/perl -w

open F, "<q06_input.txt" or die;

my %dictionary;
my %node;
my $total = 0;

while (<F>) {
    chomp $_;
    my @split = split /\)/, $_;
    $dictionary{$split[1]} = $split[0];
    $node{$split[1]} += 1;
}
close F;


for (keys %node) {
    # $_ is a distinct value of child (or parent, but will never be root node)
    # Skip if not one, since it is not the last child
    next if $node{$_} != 1;
    $e = $_;
    while (exists $dictionary{$e}) {
        $e = $dictionary{$e};
        $total++;
    }
}

print "$total\n";

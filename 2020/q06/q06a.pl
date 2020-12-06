#!/usr/bin/perl -w

@array = ();
$index = 0;
open F, "q06_input.txt" or die;
while (<F>) {
    chomp $_;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= $_;
    }
}
close F;

$count = 0;
foreach my $str (@array) {
    my %hash;
    for my $i (0..length($str)-1) {
        my $char = substr($str, $i, 1);
        $hash{$char}++;
    }
    my $ct = 0;
    for my $i ("a".."z") {
        $ct++ if defined $hash{$i};
    }
    $count += $ct;
}

print "$count\n";

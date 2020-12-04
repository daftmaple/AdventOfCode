#!/usr/bin/perl -w

@array = ();
$index = 0;
open F, "input.txt" or die;
while (<F>) {
    chomp $_;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= $_;
    }
}

$count = 0;

for (@array) {
    my $byr = ($_ =~ /(byr)/);
    my $iyr = ($_ =~ /(iyr)/);
    my $eyr = ($_ =~ /(eyr)/);
    my $hgt = ($_ =~ /(hgt)/);
    my $hcl = ($_ =~ /(hcl)/);
    my $ecl = ($_ =~ /(ecl)/);
    my $pid = ($_ =~ /(pid)/);
    my $cid = ($_ =~ /(cid)/);
    if ($byr + $iyr + $eyr + $hgt + $hcl + $ecl + $pid >= 7) {
        $count++;
    }
}

print "$count\n";

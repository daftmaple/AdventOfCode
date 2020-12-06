#!/usr/bin/perl
use strict;
use warnings;

my @array = ();
my $index = 0;
open F, "q04_input.txt" or die;
while (<F>) {
    chomp;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= " " . $_;
    }
}
close F;

my $count = 0;

for (@array) {
    my $valid = 0;
    
    my $byr = ($_ =~ /(?:byr):(\d+)/)[0];
    $valid++ if (defined $byr) and ($byr >= 1920 and $byr <= 2002);
    
    my $iyr = ($_ =~ /(?:iyr):(\d+)/)[0];
    $valid++ if (defined $iyr) and ($iyr >= 2010 and $iyr <= 2020);

    my $eyr = ($_ =~ /(?:eyr):(\d+)/)[0];
    $valid++ if (defined $eyr) and ($eyr >= 2020 and $eyr <= 2030);

    my @hgt = ($_ =~ /(?:hgt):(\d+)(cm|in)/);
    if (defined $hgt[0] and defined $hgt[1]) {
        if ($hgt[1] eq "cm" and $hgt[0] >= 150 and $hgt[0] <= 193) {
            $valid++;
        } elsif ($hgt[1] eq "in" and $hgt[0] >= 59 and $hgt[0] <= 76) {
            $valid++;
        }
    }

    my $hcl = ($_ =~ /(?:hcl):#([0-9a-f]{6})/)[0];
    $valid++ if (defined $hcl);

    my $ecl = ($_ =~ /(?:ecl):(amb|blu|brn|gry|grn|hzl|oth)\b/)[0];
    $valid++ if (defined $ecl);

    my $pid = ($_ =~ /(?:pid):(\d{9})\b/)[0];
    $valid++ if (defined $pid); 

    if ($valid >= 7) {
        $count++;
    }
}

print "$count\n";

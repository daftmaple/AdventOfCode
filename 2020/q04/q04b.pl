#!/usr/bin/perl -w

@array = ();
$index = 0;
open F, "input.txt" or die;
while (<F>) {
    chomp $_;
    if (length($_) == 0) {
        $index++;
    } else {
        $array[$index] .= " " . $_;
    }
}

$count = 0;

for (@array) {
    my $valid = 0;
    
    my $byr = ($_ =~ /(byr):(\d+)/)[1];
    $valid++ if (defined $byr) and ($byr >= 1920 and $byr <= 2002);
    
    my $iyr = ($_ =~ /(iyr):(\d+)/)[1];
    $valid++ if (defined $iyr) and ($iyr >= 2010 and $iyr <= 2020);

    my $eyr = ($_ =~ /(eyr):(\d+)/)[1];
    $valid++ if (defined $eyr) and ($eyr >= 2020 and $eyr <= 2030);

    my @hgt = ($_ =~ /(hgt):(\d+)(cm|in)/);
    if (defined $hgt[1] and defined $hgt[2]) {
        if ($hgt[2] eq "cm" and $hgt[1] >= 150 and $hgt[1] <= 193) {
            $valid++;
        } elsif ($hgt[2] eq "in" and $hgt[1] >= 59 and $hgt[1] <= 76) {
            $valid++;
        }
    }

    my $hcl = ($_ =~ /(hcl):#([0-9a-f]{6})/)[1];
    $valid++ if (defined $hcl);

    my $ecl = ($_ =~ /(ecl):(amb|blu|brn|gry|grn|hzl|oth)\b/)[1];
    $valid++ if (defined $ecl);

    my $pid = ($_ =~ /(pid):(\d{9})\b/)[1];
    $valid++ if (defined $pid); 

    if ($valid >= 7) {
        $count++;
    }
}

print "$count\n";

#!/usr/bin/perl -w

my $all = 0;
open F, "<q02_input.txt" or die;
while (<F>) {
    chomp $_;
    my ($min, $max, $char, $word) = $_ =~ /^(\d+)\-(\d+)\s(\w+)\:\s(\w+)$/;
    my $count = 0;
    for $i (0..length($word)-1) {
        if (substr($word, $i, 1) eq $char) {
            $count++;
        }
    }
    $all += 1 if ($count >= $min and $count <= $max);
}
close F;

print "$all\n";

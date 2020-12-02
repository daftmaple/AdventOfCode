#!/usr/bin/perl -w

my $all = 0;
open F, "<q02_input.txt" or die;
while (<F>) {
    chomp $_;
    my $min = ($_ =~ /^(\d+)\-/)[0];
    my $max = ($_ =~ /\-(\d+)/)[0];
    my $char = ($_ =~ /^.*(\w+)\:/)[0];
    my $word = ($_ =~ /(\w+)$/)[0];
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

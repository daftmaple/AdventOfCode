#!/usr/bin/perl -w

my $all = 0;
open F, "<q02_input.txt" or die;
while (<F>) {
    chomp $_;
    my $min = ($_ =~ /^(\d+)\-/)[0];
    my $max = ($_ =~ /\-(\d+)/)[0];
    my $char = ($_ =~ /^.*(\w+)\:/)[0];
    my $word = ($_ =~ /(\w+)$/)[0];
    my @chars = split //, $word;
    my $count = 0;
    $count++ if $chars[$min - 1] eq $char;
    $count++ if $chars[$max - 1] eq $char;
    $all += 1 if ($count == 1);
}
close F;

print "$all\n";

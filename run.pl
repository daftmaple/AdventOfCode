#!/usr/bin/perl
use strict;
use warnings;

die "Need more arguments. Format: $0 <year> <day> <problem a/b>" if (@ARGV != 3);

my $year = $ARGV[0];
my $day = sprintf("%02d", $ARGV[1]);
my $problem = $ARGV[2];


exec ("docker run -it --rm --name my-running-script -v \"\$PWD\":/usr/src/myapp -w /usr/src/myapp/$year/q$day perl:5 perl q$day$problem.pl");

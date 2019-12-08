#!/usr/bin/perl -w

use Digest::MD5 qw(md5_hex);

die "Need more arguments" if (@ARGV != 1);
$input = $ARGV[0];

$a = 1;
while (1) {
    my $res = md5_hex($input . $a);
    if ($res =~ /^000000/) {
        print "$a\n" and exit;
    }
    $a++;
}


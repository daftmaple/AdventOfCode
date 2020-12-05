#!/usr/bin/perl -w

@array = ();
open F, "q05_input.txt" or die;
while (<F>) {
    chomp $_;
    s/[FL]/0/g;
    s/[BR]/1/g;
    my $res = $_;
    my $bin1 = substr $res, 0, 7;
    my $row = bin2dec($bin1);

    my $bin2 = substr $res, 7, 10;
    my $col = bin2dec($bin2);

    my $sID = $row * 8 + $col;

    push @array, $sID;
}

@sorted = sort @array;

for (my $i = 0; $i < scalar(@sorted) - 1; $i++) {
    if ($sorted[$i] + 2 == $sorted[$i + 1]) {
        $result = $sorted[$i] + 1;
        print "$result\n";
        exit;
    }
}


sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

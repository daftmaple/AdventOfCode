#!/usr/bin/perl
use strict;
use warnings;

my @strings = ();

open F, "<q12_input.txt" or die;
while (<F>) {
    chomp $_;
    push @strings, $_;
}
close F;

my @moons = generate(\@strings);
my @origin = generate(\@strings);

sub generate {
    my ($ref) = (@_);
    my @result = ();
    foreach my $item (@$ref) {
        my %hash;

        # Set coordinate
        $hash{"pos"}{"x"} = ($item =~ /(?:x)=\s*(-?\d+)/)[0];
        $hash{"pos"}{"y"} = ($item =~ /(?:y)=\s*(-?\d+)/)[0];
        $hash{"pos"}{"z"} = ($item =~ /(?:z)=\s*(-?\d+)/)[0];

        # Set starting velocity to 0, 0, 0
        $hash{"vel"}{"x"} = 0;
        $hash{"vel"}{"y"} = 0;
        $hash{"vel"}{"z"} = 0;

        # Store reference to current moon position and velocity in moons
        push @result, \%hash;
    }
    return @result;
}

my $i = 0;
my $ix;
my $iy;
my $iz;

my $moonCount = scalar(@moons);
while (1) {
    # Calculate velocity, iterate through each moon
    for (my $cur = 0; $cur < $moonCount; $cur++) {
        # Compare to other moons
        # Get velocity for x, y, z
        my $x = %{$moons[$cur]{"vel"}}{"x"};
        my $y = %{$moons[$cur]{"vel"}}{"y"};
        my $z = %{$moons[$cur]{"vel"}}{"z"};
        for (my $oth = 0; $oth < $moonCount; $oth++) {
            next if $cur == $oth;
            # Increment/decrement $x, $y, $z based on pos comparison
            if (%{$moons[$cur]{"pos"}}{"x"} < %{$moons[$oth]{"pos"}}{"x"}) {
                $x++;
            } elsif (%{$moons[$cur]{"pos"}}{"x"} > %{$moons[$oth]{"pos"}}{"x"}) {
                $x--;
            }

            if (%{$moons[$cur]{"pos"}}{"y"} < %{$moons[$oth]{"pos"}}{"y"}) {
                $y++;
            } elsif (%{$moons[$cur]{"pos"}}{"y"} > %{$moons[$oth]{"pos"}}{"y"}) {
                $y--;
            }

            if (%{$moons[$cur]{"pos"}}{"z"} < %{$moons[$oth]{"pos"}}{"z"}) {
                $z++;
            } elsif (%{$moons[$cur]{"pos"}}{"z"} > %{$moons[$oth]{"pos"}}{"z"}) {
                $z--;
            }
        }

        # Store velocity of each moon
        $moons[$cur]{"vel"}{"x"} = $x;
        $moons[$cur]{"vel"}{"y"} = $y;
        $moons[$cur]{"vel"}{"z"} = $z;
    }

    # Apply velocity to current position
    for (my $cur = 0; $cur < $moonCount; $cur++) {
        my $x = %{$moons[$cur]{"pos"}}{"x"};
        my $y = %{$moons[$cur]{"pos"}}{"y"};
        my $z = %{$moons[$cur]{"pos"}}{"z"};

        my $px = %{$moons[$cur]{"vel"}}{"x"};
        my $py = %{$moons[$cur]{"vel"}}{"y"};
        my $pz = %{$moons[$cur]{"vel"}}{"z"};

        $moons[$cur]{"pos"}{"x"} = $x + %{$moons[$cur]{"vel"}}{"x"};
        $moons[$cur]{"pos"}{"y"} = $y + %{$moons[$cur]{"vel"}}{"y"};
        $moons[$cur]{"pos"}{"z"} = $z + %{$moons[$cur]{"vel"}}{"z"};
    }

    # Increment loop
    $i++;

    # Check if condition after a step is equal to original coordinate
    my $tx = 0;
    for (my $cur = 0; $cur < $moonCount; $cur++) {
        $tx++ if %{$moons[$cur]{"pos"}}{"x"} == %{$origin[$cur]{"pos"}}{"x"} and %{$moons[$cur]{"vel"}}{"x"} == %{$origin[$cur]{"vel"}}{"x"} ;
    }
    $ix = $i if !defined $ix and $tx == $moonCount;

    my $ty = 0;
    for (my $cur = 0; $cur < $moonCount; $cur++) {
        $ty++ if %{$moons[$cur]{"pos"}}{"y"} == %{$origin[$cur]{"pos"}}{"y"} and %{$moons[$cur]{"vel"}}{"y"} == %{$origin[$cur]{"vel"}}{"y"};
    }
    $iy = $i if !defined $iy and $ty == $moonCount;

    my $tz = 0;
    for (my $cur = 0; $cur < $moonCount; $cur++) {
        $tz++ if %{$moons[$cur]{"pos"}}{"z"} == %{$origin[$cur]{"pos"}}{"z"} and %{$moons[$cur]{"vel"}}{"z"} == %{$origin[$cur]{"vel"}}{"z"} ;
    }
    $iz = $i if !defined $iz and $tz == $moonCount;

    last if defined $ix and defined $iy and defined $iz;
}

my $result = lcm($ix, $iy);
$result = lcm($result, $iz);

print "$result\n";

sub gcd {
	my ($x, $y) = @_;
	while ($y) { ($x, $y) = ($y, $x % $y) }
	$x
}

sub lcm {
	my ($x, $y) = @_;
	return $x * $y / gcd($x, $y);
}

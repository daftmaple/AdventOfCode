#!/usr/bin/perl
use strict;
use warnings;

$step = 1000;

my @moons = ();

open F, "<q12_input.txt" or die;
while (<F>) {
    chomp $_;
    my %hash;

    # Set coordinate
    $hash{"pos"}{"x"} = ($_ =~ /(?:x)=(-?\d+)/)[0];
    $hash{"pos"}{"y"} = ($_ =~ /(?:y)=(-?\d+)/)[0];
    $hash{"pos"}{"z"} = ($_ =~ /(?:z)=(-?\d+)/)[0];

    # Set starting velocity to 0, 0, 0
    $hash{"vel"}{"x"} = 0;
    $hash{"vel"}{"y"} = 0;
    $hash{"vel"}{"z"} = 0;

    # Store reference to current moon position and velocity
    push @moons, \%hash;
}
close F;

$i = 0;
while ($i < $step) {
    # Calculate velocity, iterate through each moon
    for (my $cur = 0; $cur < scalar(@moons); $cur++) {
        # Compare to other moons
        # Get velocity for x, y, z
        my $x = %{$moons[$cur]{"vel"}}{"x"};
        my $y = %{$moons[$cur]{"vel"}}{"y"};
        my $z = %{$moons[$cur]{"vel"}}{"z"};
        for (my $oth = 0; $oth < scalar(@moons); $oth++) {
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
    for (my $cur = 0; $cur < scalar(@moons); $cur++) {
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
    $i++;
}

$energy = 0;

# Calculate energy
for (my $cur = 0; $cur < scalar(@moons); $cur++) {
    my $x = abs(%{$moons[$cur]{"pos"}}{"x"});
    my $y = abs(%{$moons[$cur]{"pos"}}{"y"});
    my $z = abs(%{$moons[$cur]{"pos"}}{"z"});
    my $px = abs(%{$moons[$cur]{"vel"}}{"x"});
    my $py = abs(%{$moons[$cur]{"vel"}}{"y"});
    my $pz = abs(%{$moons[$cur]{"vel"}}{"z"});

    $energy += ($x + $y + $z) * ($px + $py + $pz);
}

print "$energy\n";

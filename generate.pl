#!/usr/bin/perl
use strict;
use warnings;

die "Need more arguments. Format: $0 <year> <day> <problem a/b>" if (@ARGV != 3);

my $year = $ARGV[0];
my $day = sprintf("%02d", $ARGV[1]);
my $problem = $ARGV[2];

use File::Basename qw( fileparse );
use File::Path qw( make_path );

my $filePath = "$year/q$day/q$day$problem.pl";

my ( $file, $directory ) = fileparse $filePath;

if ( !-d $directory ){
    make_path $directory;
}

my $inputFilePath = "$year/q$day/q$day\_input.txt";

# Create input file if doesn't exist
if (-e $inputFilePath) {
    print "Input file $directory already exists\n";
} else {
    open my $inputFh, ">", $inputFilePath;
    close $inputFh;
}

if (-e $filePath) {
    print "File $file in $directory already exists\n";
    exit;
}

my $templateFile = <<"FINAL";
#!/usr/bin/perl
use strict;
use warnings;

open F, "q$day\_input.txt" or die;
chomp(my \@input = <F>);
close F;

foreach my \$line (\@input) {

}
FINAL

open my $scriptFh, ">", $filePath;
print $scriptFh $templateFile;
close $scriptFh;

#!/usr/bin/perl
use strict;
use warnings;

die "Need more arguments. Format: $0 <year> <day>" if (@ARGV != 2);

my $year = $ARGV[0];
my $day = sprintf("%02d", $ARGV[1]);

use File::Basename qw( fileparse );

my $directory = "$year/q$day";

use File::Path qw( make_path );
if ( !-d $directory ){
    make_path $directory;
}

# Create input file if doesn't exist
my $inputFilePath = "$directory/q$day\_input.txt";
if (-e $inputFilePath) {
    print "Input file in $directory already exists\n";
} else {
    open my $inputFh, ">", $inputFilePath;
    close $inputFh;
}

# Create problem file if doesn't exist;
createFile("$directory/q${day}a.pl");
createFile("$directory/q${day}b.pl");


sub createFile {
    my ( $filePath ) = @_;
    my ( $file, $directory ) = fileparse $filePath;
    if (-e $filePath) {
        print "File $file in $directory already exists\n";
        return;
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

    system("chmod u+x $filePath");
}

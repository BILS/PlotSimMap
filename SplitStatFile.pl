#!/usr/bin/perl 

=head2 SplitStatFile.pl

         FILE: SplitStatFile.pl

        USAGE: ./SplitStatFile.pl  statfile

  DESCRIPTION: split the stat file in bip.txt, and chars.txt

      OPTIONS: ---
 REQUIREMENTS: ---
         BUGS: ---
        NOTES: ---
       AUTHOR: Johan Nylander 
      COMPANY: NRM/BILS
      VERSION: 1.0
      CREATED: 10/29/2012 02:33:26 PM
     REVISION: ---

=cut

use strict;
use warnings;

exec("perldoc", $0) unless (@ARGV);

my $bip_file = "bip.txt";
my $chars_file = "chars.txt";

## Open infile to extract the bipartition table, and the characters part
open my $BIP, ">", $bip_file or die "Could not open bipartition file for writing. $! \n";
open my $CHARS, ">", $chars_file or die "Could not open characters file for writing. $! \n";

while (<>) {

    my $line = $_;
    chomp($line);

    next if $line =~ /^\s*$/;
    next if $line =~ /^\[|\]/;

    if ($line =~ /^\d+:\s/) {
        print $BIP $line, "\n";
    }
    elsif ($line =~ /^Site/) {
        $line =~ s/Pr\(//g;
        $line =~ s/\)//g;
        print $CHARS $line, "\n";
    }
    else { # no error checking!
        print $CHARS $line, "\n";
    }
}

close($BIP);
close($CHARS);

exit();


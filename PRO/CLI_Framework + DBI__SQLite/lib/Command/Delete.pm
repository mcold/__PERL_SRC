use 5.010;

package Command::Delete;
use base qw( CLI::Framework::Command );
use strict;
use warnings;

use DBI;

our $db_dir = 'db';
our $db_name = 'Data.db';


our $dbh = DBI->connect("dbi:SQLite:dbname=./$db_dir/$db_name", "","");

sub usage_text {
    q{}
} 

sub run {
    # system 'clear screen';
    say "DELETE AUTO";
    say "-"x20;
    print "Enter vin number: ";
    my $vin = scalar <STDIN>;
    $vin =~ s/\s+//;
    $dbh->do("delete from auto where vin = $vin");
    say "Auto with vin = $vin is deleted!";
}


1;


__DATA__
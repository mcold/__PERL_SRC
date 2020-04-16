use 5.010;

package Command::SelectAll;
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
    system 'clear screen';
    say "SELECT ALL";
    say "-"x20;
    my $sth = $dbh->prepare("select * from auto 
                            order by vin asc");
    $sth->execute;
    my @title = ('vin', 'pts', 'product_date', 'util_date');
    say join("\t", @title);
    while ( my @row = $sth->fetchrow_array ) {
        say join("\t", @row);
    }
}

1;

__DATA__
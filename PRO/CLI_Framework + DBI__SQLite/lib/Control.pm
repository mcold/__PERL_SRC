package Control;   
use base qw( CLI::Framework );
use strict;
use warnings;
use DBI;

use 5.010;

our $db_dir = 'db';
our $db_name = 'Data.db';

sub usage_text {
   qq{  
ARGUMENTS (subcommands):
    add:        add auto
    delete:     delete auto
    select:     select auto by dates
    selectall:  select all auto
    }
}

sub command_map {
    add         =>  'Command::Add',
    delete      =>  'Command::Delete',
    select      =>  'Command::Select',
    selectall   =>  'Command::SelectAll',
}

sub command_alias {
    a       => 'add',
    d       => 'delete',
    s       => 'select',
    sa      => 'selectall',
}

sub init {
    if(!-e "./$db_dir"){
        mkdir $db_dir;
    }

    if (!-e "./$db_dir/$db_name"){
        say 'Database is absent!!!';
        my $dbh = DBI->connect("dbi:SQLite:dbname=./$db_dir/$db_name", "","");
        $dbh->do("create table auto(vin integer primary key autoincrement
                    , pts text
                    , product_date date
                    , util_date date)");
    }
}
1;
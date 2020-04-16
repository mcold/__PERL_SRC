use 5.010;

package Command::Select;
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
    say "SELECT AUTO BY DATE";
    say "-"x20;
    my($first_date, $second_date) = (get_date('begin'), get_date('end'));
    ($first_date, $second_date) = define_date($first_date, $second_date);
    my $sth = $dbh->prepare("select * from auto 
                            where 
                                ('$second_date' >= product_date and '$second_date' <= util_date)
                                or
                                ('$first_date' >= product_date and '$first_date' <= util_date)
                                or
                                ('$first_date' >= product_date and '$second_date' <= util_date)
                            order by vin asc");
    $sth->execute;
    my @title = ('vin', 'pts', 'product_date', 'util_date');
    say join("\t", @title);
    while ( my @row = $sth->fetchrow_array ) {
       say join("\t", @row);
    }
}


sub get_date{
    my $main = shift;
    my $date;
    # system('cls');
    while(){
        print "Enter date of $main in format yyyy-mm-dd: ";
        $date = scalar <STDIN>;
        if($date =~ /\d{4}-\d{2}-\d{2}/){
            return $date;
        }
        else{
            say 'Not correct format';
        }
    }
}

sub define_date{
    my ($first_date, $second_date) = (shift, shift);
    my $sth = $dbh->prepare("select case when '$first_date' > '$second_date' then 1 else 0 end");
    $sth->execute;
    my $res = $sth->fetchrow_array;
    if($res){ return $second_date, $first_date;}
    else{return $first_date, $second_date;}
}

1;

__DATA__
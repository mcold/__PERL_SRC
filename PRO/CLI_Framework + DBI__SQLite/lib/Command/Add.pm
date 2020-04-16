use 5.010;

package Command::Add;
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
    say "ADD AUTO";
    say "-"x20;
    print "Enter pts number:\t";
    my $pts = scalar <STDIN>;
    $pts =~ s/\s+//;
    my $product_date = get_date('production');
    my $util_date = get_date('utilization');

    if(more_date($product_date, $util_date)){
        say 'Date of utilization can\'t be more than date of production';
        exit;
    }

    $dbh->do("insert into auto(pts
                            , product_date
                            , util_date)
                            values('$pts'
                                    , '$product_date'
                                    ,'$util_date')"
    );
}


sub get_date{
    my $main = shift;
    my $date;
    # system('cls');
    while(){
        print "Enter date of $main in format yyyy-mm-dd:\t";
        $date = scalar <STDIN>;
        if($date =~ /\d{4}-\d{2}-\d{2}/){
            if(!proof($date)){
               say 'Not correct format';
               next; 
            }
            $date =~ s/\s+//;
            return $date;
        }
        else{
            say 'Not correct format';
        }
    }
}


sub proof{
    my $date = shift;
    my @arr = split('-', $date);
    if($arr[1] > 12 or $arr[2] > 31){
        return 0;
    }
    return 1;
}


sub more_date{
    my ($first_date, $second_date) = (shift, shift);
    my $sth = $dbh->prepare("select case when '$first_date' > '$second_date' then 1 else 0 end");
    $sth->execute;
    my $res = $sth->fetchrow_array;
    return $res;
}
1;


__DATA__

create table auto(vin integer primary key autoincrement
                    , pts text
                    , product_date date
                    , util_date date);

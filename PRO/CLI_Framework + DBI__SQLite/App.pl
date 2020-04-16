use 5.010;

use FindBin qw($Bin);
use lib "$Bin/lib";
use lib "$Bin/lib/Command";
use Control;



Control->run;


1;
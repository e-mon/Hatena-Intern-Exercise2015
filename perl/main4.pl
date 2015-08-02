use strict;
use warnings;

use Parser;
use Viewer;

my $parser = Parser->new( filename => '../sample_data/large_log.ltsv' );
Viewer::viewer( $parser->parse , 10);


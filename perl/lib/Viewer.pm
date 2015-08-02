package Viewer;

use strict;
use warnings;

use Parser;
use LogCounter;
use Viewer;
use DateTime;
use Term::ANSIColor qw( :constants );
$Term::ANSIColor::AUTORESET = 1;

sub viewer {
    my $logs      = shift;
    my $threshold = shift;
    my $counter   = LogCounter->new($logs);
    my $hours     = $counter->group_by_hour;
    my $lines     = [];

    print("-- :        100       200\n");
    my $font_color = 0;

    foreach my $hour ( keys($hours) ) {
        printf( "%02d :", $hour );
        my $counter = 0;
        my @sorted = sort { DateTime->compare( $a->time, $b->time ) }
            @{ $hours->{$hour} };
        foreach my $log (@sorted) {
            if ( $log->{status} =~ /5../ ) {
                $font_color = 1;
            }

            if ( ( $counter % $threshold ) == 0 ) {
                if ($font_color) {
                    print RED "=";
                }
                else {
                    print GREEN "=";
                }
                $font_color = 0;
            }
            $counter++;
        }
        print("\n");
    }
}

1

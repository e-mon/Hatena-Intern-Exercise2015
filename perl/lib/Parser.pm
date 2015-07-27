package Parser;
use strict;
use warnings;
use Log;

sub new {
    my ( $class, %args ) = @_;
    return bless \%args, $class;
}

sub parse {
    my ( $self, $line ) = @_;
    open my $fh, '<', $self->{filename} or die $!;
    return [ map { $self->_parser($_) } <$fh> ];
}

sub _parser {
    my $line   = $_;
    my %params = ( $line =~ /(\w+):(.+?)[\t|\n]/g );
    my %log;

    foreach my $key ( keys %params ) {
        if ( $params{$key} ne "-" ) {
            $log{$key} = $params{$key};
        }
    }

    return Log->new(%log);
}

1;

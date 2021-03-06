package Log;
use strict;
use warnings;
use DateTime;

sub new {
    my ( $class, %args ) = @_;
    return bless \%args, $class;
}

sub protocol {
    my $self = shift;
    my @req = split( ' ', $self->{req} );

    return $req[2];
}

sub method {
    my $self = shift;
    my @req = split( ' ', $self->{req} );

    return $req[0];
}

sub path {
    my $self = shift;
    my @req = split( ' ', $self->{req} );

    return $req[1];
}

sub uri {
    my $self = shift;
    return "http://" . $self->{host} . $self->path;
}

sub time {
    my $self = shift;
    return DateTime->from_epoch( epoch => $self->{epoch} );
}

sub to_hash {
    my $self   = shift;
    my $params = {
        'method' => $self->method,
        'time'   => $self->time,
        'uri'    => $self->uri
    };
    my $ret = { %{$self}, %{$params} };
    delete $ret->{epoch};
    delete $ret->{host};
    delete $ret->{req};

    return $ret;
}

1;

package LogCounter;
use strict;
use warnings;

sub new {
    my ( $class, $logs ) = @_;
    return bless { logs => $logs }, $class;
}

sub group_by_user {
    my $self = shift;
    return $self->_group_by_key( key => 'user', replaced_by => 'guest' );
}

sub count_error {
    my $self = shift;
    return $self->_count_status( status => '5..' );
}

sub _group_by_key {
    my ( $self, %args ) = @_;
    my $key         = $args{key};
    my $replaced_by = $args{replaced_by};
    my $ret         = {};

    # TODO: need to check whether key exists in log->{to_hash}
    foreach my $log ( @{ $self->{logs} } ) {
        if ( exists( $log->{$key} ) ) {
            if ( exists( $ret->{ $log->{$key} } ) ) {
                push( $ret->{ $log->{$key} }, $log );
            }
            else {
                $ret->{ $log->{$key} } = [$log];
            }
        }
        else {
            if ( exists( $ret->{$replaced_by} ) ) {
                push( $ret->{$replaced_by}, $log );
            }
            else {
                $ret->{$replaced_by} = [$log];
            }
        }
    }

    return $ret;
}

sub _count_status {
    my ( $self, %args) = @_;
    my $status = $args{status};

    grep { $_->{status} =~ /$status/ } @{$self->{logs}};
}

1;

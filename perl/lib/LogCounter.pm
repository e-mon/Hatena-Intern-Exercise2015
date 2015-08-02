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

sub group_by_hour {
    my $self      = shift;
    my $formatter = sub {
        my ( $key, $log ) = @_;

        return $log->time->hour;
    };
    return $self->_group_by_key( key => 'time', format => $formatter );
}

sub count_error {
    my $self = shift;
    return $self->_count_status( status => '5..' );
}

sub _group_by_key {
    my ( $self, %args ) = @_;
    my $key         = $args{key};
    my $replaced_by = $args{replaced_by};
    my $formatter   = $args{format};
    my $ret         = {};
    my @logs        = @{ $self->{logs} };

    if ( defined($formatter) ) {
        @logs = map { [ $formatter->( $key, $_ ), $_ ] } @logs;
    } else {
        @logs = map { [ exists $_->{$key} ? $_->{$key} : $replaced_by , $_ ] } @logs;
    }

    # TODO: need to check whether key exists in log->{to_hash}
    foreach my $field (@logs) {
        my ($field_key, $field_log) = @$field;

        if (exists $ret->{$field_key}){
            push($ret->{$field_key},$field_log);
         }else{
             $ret->{$field_key} = [$field_log];
         }
    }

    return $ret;
}

sub _count_status {
    my ( $self, %args ) = @_;
    my $status = $args{status};

    grep { $_->{status} =~ /$status/ } @{ $self->{logs} };
}

1;

#!C:/xampp/perl/bin/perl

package MySQL_Connection;

use strict;
use DBI;

sub new {
    my ($self)  = @_;
    $self   = {};
    # MySQL database configuration
    $self->{db_name} = "new_database";
    $self->{host} = "localhost";
    $self->{dsn} = qq(DBI:mysql:database=$self->{db_name}:host=$self->{host});
    $self->{username} = "root";
    $self->{password} = "My\$ql2oo4";

    $self->{db} = Connection_DB($self);
    return bless $self;
}



sub Connection_DB {
    my ($self)      = @_;

    # connect to MySQL database

    my %attr = (
        PrintError => 0,  # turn off error reporting via warn()
        RaiseError => 1,  # turn on error reporting via die()
        AutoCommit => 1
    );


    $self->{db}  = DBI->connect(
        $self->{dsn},
        $self->{username},
        $self->{password},
        \%attr
    );
    #print "Connected to the MySQL database.\n";
    return $self->{db};
}



1;
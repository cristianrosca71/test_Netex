#!C:/xampp/perl/bin/perl

package Contacts;

use strict;
use DBI;

sub new {
    my ($self,$case)  = @_;
    $self   = {};
    # MySQL database configuration
    $self->{db_name} = "new_database";
    $self->{host} = "localhost";
    $self->{dsn} = qq(DBI:mysql:database=$self->{db_name}:host=$self->{host});
    $self->{username} = "root";
    $self->{password} = "My\$ql2oo4";

    # $self->{db} = Connection_DB($self);
    
    if ( $case eq 'contacts' ) {
        GET_Contacts($self);
    }
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
    print "Connected to the MySQL database.\n";
    return $self->{db};
}

sub GET_Contacts {
    my ($self)      = @_;
    my $q = qq(
			SELECT  ci.contact_id AS 'contact_id',
			        ci.contact_first_name AS 'contact_first_name',
			        ci.contact_last_name AS 'contact_last_name',
			        ci.contact_email_address AS 'contact_email_address',
              ci.contact_phone AS 'contact_phone',
			        ci.contact_address AS 'contact_address',
			        cp.contact_photo AS 'contact_photo'
			FROM   new_database.contact_info ci LEFT JOIN new_database.contact_photo cp ON ( cp.contact_id = ci.contact_id )
			ORDER BY ci.contact_id
			LIMIT 50
                  );
    #print qq($q\n);
    my $sth = $self->{db}->prepare($q);
    $sth->execute();
    my $count = 0;
    while (my $hr = $sth->fetchrow_hashref()) {
        #
        $count +=1;
        my $key = $hr->{contact_email_address};
        #push( @{$self->{CONTACTS}->{$key}->{First_Name}}, $hr->{people_first_name} );

        $self->{CONTACTS}->{$key}->{Id}              = $hr->{contact_id};
        $self->{CONTACTS}->{$key}->{First_Name}      = $hr->{contact_first_name};
        $self->{CONTACTS}->{$key}->{Last_Name}       = $hr->{contact_last_name};
        $self->{CONTACTS}->{$key}->{Email_Address}   = $hr->{contact_email_address};
        $self->{CONTACTS}->{$key}->{Phone}	         = $hr->{contact_phone};
        $self->{CONTACTS}->{$key}->{Address}         = $hr->{contact_address};
        $self->{CONTACTS}->{$key}->{Photo}	         = $hr->{contact_photo};
        #
    }
    $self->{CONTACTS_Count} = $count;
}

1;
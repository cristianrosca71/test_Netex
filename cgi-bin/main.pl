#!C:/xampp/perl/bin/perl

use strict;
use warnings;
use v5.10; # for say() function
use lib 'C:/xampp/htdocs/contacts_address_book/lib';
use Lib;

use DBI;
use CGI::Carp; # send errors to the browser, not to the logfile
use CGI;
use MySQL_Connection;

my $cgi = CGI->new(); # create new CGI object

my %App;
my $app = \%App;

# Connection_DB($app);
$app = new MySQL_Connection($app);
GET_Contacts($app);

#my $isLogIn = $cgi->param('isLogIn');

my $isLogIn = 'TRUE';
my $html_contacts_rows;

# Create List of contacts
for my $c ( sort { $a <=> $b } keys %{ $app->{CONTACTS} } ) {
    $html_contacts_rows .= qq(    
                <tr style="color: beige; background: darkcyan;">
                  <td class="middle">
                    <div class="media-left">
                      <a href="#">
                        <img class="media-object" src="../photos/$app->{CONTACTS}->{$c}->{Photo}.jpg" alt="..." style="object-fit:cover; width:130px; height:130px;">
                      </a>
                    </div>
                  </td>
                  <td class="middle">
                    <div class="media-body">
                      <h4 class="media-heading">$app->{CONTACTS}->{$c}->{First_Name}, $app->{CONTACTS}->{$c}->{Last_Name}</h4>
                      <address>
                        <strong>$app->{CONTACTS}->{$c}->{Email_Address}</strong><br>
                        $app->{CONTACTS}->{$c}->{Address}
                      </address>
                    </div>
                  </td>
                  <td width="100" class="middle">
                    <div>
                      <a href="#" class="button-edit" title="Edit"> <img src="../img/edit.png">
                        
                      </a>
                      <a href="#" class="button-delete" title="Delete"> <img src="../img/delete.png">
                        
                      </a>
                    </div>
                  </td>
                </tr>
    );
}
my $Show_New_Contact_Button = "";
if ($isLogIn eq 'TRUE') {
$Show_New_Contact_Button .= qq(
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a href="form.html" class="btn btn-outline-primary">Add New</a></li>
          </ul>
        </div>
);
}


#print CGI::header();
my $html = "";

print $cgi->header('text/html');




$html .= qq(
               <tr style="color: beige; background: darkcyan;">
                <td></td>
                <td></td>
                <td>
                   <div class="top-button">
                  <a href = "#">
                   </div>
                </td>

                $html_contacts_rows
);



print $html;



sub GET_Contacts {
    my ($app)      = @_;
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
    my $sth = $app->{db}->prepare($q);
    $sth->execute();
    my $count = 0;
    while (my $hr = $sth->fetchrow_hashref()) {
        #
        $count +=1;
        my $key = $hr->{contact_id};
        #push( @{$app->{CONTACTS}->{$key}->{First_Name}}, $hr->{people_first_name} );

        $app->{CONTACTS}->{$key}->{First_Name}      = $hr->{contact_first_name};
        $app->{CONTACTS}->{$key}->{Last_Name}       = $hr->{contact_last_name};
        $app->{CONTACTS}->{$key}->{Email_Address}   = $hr->{contact_email_address};
        $app->{CONTACTS}->{$key}->{Phone}	          = $hr->{contact_phone};
        $app->{CONTACTS}->{$key}->{Address}         = $hr->{contact_address};
        $app->{CONTACTS}->{$key}->{Photo}	          = $hr->{contact_photo};
        #
    }
    $app->{CONTACTS_Count} = $count;
}


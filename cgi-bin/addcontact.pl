#!C:/xampp/perl/bin/perl

use strict;
use warnings;
use v5.10; # for say() function
use lib 'C:/xampp/htdocs/contacts_address_book/lib';
use Lib;

use CGI qw/:standard/;
use warnings;
use JSON qw( encode_json decode_json );
#use JSON::MaybeXS qw(encode_json decode_json);
use LWP::Simple 'get'; 
use Data::Dumper; 
use DBI;
use CGI::Carp; # send errors to the browser, not to the logfile
use File::Basename;
 

my %App;
my $app = \%App;

# read the CGI params
my $cgi = CGI->new;

use MySQL_Connection;
use Contacts;

my $firstname	    = $cgi->param("firstname");
my $lastname	    = $cgi->param("lastname");
my $email           = $cgi->param("email");
my $address	        = $cgi->param("address");
my $uploadfile      = $cgi->param("uploadfile");

my $encryptfile;


$uploadfile =~s/C:\\fakepath\\/D:\\Projects\\Perl_Projects\\Project_contacts\\photos\\/;
my $file = $uploadfile;
my $dir = "C:\\xampp\\htdocs\\contacts_address_book\\photos";

$file=~m/^.*(\\|\/)(.*)/;
# strip the remote path and keep the filename
my $name = $2;
print STDERR "$name";
open(LOCAL, ">$dir/$name") or print 'error';
my $file_handle = $cgi->upload("uploadfile");     # get the handle, not just the filename
binmode LOCAL;
while(<$file_handle>) {               # use that handle    
    print LOCAL;
 }
 close($file_handle);                        # clean the mess
 close(LOCAL);                               # 
 print $cgi->header();
 print $dir/$name;
 print "$file has been successfully uploaded... thank you.\n";






# Connection_DB($app);
$app    = new MySQL_Connection($app);

my $q;

$q = qq(
            SELECT  contact_id AS contact_id
            FROM    contact_info
            WHERE   contact_email_address="$email"
        );
print STDERR "$q";
my $sth = $app->{db}->prepare($q);
$sth->execute();

my $contactID = 0;
while (my $hr = $sth->fetchrow_hashref()) {
    #
    $contactID = $hr->{contact_id};
}

# create a JSON string according to the database result

my $json;
my $res;
# create a JSON string according to the database result

if ( $contactID != 0 ) {
    $json = {"error" => " This email address is already registered ! "};
} else {
    $q = qq(CALL addContact(?, ?, ?, ?,'ADD', \@status));
    my $sth = $app->{db}->prepare($q);
    # $sth->execute( $firstname, $lastname, $email, $address, $encryptfile);
    

    
    $json = {"success" => "Registration has been completed", "contactid" => "$contactID"};

}

# return JSON string
#print $cgi->header(-type => "application/json", -charset => "utf-8");

$json = JSON::XS::encode_json($json);
print "Content-Type: application/json\n\n";
print $json;
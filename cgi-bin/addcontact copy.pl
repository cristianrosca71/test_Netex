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

#use CGI::Carp::DebugScreen::Dumper;
 
# if you want to poke into further
#CGI::Carp::DebugScreen::Dumper->ignore_overload(1);
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
my $upload_dir = "C:/xampp/htdocs/contacts_address_book/photos";

$uploadfile =~s/C:\\fakepath\\/D:\\Projects\\Perl_Projects\\Project_contacts\\photos\\/;
my $filename = $uploadfile;

$CGI::POST_MAX = 1024 * 5000;
my $safe_filename_characters = "a-zA-Z0-9_.-";


my $query = new CGI;
#my $filename = $query->param("photo");
#my $email_address = $query->param("email_address");

if ( !$filename )
{
print $query->header ( );
print "There was a problem uploading your photo (try a smaller file).";
exit;
}

my ( $name, $path, $extension ) = fileparse ( $filename, '..*' );
$filename = $name . $extension;
$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ )
{
$filename = $1;
}
else
{
die "Filename contains invalid characters";
}

my $upload_filehandle = $query->upload("$filename");

open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE;
}

close UPLOADFILE;





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
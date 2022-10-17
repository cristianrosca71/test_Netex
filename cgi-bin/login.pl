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

#use CGI::Carp::DebugScreen::Dumper;
 
# if you want to poke into further
#CGI::Carp::DebugScreen::Dumper->ignore_overload(1);
my %App;
my $app = \%App;

# read the CGI params
my $cgi = CGI->new;

use MySQL_Connection;
use Contacts;

my $username = $cgi->param("username");
my $password = $cgi->param("password");


# Connection_DB($app);
$app    = new MySQL_Connection($app);
my $q;

$q = qq(
            SELECT  ui.user_id AS 'user_id'
            FROM    user_info ui LEFT JOIN user_passw up ON ( ui.user_email_address = up.user_login )
            WHERE   up.user_login=? and up.user_passw=?
        );
my $sth = $app->{db}->prepare($q);
$sth->execute( $username, $password );

my $userID;
while (my $hr = $sth->fetchrow_hashref()) {
    #
    $userID = $hr->{user_id};
}

# create a JSON string according to the database result
my $json;
 if ( $userID == 0 ) {
    $json = {"error" => "username or password is wrong"};
 } else {
    $json = {"success" => "Login successful", "userid" => "$userID"};
 }

# return JSON string
#print $cgi->header(-type => "application/json", -charset => "utf-8");

$json = JSON::XS::encode_json($json);
print "Content-Type: application/json\n\n";
print $json;
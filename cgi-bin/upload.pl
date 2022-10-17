#!C:\xampp\perl\bin\perl.exe

use strict;
use warnings;
use v5.10; # for say() function
use lib 'C:/xampp/htdocs/contacts_address_book/lib';
use Lib;
use File::Basename;

use CGI;

$CGI::POST_MAX = 1024 * 5000;
my $safe_filename_characters = "a-zA-Z0-9_.-";

 my $upload_dir = "c:/xampp/htdocs/contacts_address_book/upload";

 my $query = new CGI;

 my $filename = $query->param("photo");
 my $email_address = $query->param("email_address");
 
 
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

my $upload_filehandle = $query->upload('D:\Projects\Perl_Projects\Project_contacts\photos\e1d649f6-f05e-48ac-80c5-817f048a5711.jpg');

open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE;
}

close UPLOADFILE;
  print $query->header ( );
  print qq(

  <HTML>
  <HEAD>
  <TITLE>Thanks!</TITLE>
  </HEAD>

  <BODY>

  <P>Thanks for uploading your photo!</P>
  <P>Your email address: $email_address</P>
  <P>Your photo:</P>
  <img src="/upload/$filename" border="0">

  </BODY>
  </HTML>);


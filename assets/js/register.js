$(document).ready(function(){
    $("form#register").submit(function() {//register is submitted
      var firstname       = $('#firstname').attr('value');//get firstname
      var lastname        = $('#lastname').attr('value');//get lastname
      var email           = $('#email').attr('value');//get email
      var password        = $('#addpassword').attr('value');//get password
      var confirmpassword = $('#confirmpassword').attr('value');//get confirmpassword
  
      if (firstname && lastname && email && password && confirmpassword) {//values are not empty
        $.ajax({
          type: "GET",
          url: "/cgi-bin/register.pl",//URL of the Perl script
          contentType: "application/json; charset=utf-8",
          dataType: "json",
         //send parameters to the Perl script
          data: "firstname=" + firstname + "&lastname=" + lastname + "&email=" + email + "&password=" + password + "&confirmpassword=" + confirmpassword,
         //script call was *not* successful
          error: function(XMLHttpRequest, textStatus, errorThrown) { 
            $('div#loginResult').text("responseText: " + XMLHttpRequest.responseText 
              + ", textStatus: " + textStatus 
              + ", errorThrown: " + errorThrown);
            $('div#loginResult').addClass("error");
          },//error 
         //script call was successful 
         //data contains the JSON values returned by the Perl script
          success: function(data){
            if (data.error) {//script returned error
              $('div#loginResult').text(data.error);
              $('div#loginResult').addClass("error");
            }//if
            else {//login was successful
              $('div#login-form').hide();
              $('div#loginResult').text(data.success 
                + ", data.userid: " + data.userid);
              $('div#loginResult').addClass("success");
            }//else
          }//success
        });//ajax
      }//if
      else {
        $('div#loginResult').text("1 enter all values");
        $('div#loginResult').addClass("error");
      }//else
      $('div#loginResult').fadeIn();
      return false;
    });
  });
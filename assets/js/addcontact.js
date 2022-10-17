$(document).ready(function(){
    $("form#addcontact").submit(function() {//register is submitted
      var firstname       = $('#first').attr('value');//get firstname
      var lastname        = $('#last').attr('value');//get lastname
      var email           = $('#emailc').attr('value');//get email
      var address         = $('#address').attr('value');//get address
      var uploadfile      = $('#uploadfile').attr('value');//get uploadfile
  
      if (firstname && lastname && email && address && uploadfile) {//values are not empty
        $.ajax({
          type: "GET",
          url: "/cgi-bin/addcontact.pl",//URL of the Perl script
          contentType: "application/json; charset=utf-8",
          dataType: "json",
         //send parameters to the Perl script
          data: "firstname=" + firstname + "&lastname=" + lastname + "&email=" + email + "&address=" + address + "&uploadfile=" + uploadfile,
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
            else {//Add contact was successful
              $('div#login-form').hide();
              $('div#loginResult').text(data.success 
                + ", data.userid: " + data.userid);
              $('div#loginResult').addClass("success");
            }//else
          }//success
        });//ajax
      }//if
      else {
        $('div#loginResult').text("2 enter all values");
        $('div#loginResult').addClass("error");
      }//else
      $('div#loginResult').fadeIn();
      return false;
    });
  });
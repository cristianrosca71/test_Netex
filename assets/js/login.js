$(document).ready(function(){
    $("form#login").submit(function() {//loginForm is submitted
      var username = $('#username').attr('value');//get username
      var password = $('#password').attr('value');//get password
  
      if (username && password) {//values are not empty
        $.ajax({
          type: "GET",
          url: "/cgi-bin/login.pl",//URL of the Perl script
          contentType: "application/json; charset=utf-8",
          dataType: "json",
         //send username and password as parameters to the Perl script
          data: "username=" + username + "&password=" + password,
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
              $('div#loginResult').text( data.error);
              $('div#loginResult').addClass("error");
            }//if
            else {//login was successful
              $('div#login-form').hide();
              const d = new Date();
              d.setTime(d.getTime() + (24*60*60*1000));
              let expires = "expires="+ d.toUTCString();
              document.cookie = 'login' + "=" + data.userid + ";" + expires + ";path=/";
              $('div#loginResult').text( data.success 
                + ", data.userid: " + data.userid);
              $('div#loginResult').addClass("success");
            }//else
          }//success
        });//ajax
      }//if
      else {
        $('div#loginResult').text("enter username and password");
        $('div#loginResult').addClass("error");
      }//else
      $('div#loginResult').fadeIn();
      return false;
    });
  });
  
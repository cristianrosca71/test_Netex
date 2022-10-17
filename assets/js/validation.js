
function Validate() {
    var password = document.getElementById("addpassword").value;
    var confirmPassword = document.getElementById("confirmpassword").value;
    if (password != confirmPassword) {
        $('div#pass-err').text("Passwords do not match.");
        document.getElementById("pass-err").style.display = "block";
        return false;
    }
    return true;
}

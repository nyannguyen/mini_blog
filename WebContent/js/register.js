function validateForm(){
	var username = $("#username").val();
	var firstname = $("#firstname").val();
	var lastname = $("#lastname").val();
	var email = $("#email").val();
	var password = $("#password").val();
	var repassword = $("#repassword").val();

	var email_pattern = /^\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b$/i
	var username_pattern = /^[a-zA-Z0-9- ]*$/

	var result = true;
	
	if(username == "" || firstname == "" || lastname == "" || email == "" || password == "" || repassword == ""){
		toastr.error('Please fill all fields!');
		result = false;
	} else {
		if(password == repassword){
			if((password.length)<8) {
				toastr.error('Password should at least 8 character in length!');
				result = false;
			}
		} else {
				toastr.error("Your passwords don't match!");
				result = false;
		}
		if(!email_pattern.test(email)){
			toastr.error('Not a valid email address!');
			result = false;
		}
		if(!username_pattern.test(username)){
			toastr.error('Your username contains illegal characters!');
			result = false;
		}
	}

	return result;
}

$("#btnRegister").click(function(){
	if(validateForm()){
		toastr.success("Please waiting...");
		window.setTimeout(function(){
			$("form").submit();
		},1000);
	}	
});

$(document).ready(function() {
	var succMsg = $("#succMsg").val();
	var errMsg = $("#errMsg").val();

	if(succMsg){
	}
	if(errMsg){
		switch(errMsg){
			case "usernameExist":
				toastr.error("Username has been existed!");
				break;
			case "emailExist":
				toastr.error("Email has been existed!");
				break;
			default:
				toastr.error(errMsg);
				break;
		}
	}
});
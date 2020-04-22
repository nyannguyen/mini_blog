function validateInfoForm(){
	var firstname = $("#firstname").val();
	var lastname = $("#lastname").val();

	var result = true;
	
	if(firstname == "" || lastname == ""){
		toastr.error('Please fill all fields!');
		result = false;
	} 
	return result;
}

function validatePasswordForm(){
	var password = $("#password").val();
	var repassword = $("#repassword").val();

	var result = true;
	
	if(password == "" || repassword == ""){
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
	}

	return result;
}

$("#infoUpdate").click(function(){
	if(validateInfoForm()){
		toastr.success("Please waiting...");
		window.setTimeout(function(){
			$("#infoForm").submit();
		},1000);
	}	
});

$("#passwordUpdate").click(function(){
	if(validatePasswordForm()){
		toastr.success("Please waiting...");
		window.setTimeout(function(){
			$("#passwordForm").submit();
		},1000);
	}	
});

$(document).ready(function() {
	// var succMsg = $("#succMsg").val();
	// var errMsg = $("#errMsg").val();

	// if(succMsg){
	// }
	// if(errMsg){
	// 	switch(errMsg){
	// 		case "usernameExist":
	// 			toastr.error("Username has been existed!");
	// 			break;
	// 		case "emailExist":
	// 			toastr.error("Email has been existed!");
	// 			break;
	// 		default:
	// 			toastr.error(errMsg);
	// 			break;
	// 	}
	// }
});
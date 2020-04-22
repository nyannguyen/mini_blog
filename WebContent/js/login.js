function validateForm(){
	var username = $("#username").val();
	var password = $("#password").val();

	var username_pattern = /^[a-zA-Z0-9- ]*$/

	var result = true;
	
	if(username == "" || password == ""){
		toastr.error('Please fill all fields!');
		result = false;
	} else {
		if(!username_pattern.test(username)){
			toastr.error('Your username contains illegal characters!');
			result = false;
		}
	}

	return result;
}

$("#btnLogin").click(function(){
	if(validateForm()){
		$("form").submit();
	}	
});
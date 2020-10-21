function check_ok(){
	if(!document.login_frm.user_id.value){
		alert("아이디를 입력해주세요.")
		login_frm.user_id.focus();
		return;
	}

	
	if(!document.login_frm.user_pwd.value){
		alert("비밀번호를 입력해주세요.")
		login_frm.user_pwd.focus();
		return;
	}
	
	document.login_frm.submit();
}
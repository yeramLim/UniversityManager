function update_check_ok(){
	
	if(document.stu_frm.stu_pwd.value.length==0){
		alert("변경할 패스워드를 입력해주세요.");
		stu_frm.stu_pwd.focus();
		return;
	}
	if(document.stu_frm.stu_pwd.value != document.stu_frm.pwd_check.value){
		alert("비밀번호가 일치하지 않습니다.");
		stu_frm.stu_pwd.focus();
		return;
	}
	
//	if(doucument.stu_frm.detailAddr.value.length==0 || doucument.stu_frm.detailAddr.value =="상세주소"){
//		alert("상세주소를 입력해주세요.");
//		stu_frm.detailAddr.focus();
//		return;
//	}
	/*====================연락처, 이메일, 주소도 수정====================*/
	
	document.stu_frm.submit();
	
}
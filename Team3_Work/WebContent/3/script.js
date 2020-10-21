/*게시판 글쓰기 빈곳 있는지 체크*/
/*추후 추가할 때 회원가입 후 글작성 가능하다고 알림 표시*/
function check_ok(){
	if(document.form.comm_title.value.length == 0){
		alert("제목을 입력하세요");
		form.comm_title.focus();
		return;
		/*return false;*/
	}
	if(document.form.comm_content.value.length == 0){
		alert("내용을 입력하세요");
		form.b_content.focus();
		return;
		/*return false;*/
	}
	document.form.submit();
}



/*게시판 검색 시 공백 체크*/
function search_ok(){
	if(document.search_frm.search.value.length == 0){
		alert("검색어를 입력하세요");
		return;
	}
	document.search_frm.submit();
}

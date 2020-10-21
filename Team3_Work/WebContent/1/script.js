// 탭 메뉴 이동
$(document).ready(function() {
	$('ul.tabs li').click(function() {
		var tab_id = $(this).attr('data-tab');
		$('ul.tabs li').removeClass('current');
		$(this).addClass('current');
	})
})


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

function delete_ok(){
	if(document.form.stu_pwd.value.length == 0){
		alert("비밀번호를 입력하세요");
		return;
	}
	document.form.submit();
	
}

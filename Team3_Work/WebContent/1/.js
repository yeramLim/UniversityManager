function execPostCode() { //stu_info_Update에서 우편번호 검색 onClick
	daum.postcode.load(function() {
		new daum.Postcode({
			oncomplete : function(data) {//팝업에서 검색결과 항목 클릭시 실행부분
				var addr = ''; //주소 변수

				if (data.userSelectedType === 'R') { //사용자가 도로명 주소 클릭시
					addr = data.roadAddress;
				} else { //지번 주소 선택했을 경우
					addr = data.jibunAddress;

				}
				
				//stu_info_Update에서 id로 받아서 넣기
				document.getElementById('stu_addr').value = addr;
				 
				document.getElementById('stu_addr').focus();
				//상세주소 필드로  커서 옮김
			}
		}).open();
	})
}

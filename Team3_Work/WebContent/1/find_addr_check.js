//stu_Info_Update 우편검색 onClick
function execPostCode() {
   daum.postcode.load(function() {
      new daum.Postcode({
    	//팝업에서 검색결과 항목 클릭시 실행 코드
         oncomplete : function(data) { 
        	//주소 변수
            var addr = ''; 
            
            //사용자가 도로명 주소 선택시 R(rode)
            if (data.userSelectedType === 'R') { 
               addr = data.roadAddress;
            //사용자가 지번 주소 선택시
            } else {   
               addr = data.jibunAddress;

            }

            //stu_Info_Update에서 id로 불러와서 주소 저장
            document.getElementById('stu_addr').value = addr;
            
            // 주소란으로 커서 이동
            document.getElementById('detailAddr').focus();
            
         }
      }).open();
   })
}
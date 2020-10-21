<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/common.css" type="text/css"/>
<link rel="stylesheet" href="css/login.css">
</head>
<body class="find_id_pwd_body" align="center">
<%
	request.setCharacterEncoding("UTF-8");//추가함

	int no = Integer.parseInt(request.getParameter("no"));
	if (no == 1) { // 아이디 찾기
		out.println("<div class='title'><span> 부산 IT전문학교 아이디 찾기 </span></div><br>");
	} else if (no == 2) { // 비밀번호 찾기
		out.println("<div class='title'><span> 부산 IT전문학교 비밀번호 찾기 </span></div><br>");
	}
%>
	<form class="find_id_pwd" name="find_id_pwd" action="find_id_pwd_ok.jsp">
	
<%
	if (no == 1) { // 아이디 찾기
%>		
		
		<label class="first_cd">성 명</label>
			 <input type="text" name="name" placeholder="이름을 입력해주세요" style="width: 250px;" class="txt"/><br><br>
		<label>주민등록번호</label>
			<input type="text" name="jumin" placeholder="주민등록번호를 입력해주세요('-'제외)" class="txt"/><br>
		<input type="hidden" name="no" value="1"/><br>
<%	
	} else if (no == 2) { // 비밀번호 찾기
%>		<label class="first_cd">학 번</label>
			<input type="text" name="id" placeholder="학번을 입력해주세요" style="width: 250px;" class="txt"/>
			<div class="cbrown">※학번을 모를 경우 학부(과) 사무실을 통해 확인할 수 있습니다.※</div>
		
		<label class="jumin">주민등록번호</label>
			<input type="text" name="jumin" placeholder="주민등록번호를 입력해주세요('-'제외)" class="txt jumin"/><br>
		<input type="hidden" name="no" value="2"/><br>
		
<%	
	}
%>		
		<input class="bt bt1" type="button" value="찾기" onclick="document.find_id_pwd.submit()"/>
		<input class="bt" type="button" value="취소" onclick="cancel()"/>
	</form>	
</body>
<script>
	function cancel(){
		window.close();
	}
</script>
</html>
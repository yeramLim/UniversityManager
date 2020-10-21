<!-- 메뉴 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/menu.css" type="text/css" />
<script type="text/javascript" src="../3/script.js" charset="utf-8"></script>

<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 --><script src="../resource/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		$("ul.submenu1 li a.j").hover(function() {
			$(this).parent().parent().parent().children(".t").css('color', '#fff');
		}, function() {
			$(this).parent().parent().parent().children(".t").css('color', 'black');
		});
	});
</script>
<style>
.active {
	color: #fff;
}
</style>
</head>
<body>

	<div class="header">
		<div class="logout">
			<p class="topbutton">
				<input class="button" type="button" value="메인으로" onclick="location.href='../main/main.jsp'" /> 
				<input class="button" type="button" value="로그아웃" onclick="location.href='../main/logOut.jsp'" />
		</div>

		<img src="../css/logo4.png" alt="logo" class="logoImg">
		<h1 class="test">
			<a href="../main/main.jsp">BIT학사시스템</a>
		</h1>
		<div>
			<img src="../css/west-virginia-university.jpg" width="100%" height="200">
		</div>

		<div class="m_open" onclick="document.getElementById('nav').style.display='block'"></div>
		<div id="nav">
			<div class="m_close" onclick="document.getElementById('nav').style.display='none'"></div>

			<ul class="menu">
				<li><a class="t">학생정보</a>
					<ul class="submenu1">
						<li><a class="j" href="../1/stu_Basic_Info.jsp">개인정보</a></li>
						<li><a class="j" href="../1/stu_Class_Info.jsp">수강정보</a></li>
						<li><a class="j" href="../1/stu_Score_Info.jsp">성적확인</a></li>
					</ul></li>
				<li><a class="t">학사정보</a>
					<ul class="submenu1">
						<li><a class="j" href="../2/stu_Notice.jsp">학사공지</a></li>
						<li><a class="j" href="../2/year_Schedule_Rs.jsp">학사일정</a></li>
					</ul></li>
				<li><a href="../3/comm_Freeboard.jsp">자유게시판</a></li>

				<li><a href="../3/comm_Q_And_A.jsp">학사관련문의</a></li>

			</ul>
		</div>
	</div>

</body>
</html>
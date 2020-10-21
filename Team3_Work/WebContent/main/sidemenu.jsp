<%@page import="student.StudentBean"%>
<%@page import="student.StudentDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/sidemenu.css" />
<script src="https://kit.fontawesome.com/9fe63ac50b.js"
	crossorigin="anonymous"></script>
<!--아이콘 사용하기 위한 스크립트-->

<!-- <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 -->
<!--jquery CDN을 이용하는 방법-->
<script>
	$(document).ready(function() {
		$(".navbar ul.sidemenu li a.t").click(function() {
			$(".navbar ul.sidemenu li").removeClass("active");
			$(this).parent().addClass("active");
			// $(this).next("ul").toggleClass("sub_menu");
		});
	});
</script>
	<%
		int id = (Integer)session.getAttribute("uid"); // 세션정보 받아와서 uid에 저장

		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean stu_b = student.getStudent(id); 
	%>

</head>
<body>
	<div class="wrapper">
		<div class="navbar">
			<div class="profile_wrap">
				<div class="profile_pic">
				<img src="../main/read_image.jsp?group=2&id=<%=id%>" alt="profile_pic" style="width: 170px; height: 160px;"/>
				<!-- width="200" height="158"  -->
				</div>
				<div class="profile_info">
					<p class="name">이름 : <%=stu_b.getStu_name()%></p>
					<p class="stunum">학번 : <%=stu_b.getStu_id() %></p>
				</div>
			</div>
				<a href="../main/logOut.jsp" style="color: #fff;"><div class="logout_btn">logout</div></a>
			<!-- ================== profile_wrap END  =============== ===-->
			<ul class="sidemenu">
				<li><a class="t"> <span class="icon"><i
							class="fas fa-address-card"></i></span> <span class="title"> 개인
							정보 관리</span> <span class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a href="../1/stu_Basic_Info.jsp">정보 조회</a></li>
						
					</ul></li>
				<li><a class="t"> <span class="icon"><i
							class="fas fa-shapes"></i></span> <span class="title">성적 정보 관리 </span> <span
						class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a href="../1/stu_Score_Info.jsp">성적 조회</a></li>
					</ul></li>
				<li><a class="t"> <span class="icon"><i
							class="fas fa-book-reader"></i></span> <span class="title"> 수강 정보
							관리</span> <span class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a class="tabLink" href="../1/stu_Class_Info.jsp">강의 시간표</a></li>
						<li><a class="tabLink" href="../1/stu_Class_Info.jsp?num=1">출석 조회</a></li>
						<li><a href="../2/year_Schedule_Rs.jsp">학사 일정</a></li>
					</ul></li>
			</ul>
			<!-- ================== menuEND  =============== ===-->
			
		</div>
		<!-- ================== navBar END  =============== ===-->
		
	</div>
	<!-- ================== wrapper END  =============== ===-->
</body>
</html>
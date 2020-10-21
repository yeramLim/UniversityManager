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
<!--������ ����ϱ� ���� ��ũ��Ʈ-->

<!-- <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
 -->
<!--jquery CDN�� �̿��ϴ� ���-->
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
		int id = (Integer)session.getAttribute("uid"); // �������� �޾ƿͼ� uid�� ����

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
					<p class="name">�̸� : <%=stu_b.getStu_name()%></p>
					<p class="stunum">�й� : <%=stu_b.getStu_id() %></p>
				</div>
			</div>
				<a href="../main/logOut.jsp" style="color: #fff;"><div class="logout_btn">logout</div></a>
			<!-- ================== profile_wrap END  =============== ===-->
			<ul class="sidemenu">
				<li><a class="t"> <span class="icon"><i
							class="fas fa-address-card"></i></span> <span class="title"> ����
							���� ����</span> <span class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a href="../1/stu_Basic_Info.jsp">���� ��ȸ</a></li>
						
					</ul></li>
				<li><a class="t"> <span class="icon"><i
							class="fas fa-shapes"></i></span> <span class="title">���� ���� ���� </span> <span
						class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a href="../1/stu_Score_Info.jsp">���� ��ȸ</a></li>
					</ul></li>
				<li><a class="t"> <span class="icon"><i
							class="fas fa-book-reader"></i></span> <span class="title"> ���� ����
							����</span> <span class="arrow"><i class="fas fa-sort-down"></i></span>
				</a>
					<ul class="sub_menu">
						<li><a class="tabLink" href="../1/stu_Class_Info.jsp">���� �ð�ǥ</a></li>
						<li><a class="tabLink" href="../1/stu_Class_Info.jsp?num=1">�⼮ ��ȸ</a></li>
						<li><a href="../2/year_Schedule_Rs.jsp">�л� ����</a></li>
					</ul></li>
			</ul>
			<!-- ================== menuEND  =============== ===-->
			
		</div>
		<!-- ================== navBar END  =============== ===-->
		
	</div>
	<!-- ================== wrapper END  =============== ===-->
</body>
</html>
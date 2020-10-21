<!-- 학생정보 -->
<%-- <%@page import="com.sun.javafx.scene.web.Printable"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="student.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>학생정보</title>
<style>
.blank {
	height: 50px;
	
}
section {
	height: 80vh;
	display: block;
}
</style>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="script.js"></script>
</head>

<body>
	
	<%
		int id = (Integer)session.getAttribute("uid"); // 세션정보 받아와서 uid에 저장

		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean stu_b = student.getStudent(id); 
	%>

	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
<section>	
	<div id="contents">
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">학적 정보</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">


						<tr>
							<td rowspan="5" width="150">
								<img src="../main/read_image.jsp?group=2&id=<%=id%>" width="150" height="158"/>
							</td>
							<td align="center" class="menu">성명</td>
							<td><%=stu_b.getStu_name()%></td>
							<td align="center" class="menu">영문 성명</td>
							<td><%=stu_b.getStu_eng_name()%></td>
						</tr>
							
						<tr>
							<td align="center" class="menu">생년월일</td>
							<td colspan="3"><%=stu_b.getStu_jumin().substring(0, 2)%>년
											<%=stu_b.getStu_jumin().substring(2, 4)%>월
											<%=stu_b.getStu_jumin().substring(4, 6)%>일
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">학번</td>
							<td>
								<%=stu_b.getStu_id()%>
							</td>
							<td align="center" class="menu">학적구분</td>
							<td>
								<%
									int state = stu_b.getStu_state();
								
									if(state == 1){
										out.print("재학");
									}else if(state == 2){
										out.print("졸업");
									}else if(state == 3){
										out.print("휴학");
									}else{
										out.print("자퇴");
									}
								
								%> 
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">소속학부</td>
							<td>
								<%=stu_b.getDept_name() %>
							</td>
							<td align="center" class="menu">소속학과</td>
							<td>
								<%=stu_b.getDept_majorname() %>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">학년</td>
							<td>
								<%=stu_b.getStu_grade() %>
							</td>
							<td align="center" class="menu">지도교수</td>
							<td>
								<%=stu_b.getPro_name()%>
							</td>
						</tr>
					</table>
				</div>
<!-- 			</div>
		</div> -->

		<div class="blank"></div>

		<!-- 수정가능 항목들 -->
		<!-- <div class="container"> -->

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">기본 정보</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<tr>
							<td align="center" class="menu">연락처</td>
							<td><%=stu_b.getStu_tel().substring(0, 3)%>-
								<%=stu_b.getStu_tel().substring(3, 7)%>-
								<%=stu_b.getStu_tel().substring(7, 11)%>
							</td>
							
							<td align="center" class="menu">비상연락망</td>
							<td><%=stu_b.getStu_emg_tel().substring(0, 3)%>-
								<%=stu_b.getStu_emg_tel().substring(3, 7)%>-
								<%=stu_b.getStu_emg_tel().substring(7, 11)%>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">주소</td>
							<td colspan="3">
								<%=stu_b.getStu_addr()%>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">메일주소</td>
							<td colspan="3">
								<%=stu_b.getStu_email() %>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
				<div class="mbutton">
					<input type="button" class="button" value="정보수정"
						onclick="location.href='stu_Update_Info.jsp'" />
			</div>
		</div>
	</div>
</section>
	<!-- </section> -->
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
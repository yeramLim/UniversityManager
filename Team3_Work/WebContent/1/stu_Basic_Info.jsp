<!-- �л����� -->
<%-- <%@page import="com.sun.javafx.scene.web.Printable"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="student.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�л�����</title>
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
		int id = (Integer)session.getAttribute("uid"); // �������� �޾ƿͼ� uid�� ����

		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean stu_b = student.getStudent(id); 
	%>

	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
<section>	
	<div id="contents">
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">���� ����</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">


						<tr>
							<td rowspan="5" width="150">
								<img src="../main/read_image.jsp?group=2&id=<%=id%>" width="150" height="158"/>
							</td>
							<td align="center" class="menu">����</td>
							<td><%=stu_b.getStu_name()%></td>
							<td align="center" class="menu">���� ����</td>
							<td><%=stu_b.getStu_eng_name()%></td>
						</tr>
							
						<tr>
							<td align="center" class="menu">�������</td>
							<td colspan="3"><%=stu_b.getStu_jumin().substring(0, 2)%>��
											<%=stu_b.getStu_jumin().substring(2, 4)%>��
											<%=stu_b.getStu_jumin().substring(4, 6)%>��
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">�й�</td>
							<td>
								<%=stu_b.getStu_id()%>
							</td>
							<td align="center" class="menu">��������</td>
							<td>
								<%
									int state = stu_b.getStu_state();
								
									if(state == 1){
										out.print("����");
									}else if(state == 2){
										out.print("����");
									}else if(state == 3){
										out.print("����");
									}else{
										out.print("����");
									}
								
								%> 
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">�Ҽ��к�</td>
							<td>
								<%=stu_b.getDept_name() %>
							</td>
							<td align="center" class="menu">�Ҽ��а�</td>
							<td>
								<%=stu_b.getDept_majorname() %>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">�г�</td>
							<td>
								<%=stu_b.getStu_grade() %>
							</td>
							<td align="center" class="menu">��������</td>
							<td>
								<%=stu_b.getPro_name()%>
							</td>
						</tr>
					</table>
				</div>
<!-- 			</div>
		</div> -->

		<div class="blank"></div>

		<!-- �������� �׸�� -->
		<!-- <div class="container"> -->

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">�⺻ ����</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<tr>
							<td align="center" class="menu">����ó</td>
							<td><%=stu_b.getStu_tel().substring(0, 3)%>-
								<%=stu_b.getStu_tel().substring(3, 7)%>-
								<%=stu_b.getStu_tel().substring(7, 11)%>
							</td>
							
							<td align="center" class="menu">��󿬶���</td>
							<td><%=stu_b.getStu_emg_tel().substring(0, 3)%>-
								<%=stu_b.getStu_emg_tel().substring(3, 7)%>-
								<%=stu_b.getStu_emg_tel().substring(7, 11)%>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">�ּ�</td>
							<td colspan="3">
								<%=stu_b.getStu_addr()%>
							</td>
						</tr>

						<tr>
							<td align="center" class="menu">�����ּ�</td>
							<td colspan="3">
								<%=stu_b.getStu_email() %>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
				<div class="mbutton">
					<input type="button" class="button" value="��������"
						onclick="location.href='stu_Update_Info.jsp'" />
			</div>
		</div>
	</div>
</section>
	<!-- </section> -->
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
<!-- �⺻���� ���� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="student.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�⺻ ���� ����</title>
<style>
.blank {
	height: 50px;
}
</style>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="stu_update_check.js" charset="utf-8"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script> <!-- ����˻� api -->
<script src="find_addr_check.js"></script> <!-- ���� �˻��� js���Ϸ� �̵� -->
</head>
<body>
	<%
		int id = (Integer) session.getAttribute("uid");
	StudentDBBean student = new StudentDBBean();
	StudentBean stu_b = student.getStudent(id);
	
	%>


	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>

	<div id="contents">
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">���� ����</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<!-- ���� ���ε带 ���� enctype��  -->
						<form method="post" action="stu_Update_Ok.jsp" name="stu_frm" enctype="multipart/form-data">
							<tr>
								<td rowspan="5">
								<!--  src: �⺻ ����� �̹��� �ҷ�����-->
								  <img id="preimg" src="../main/read_image.jsp?group=2&id=<%=id%>" width="150"  height="158"/> 
								</td>			
								<td align="center" class="menu">����</td>
								<td><%=stu_b.getStu_name()%></td>
								<td align="center" class="menu">���� ����</td>
								<td><%=stu_b.getStu_eng_name()%></td>
							</tr>

							<tr>
								<td align="center" class="menu">�������</td>
								<td colspan="3">
								<!--�ֹε�Ϲ�ȣ�� �̿��� ����� �����ϱ� ���ؼ� substring ���  -->
									<%=stu_b.getStu_jumin().substring(0, 2)%>��
									<%=stu_b.getStu_jumin().substring(2, 4)%>�� 
									<%=stu_b.getStu_jumin().substring(4, 6)%>��
								</td>
							</tr>

							<tr>
								<td align="center" class="menu">�й�</td>
								<td><%=stu_b.getStu_id()%></td>
								<td align="center" class="menu">��������</td>
								<td>
									<%
										int state = stu_b.getStu_state();

									if (state == 1) {
										out.print("����");
									} else if (state == 2) {
										out.print("����");
									} else if (state == 3) {
										out.print("����");
									} else {
										out.print("����");
									}
									%>
								</td>
							</tr>

							<tr>
								<td align="center" class="menu">�Ҽ��к�</td>
								<td>����</td>
								<td align="center" class="menu">�Ҽ��а�</td>
								<td><%=stu_b.getStu_major()%></td>
							</tr>

							<tr>
								<td align="center" class="menu">�г�</td>
								<td><%=stu_b.getStu_grade()%></td>
								<td align="center" class="menu">��������</td>
								<td>
									<%=stu_b.getPro_name()%>
								</td>
							</tr>

							<tr>
													
									<td align="center" class="menu">���� ����</td>
									<td colspan="4">
										<!-- onchange�� �Ἥ js�� �̿��� ���ε��� ���� �̸���������-->
										<input type="file" name="stu_img" onchange="readURL(this);">
									</td>
							</tr>
					</table>
				</div>
		<div class="blank"></div>

			<!-- ���� ������ �׸�� -->
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">�⺻ ����</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<tr>
							<!--name�� update_ok�� ������ studentBean�� set���� �� ����, DBBean���� get���� ��й�ȣ�޾Ƽ� set���� db�� ����  -->
							<td align="center" class="menu">���� ��й�ȣ</td>
							<td><input type="password" size="15" name="stu_pwd"></td>
							<td align="center" class="menu">���� ��й�ȣ Ȯ��</td>
							<td><input type="password" size="15" name="pwd_check"></td>
						</tr>
						<tr>
							<td align="center" class="menu">����ó</td>
							<td><input type="text" size="3" name="stu_tel"
								value="<%=stu_b.getStu_tel().substring(0, 3)%>">-
								
								 <input type="text" size="4" name="num2"
								value="<%=stu_b.getStu_tel().substring(3, 7)%>">- 
								
								<input type="text" size="4" name="num3"
								value="<%=stu_b.getStu_tel().substring(7, 11)%>">
							</td>
								
							<td align="center" class="menu">��󿬶���</td>
							<td><%=stu_b.getStu_emg_tel().substring(0, 3)%>- <%=stu_b.getStu_emg_tel().substring(3, 7)%>-
								<%=stu_b.getStu_emg_tel().substring(7, 11)%></td>
						</tr>
					
						<tr>
							<td align="center" class="menu">�ּ�</td>
							<td colspan="3">
								<input type="text" size="50" id="stu_addr" name="stu_addr" value="<%=stu_b.getStu_addr()%>">
							 	<input type="button" value="�����ȣ  �˻�" onClick="execPostCode()">
							 	<input type="text" name="detailAddr" id="detailAddr" placeholder="���ּ�" value="">
							</td>							
						</tr>

						<tr>
							<td align="center" class="menu">E-mail</td>
							<td colspan="3" align="center">
								<%
									// index�� @�� ��ġ���� 
									int idx = stu_b.getStu_email().indexOf("@");
									String selected = stu_b.getStu_email().substring(idx+1);
								%> 
								<input type="text" size="20" name="stu_email" value="<%=stu_b.getStu_email().substring(0, idx)%>"> @
								 <!--get���� email�� �����ͼ� ù��° ���ں��� @��ġ-1���� �ش� ������ ����-->
								<select name="mail2" id="mail2">
									<option selected><%=selected%></option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.com">daum.com</option>
									<option value="nate.com">nate.com</option>
							</select>
							</td>
						</tr>
						</form>
					</table>
				</div>
			</div>
			
				<div class="mbutton">
					<input type="button" class="button" value="�����ϱ�" onClick="update_check_ok()"> &nbsp;&nbsp;
						<input type="button" class="button" value="�������" onclick="javascript:history.back(-1)">
						
				</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//������ onChange ���� ��
	function readURL(img) {
//img�� ������ ������ �о�� img.files[0]�� ������ �������� �� ù��° ������ �о��
	if (img.files && img.files[0]) {
	var reader = new FileReader();
	reader.onload = function (e) {
//�⺻������ #preimg�� src�� �������
	$('#preimg').attr('src', e.target.result);
	}
	reader.readAsDataURL(img.files[0]);
	}
	}
</script>
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
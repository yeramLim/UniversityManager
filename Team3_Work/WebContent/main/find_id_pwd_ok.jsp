<%@page import="myUtil.HanConv"%>
<%@page import="student.StudentDBBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body class="find_id_pwd_body">
<%

	request.setCharacterEncoding("euc-kr");
	StudentDBBean dbconn = new StudentDBBean();
	int no = Integer.parseInt(request.getParameter("no"));
	String jumin = request.getParameter("jumin");
	String temp = null;
	String sql = null;
	if(no == 1) { // ���̵� ã��
		/* temp = new String(request.getParameter("name").getBytes("I0SO-8859-1"), "UTF-8");  */
		temp = HanConv.toKor(request.getParameter("name"));
		sql = "SELECT STU_ID FROM STUDENT WHERE STU_NAME='"+temp+"' AND STU_JUMIN='"+jumin+"'";
	}else if(no == 2){ // ��й�ȣ ã��
		temp = request.getParameter("id");
		sql = "SELECT * FROM STUDENT WHERE STU_ID='"+temp+"' AND STU_JUMIN='"+jumin+"'";
	}
	
	PreparedStatement pstmt = dbconn.getConnection().prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		if(no == 1){
%>
		<div style="text-align: center">
			<p class="find_id_pwd_ok_p">ã���ô� ���̵�� <br><b><%=rs.getString(1) %></b>�Դϴ�</p>
			<input type='button' value='Ȯ��' id='find_id_pwd_ok_btn' onclick='window.close()'>
		</div>
<%
		}else if(no == 2){		
%>
		<div style="text-align: center">
		<form class="find_id_pwd" style="margin-top:30px;" name='updatepwd' action='update_pwd.jsp'>
			<input type="password" id="pwd1" placeholder="���ο� ��й�ȣ�� �Է�" onfocusin="getFocus()" onfocusout="loseFocus()" name="pwd">
			</br><br>
			<input type="password" id="pwd2" placeholder="��й�ȣ Ȯ��" onfocusin="getFocus()" onfocusout="loseFocus()" >
			<p id="pwd_txt"></p>
			<input type="button" value="Ȯ��" onclick="update()">
			<input type="hidden" value="<%=temp %>" name="id">
		</form>
		</div>
		
		<script>
		var bol_pw = false;
		function getFocus() { // pwd ���� ��Ŀ�� ����� ��
			var txt = document.getElementById("pwd_txt");
			txt.innerHTML = "";
		}

		function loseFocus() { // pwd ���� ��Ŀ���� �Ҿ��� ��
			var txt = document.getElementById("pwd_txt");
			var pwd1 = document.getElementById("pwd1").value;
			var pwd2 = document.getElementById("pwd2").value;
			
			if (pwd1 == pwd2) {
				if(pwd1.length != 0 && pwd2.length != 0){
					txt.style.color = "blue";
					txt.innerHTML = "��й�ȣ�� ��ġ�մϴ�";
					bol_pw = true;
				}
			} else {
				txt.style.color = "red";
				txt.innerHTML = "��й�ȣ�� ��ġ���� �ʽ��ϴ�";
				bol_pw = false;
			}
		}
		
		function update(){
			if(!bol_pw){
				alert('��й�ȣ�� �ٽ� �Է����ּ���');
				return;
			}else{
				document.updatepwd.submit();
			}
		}
		</script>
<%
		}
	}else{
		out.println("<script>");
		out.println("alert('�������� �ʴ� ȸ���Դϴ�.')");
		out.println("history.back();");
		out.println("</script>");
	}
%>
</body>
</html>
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
	request.setCharacterEncoding("UTF-8");//�߰���

	int no = Integer.parseInt(request.getParameter("no"));
	if (no == 1) { // ���̵� ã��
		out.println("<div class='title'><span> �λ� IT�����б� ���̵� ã�� </span></div><br>");
	} else if (no == 2) { // ��й�ȣ ã��
		out.println("<div class='title'><span> �λ� IT�����б� ��й�ȣ ã�� </span></div><br>");
	}
%>
	<form class="find_id_pwd" name="find_id_pwd" action="find_id_pwd_ok.jsp">
	
<%
	if (no == 1) { // ���̵� ã��
%>		
		
		<label class="first_cd">�� ��</label>
			 <input type="text" name="name" placeholder="�̸��� �Է����ּ���" style="width: 250px;" class="txt"/><br><br>
		<label>�ֹε�Ϲ�ȣ</label>
			<input type="text" name="jumin" placeholder="�ֹε�Ϲ�ȣ�� �Է����ּ���('-'����)" class="txt"/><br>
		<input type="hidden" name="no" value="1"/><br>
<%	
	} else if (no == 2) { // ��й�ȣ ã��
%>		<label class="first_cd">�� ��</label>
			<input type="text" name="id" placeholder="�й��� �Է����ּ���" style="width: 250px;" class="txt"/>
			<div class="cbrown">���й��� �� ��� �к�(��) �繫���� ���� Ȯ���� �� �ֽ��ϴ�.��</div>
		
		<label class="jumin">�ֹε�Ϲ�ȣ</label>
			<input type="text" name="jumin" placeholder="�ֹε�Ϲ�ȣ�� �Է����ּ���('-'����)" class="txt jumin"/><br>
		<input type="hidden" name="no" value="2"/><br>
		
<%	
	}
%>		
		<input class="bt bt1" type="button" value="ã��" onclick="document.find_id_pwd.submit()"/>
		<input class="bt" type="button" value="���" onclick="cancel()"/>
	</form>	
</body>
<script>
	function cancel(){
		window.close();
	}
</script>
</html>
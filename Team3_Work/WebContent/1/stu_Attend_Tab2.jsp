<%@page import="java.util.ArrayList"%>
<%@page import="student.StudentDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div align="left">
		<select name="sc_grade">
			<%
			int id = Integer.parseInt(request.getParameter("id"));

			StudentDBBean student = StudentDBBean.getInstance();
			/* �ڽ��� ���� ����� �г⸸ option�� ��Ÿ���� �ϱ� ����  */
			ArrayList<Integer> grade = student.getGrade(id);
			for (int i = 0; i < grade.size(); i++) {
				out.println("<option value='" + grade.get(i) + "'>" + grade.get(i) + "�г�</option>");
			}
			%>
		</select> 
		<select name="sc_semester">
			<option value="1">1�б�</option>
			<option value="2">2�б�</option>
		</select> <input type="button" class="button" value="��ȸ"
			onclick="getClassInfo('<%=id%>')">
	</div>
	
	<div style="float: left; margin: 25px 10px 25px 100px;" id="resultClass">
				<!-- �ڽ��� ����� class_search ����� div�ȿ� ���� -->
	</div>

	<div class="cont2 cont_1" style="float: right; margin: 25px 100px 25px 10px;" id="resultAttend">
			<!-- �ڽ��� ����� �������� ���̺��� �ش� ���� �� Ŭ����  ������ attend_search�� ����� div�ȿ� ���� -->
	</div>
</body>
</html>
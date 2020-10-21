<%@page import="student.StudentDBBean"%>
<%@page import="attend.View2Bean"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table style="width: 500px;">
		<tr>
			<th>이수구분</th>
			<th>교과목명</th>
			<th>학점</th>
			<th>담당교수</th>
		</tr>

		<%
						StudentDBBean student = StudentDBBean.getInstance();
						ArrayList<View2Bean> viewlist = null;
						
						//stu_ClassInfo에서 넘겨준 값들 받아옴
						int stu_id = Integer.parseInt(request.getParameter("id"));
						int stu_grade = Integer.parseInt(request.getParameter("grade"));
						int stu_semester = Integer.parseInt(request.getParameter("semester"));
						
						viewlist = student.classView(stu_id, stu_grade, stu_semester);
						
						for(int i=0; i<viewlist.size(); i++){
							View2Bean view2 = viewlist.get(i);
							
							String subj_state = view2.getSubj_state();
							String subj_name = view2.getSubj_name();
							int subj_hakjum = view2.getSubj_hakjum();
							String pro_name = view2.getPro_name();
							int subj_code = view2.getSc_subj_code();
				%>
		<!--과목의 출결사항 알고 싶을 때 해당 과목의 정보가 나타나 있는 행을 클릭시 출결정보가 뜸-->
		<tr onclick="attend(<%=stu_id%>, <%=subj_code%>)" style="cursor: pointer;"
			onMouseOver="this.style.backgroundColor='#F0F1F3';"
			onMouseOut="this.style.backgroundColor='#FFFFFF';">
			<td><%=subj_state%></td>
			<td><%=subj_name%></td>
			<td><%=subj_hakjum %></td>
			<td><%=pro_name %></td>
		</tr>
		
		<% 
			}
		%>
	</table>
</body>
</html>
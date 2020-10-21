<%@page import="java.sql.Date"%>
<%@page import="student.StudentDBBean"%>
<%@page import="attend.AttendBean"%>
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
	
				<table style="width: 300px;"> 
						<tr>
							<th colspan="1">일자</th>
							<th colspan="2">출결</th>
							<th colspan="6">비고</th>
						</tr>
				<%
						ArrayList<AttendBean> atdList = null;		
						StudentDBBean student = StudentDBBean.getInstance();
						
						int stu_id2 = Integer.parseInt(request.getParameter("id"));
						int stu_grade2 = Integer.parseInt(request.getParameter("grade"));
						int stu_semester2 = Integer.parseInt(request.getParameter("semester"));
						int stu_code2 = Integer.parseInt(request.getParameter("code"));
						
						
						atdList= student.AtdView(stu_id2 , stu_grade2, stu_semester2 ,stu_code2);
						
					
						int a=0, b=0, c=0, d=0;
						for(int i=0; i<atdList.size(); i++){
							AttendBean atd = atdList.get(i);
							
							Date atd_date= atd.getAtd_date();
							String atd_state= atd.getAtd_state();
							String atd_remark= atd.getAtd_remark();
						
							
				%>
							<tr> 
								<td colspan="1"><%=atd_date%></td>
								<td colspan="2"><%=atd_state%></td>
								<td colspan="6"><%=atd_remark %></td>
							</tr>
							
				<% 
							if(atd_state.equals("출석")){
								a += 1;
							}else if(atd_state.equals("지각")){
								b += 1;
							}else if(atd_state.equals("결석")){
								c += 1;
							}else{
								d += 1;
							} 
				
						}
						
				%>
							<tr>
								<th>출석</th>
								<td><%=a%></td>
								<th>지각</th>
								<td><%=b%></td>
								<th>결석</th>
								<td><%=c%></td>
								<th>조퇴</th>
								<td><%=d%></td>
							</tr>
					</table>
</body>
</html>
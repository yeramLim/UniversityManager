<%@page import="javax.swing.JOptionPane"%>
<%@page import="schedule.ScheduleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="student.StudentDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Univ_Scheduel</title>
<link rel="stylesheet" href="../css/schedule.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</head>
<body>
	<%
		StudentDBBean student = StudentDBBean.getInstance();
	ArrayList<ScheduleBean> viewlist = null;

	int year = Integer.parseInt(request.getParameter("year"));
	viewlist = student.ScheduleView(false, year);

	%>
		<input type="hidden" value="<%=year%>" name="test"/>
	<%
	
	for (int i = 0; i < viewlist.size(); i++) {
		ScheduleBean view2 = viewlist.get(i);

		int start_year = view2.getShce_startyear();
		
		//숫자 두자리 수에서 한자리만 차지할 경우 나머지는 0 처리
		String start_month = String.format("%02d",view2.getShce_startmonth());
		String start_day = String.format("%02d",view2.getShce_startday());
		String end_month = String.format("%02d",view2.getShce_endmonth());
		String end_day = String.format("%02d",view2.getShce_endday());
		int holiday = view2.getShce_holiday();
		String content = view2.getSche_content();
		
		
   
		if(start_month.equals(end_month) && start_day.equals(end_day)){
	%>
	
	<%-- <input type="hidden" value="<%=holiday%>" id="test"> --%>
	<tr class="trbody">
		<td id="a" class="pdate<%=holiday %>"><%=start_month%>.<%=start_day %></td>
		<td class="pdate<%=holiday %>"><%=content%></td>
	</tr>
	
	<%
		
		}else{
			%>
		<%-- <input type="hidden" value="<%=holiday%>" id="test"> --%>
		<tr class="trbody">
			<td id="a" class="pdate<%=holiday %>">
				<%=start_month%>.<%=start_day %> ~
				<%=end_month%>.<%=end_day %>
			</td>
			<td class="pdate<%=holiday %>"><%=content%></td>
		</tr>
		<%
		 }
		}
	
	 if(viewlist.size() == 0)
		out.println("<tr><td rowspan='2' style='color:#9f2c00; padding:30px 0;'>※ 입력된 학사일정이 없습니다. ※</td></tr>");
	%>
</body>
</html>

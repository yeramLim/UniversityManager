<%@page import="timetable.TimeTableBean"%>
<%@page import="student.StudentBean"%>
<%@page import="student.StudentDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	int id = Integer.parseInt(request.getParameter("id"));

	StudentDBBean student = StudentDBBean.getInstance();
	ArrayList<TimeTableBean> time = student.timeScheduleView(id);
	if (time != null && time.size() != 0) {
	%>
	<table border="1" cellpadding="8" cellspacing="0">
		<tr>
			<th width="131">교시</th>
			<th width="131">월</th>
			<th width="131">화</th>
			<th width="131">수</th>
			<th width="131">목</th>
			<th width="131">금</th>
		</tr>
		<%
			//1~11교시
			for (int k = 1; k <= 11; k++) {
			out.println("<tr><td height='50'>" + k + "</td>");
			//월~금
			for (int j = 1; j <= 5; j++) {
				out.println("<td style='margin-bottom= 10px;'>");
				for (int i = 0; i < time.size(); i++) {
			if (time.get(i).getSubj_day1().equals("월") && j == 1
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("월") && j == 1
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name() + "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("화") && j == 2
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("화") && j == 2
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("수") && j == 3
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("수") && j == 3
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("목") && j == 4
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("목") && j == 4
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("금") && j == 5
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("금") && j == 5
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			}
				}
				out.println("</td>");
			}
			out.println("</tr>");
		}
		} else if (time != null && time.size() == 0) { // 듣는 수업이 없음
			out.println("<h3>수업 정보가 없습니다.</h3>");
		} else if (time == null) { // 학기 중이 아님
			out.println("<h3>시간표 조회 기간이 아닙니다.</h3>");
		}
		%>
	</table>
</body>
</html>
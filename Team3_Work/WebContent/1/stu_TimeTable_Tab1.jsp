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
			<th width="131">����</th>
			<th width="131">��</th>
			<th width="131">ȭ</th>
			<th width="131">��</th>
			<th width="131">��</th>
			<th width="131">��</th>
		</tr>
		<%
			//1~11����
			for (int k = 1; k <= 11; k++) {
			out.println("<tr><td height='50'>" + k + "</td>");
			//��~��
			for (int j = 1; j <= 5; j++) {
				out.println("<td style='margin-bottom= 10px;'>");
				for (int i = 0; i < time.size(); i++) {
			if (time.get(i).getSubj_day1().equals("��") && j == 1
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("��") && j == 1
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name() + "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("ȭ") && j == 2
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("ȭ") && j == 2
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("��") && j == 3
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("��") && j == 3
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("��") && j == 4
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("��") && j == 4
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			} else if (time.get(i).getSubj_day1().equals("��") && j == 5
					&& (time.get(i).getSubj_stime1() <= k && time.get(i).getSubj_etime1() >= k)
					|| time.get(i).getSubj_day2().equals("��") && j == 5
							&& (time.get(i).getSubj_stime2() <= k && time.get(i).getSubj_etime2() >= k)) {
				out.println(time.get(i).getSubj_name()+ "<br><br>(" + time.get(i).getSubj_room() + ")");
			}
				}
				out.println("</td>");
			}
			out.println("</tr>");
		}
		} else if (time != null && time.size() == 0) { // ��� ������ ����
			out.println("<h3>���� ������ �����ϴ�.</h3>");
		} else if (time == null) { // �б� ���� �ƴ�
			out.println("<h3>�ð�ǥ ��ȸ �Ⱓ�� �ƴմϴ�.</h3>");
		}
		%>
	</table>
</body>
</html>
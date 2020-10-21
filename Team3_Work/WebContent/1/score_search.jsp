<%@page import="student.StudentDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="scoreclass.ScoreClassBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<body>
	<% 
					ArrayList<ScoreClassBean> scorelist =null;
					StudentDBBean student = StudentDBBean.getInstance();
					
					int sc_id = Integer.parseInt(request.getParameter("sc_id"));
					int sc_year = Integer.parseInt(request.getParameter("sc_year"));
					int sc_semester = Integer.parseInt(request.getParameter("sc_semester"));
					
					
					scorelist = student.getScore(sc_id, sc_year, sc_semester);
					double score=0.0,avgScore=0.0,preAvgScore=0.0,ratio=0.0, preRatio=0.0,percent=0.0; 
					int hakjum=0; //��û��������
					int acquiredH = 0; //����������
					
				%>
				
					<tr>
						<th>�̼��⵵</th>
						<th>�г�</th>
						<th>�б�</th>
						<th>����</th>
						<th>����</th>
						<th>����</th>
						<th colspan="2">����</th>
					</tr>
				<%
					for(int i=0; i<scorelist.size(); i++){
						ScoreClassBean sc_b = scorelist.get(i);
						
						int s_year = sc_b.getSc_year();
						int s_grade = sc_b.getSc_grade();
						int s_semester= sc_b.getSc_semester();
						String s_state = sc_b.getSubj_state();
						String s_name = sc_b.getSubj_name();
						int s_hakjum = sc_b.getSubj_hakjum();
						double s_score = sc_b.getSc_score(); //����  ���ڷ� ȯ��(ex.4.5='A����')
						String s_score2 = sc_b.getSc_score2(); 
						
						
						 
				%>
					<tr>
						<td><%=s_year%></td>
						<td><%=s_grade %></td>
						<td><%=s_semester %></td>
						<td><%=s_state %></td>
						<td><%=s_name %></td>
						<td><%=s_hakjum %></td>
						<td colspan="2"><%=s_score2 %></td>
					</tr>
				<%
					
					if(!s_score2.equals("F")){ //F���� �ƴ϶�� ����Ǵ� �̺�Ʈ
						acquiredH += s_hakjum; //������ ������
						score += s_score;
						preAvgScore += (double)(s_hakjum*s_score);
						
				//����� ȯ��ǥ
						if(s_score2.equals("A+")){
							percent=97.5;
						}else if(s_score2.equals("A")){
							percent=92.5;
						}else if(s_score2.equals("B+")){
							percent=87.5;
						}else if(s_score2.equals("B")){
							percent=82.5;
						}else if(s_score2.equals("C+")){
							percent=77.5;
						}else if(s_score2.equals("C")){
							percent=72.5;
						}else if(s_score2.equals("D+")){
							percent=67.5;
						}else{
							percent=62.5;
						}
						
					}
					
					
						hakjum += s_hakjum; //��û���� ������
						avgScore = (double)(preAvgScore/hakjum);
						preRatio += (double)(s_hakjum*percent); //��
						ratio = preRatio/hakjum; //����� ���ϱ�
					 	
				}
				%>
				
					<tr>
						<th>��û����</th>
						<td><%=hakjum %></td>
						<th>�������</th>
						<td><%=acquiredH%></td>
						<th>����</th>
						<td><%=String.format("%.2f", avgScore)%></td>
						<th>�����</th>
						<td><%=String.format("%.2f", ratio)%></td>
					</tr>
				
</body>
</head>
</html>
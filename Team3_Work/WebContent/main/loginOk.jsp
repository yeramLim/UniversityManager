<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="student.*" %>
<%@ page import="professor.*" %>

<%
	request.setCharacterEncoding("euc-kr");

	int id= Integer.parseInt(request.getParameter("user_id"));
	String pwd = request.getParameter("user_pwd");
	String gubun=request.getParameter("class");
	boolean exist = false;
	boolean pass = false;
	//���� ��ư �л��϶�
	
	if(gubun.equals("s")){ // ���� ��ư  = �л�
		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean  stu_b =  student.getStudent(id);
		
		if(stu_b != null){ //�л� �����Ͱ� �����ϴ� ���
			exist = true;
			if(pwd.equals(stu_b.getStu_pwd())){
				session.setAttribute("uid", id);
%>
				<Script>
					alert("�α��� ����!")
				</Script>		
<%				
				response.sendRedirect("main.jsp");
			}else{
				pass=true;
			}
		}
		
	}else{ //������ �α��ν� 
		ProfessorDBBean professor= ProfessorDBBean.getInstance();
		ProfessorBean prof1 = professor.getProfessor(id);
		if(prof1 != null){
			exist = true;
			if(pwd.equals(prof1.getPro_pwd())){
				session.setAttribute("uid", id);
%>
				<Script>
					alert("�α��� ����!")
				</Script>		
<%				
				response.sendRedirect("notice.jsp"); 
			}else{
				pass=true;		
			}
		}
	}
	
	if(!exist){
%>
		<Script>
			alert("�������� �ʴ� ȸ���Դϴ�.")
			history.go(-1);
		</Script>
<%
	}
	
	if(pass){
%>
		<Script>
			alert("��й�ȣ�� ���� �ʽ��ϴ�.")
			history.go(-1);				
		</Script>		
<%
	}
%>
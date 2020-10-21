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
	//라디오 버튼 학생일때
	
	if(gubun.equals("s")){ // 라디오 버튼  = 학생
		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean  stu_b =  student.getStudent(id);
		
		if(stu_b != null){ //학생 데이터가 존재하는 경우
			exist = true;
			if(pwd.equals(stu_b.getStu_pwd())){
				session.setAttribute("uid", id);
%>
				<Script>
					alert("로그인 성공!")
				</Script>		
<%				
				response.sendRedirect("main.jsp");
			}else{
				pass=true;
			}
		}
		
	}else{ //교수가 로그인시 
		ProfessorDBBean professor= ProfessorDBBean.getInstance();
		ProfessorBean prof1 = professor.getProfessor(id);
		if(prof1 != null){
			exist = true;
			if(pwd.equals(prof1.getPro_pwd())){
				session.setAttribute("uid", id);
%>
				<Script>
					alert("로그인 성공!")
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
			alert("존재하지 않는 회원입니다.")
			history.go(-1);
		</Script>
<%
	}
	
	if(pass){
%>
		<Script>
			alert("비밀번호가 맞지 않습니다.")
			history.go(-1);				
		</Script>		
<%
	}
%>
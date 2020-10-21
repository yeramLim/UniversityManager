<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="student.StudentBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>	
<%@page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="student.StudentBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	StudentBean stu_b = new StudentBean();

	Context ctx = new InitialContext();
	DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
	

	Connection con=null;
	PreparedStatement pstmt = null;
	
	String sql="insert into student(stu_img) values(?)";
	
	int size = 1024*1024*10; //���� ������ ���� ũ��
	String file =""; //���ε��� ���� �̸�
	
	try {
		
		//Part file2 = new Part
		Part filePart = request.getPart("stu_img");		
		InputStream fis = filePart.getInputStream();
		String realpath=request.getServletContext().getRealPath("/upload"); //����θ� ���� ������η� �˷���
		
		
		MultipartRequest multi = new MultipartRequest(request,realpath,size,"utf-8",new DefaultFileRenamePolicy());
		 		
 		int b;
		while((b=fis.read()) != -1){
			
		}
		
		con=ds.getConnection();
		
		
		
		pstmt = con.prepareStatement(sql);
		pstmt.setBlob(1, stu_b.getStu_img());
		
		pstmt.executeUpdate();
		
		
		pstmt.close();
		con.close();
		System.out.println("�����߰� ����");
	}catch(Exception e) {
		e.printStackTrace();
		System.out.println("�����߰� ����");
	}
	
%>
</body>
</html>
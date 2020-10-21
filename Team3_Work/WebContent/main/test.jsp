<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="oracle.jdbc.OracleResultSet"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="oracle.sql.BLOB"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
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
   Connection conn = null;
   DataSource ds = null;
   InputStream is = null;
   StringBuffer sb = new StringBuffer();
   
   try {
      Context ctx = new InitialContext();
      ds = ((DataSource) ctx.lookup("java:comp/env/jdbc/oracle"));
      conn = ds.getConnection();
      
      
      PreparedStatement ps = conn.prepareStatement("select stu_img from student where stu_id=20201350");
      ResultSet rs = ps.executeQuery();
       if(rs.next()) {
         Blob image = rs.getBlob(1);
         byte[] imgData = image.getBytes(1, (int)image.length());
         
         response.setContentType("image/png");
         out.clear();
         out = pageContext.pushBody();
         OutputStream o = response.getOutputStream();
         o.write(imgData);
       }
       
      if (conn != null)
         conn.close();
      ps.close();
   } catch (NamingException e) {
      e.printStackTrace();
   } catch (SQLException e) {
      e.printStackTrace();
   }
%>
</body>
</html>
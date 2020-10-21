<%@page import="student.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<link rel="stylesheet" href="../css/menu.css" type="text/css" />
<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../resource/js/bootstrap.min.js"></script>
</head>
<body>
<%
	
	String cmt_writer="", cmt_content="", cmt_date="";
	int cmt_stu_id = 0;
	int cmt_ref = 0, cmt_step = 0, cmt_level = 0, cmt_index = 0, cmt_num = 0;
	
	int cmt_comm_index = Integer.parseInt(request.getParameter("comm_index"));
	cmt_index = Integer.parseInt(request.getParameter("cmt_index"));
	System.out.println("cmt_comm_index >> " + cmt_comm_index);
	System.out.println("cmt_index >> " + cmt_index);
	
	CommentDBBean cdb = CommentDBBean.getInstance();
	CommentBean comment = cdb.getComment(cmt_index);
	
	if(comment != null){
		cmt_num = comment.getCmt_num();
        cmt_index = comment.getCmt_index();
		cmt_step = comment.getCmt_step();
		cmt_level = comment.getCmt_level();
		cmt_ref = comment.getCmt_ref();
		

	System.out.println("cmt_num >> " + cmt_num);
	System.out.println("cmt_step >> " + cmt_step);
	System.out.println("cmt_level >> " + cmt_level);
	System.out.println("cmt_ref >> " + cmt_ref);
		
%>
	
	<div class="table" align="center">
               <table class="table table-bordered" cellpadding="10" cellspacing="5" width="150" height="auto">
                  <form action="comm_Comment_Ok.jsp?comm_index=<%=cmt_comm_index%>&cmt_index=<%=cmt_index %>" method="post" >
					<input type="hidden" name="cmt_num" value="<%=cmt_num%>">
					<input type="hidden" name="cmt_step" value="<%=cmt_step%>">
					<input type="hidden" name="cmt_level" value="<%=cmt_level%>">
					<input type="hidden" name="cmt_ref" value="<%=cmt_ref%>">
					<input type="hidden" name="result" value="1">
					<tr height="30"></tr>
                     <tr>
                        <td>
                           <h3 align="left"><img src="../css/comment_icon.png" height="40"> &nbsp;답댓글 작성</h3> 
                           <textarea name="comment" cols="60" rows="4"></textarea>
                       <div class="mbutton">
                           <input type="submit" class="button" value="댓글입력"/> 
                           &nbsp;&nbsp; 
                           <input type="button" class="button" value="창닫기" onclick="window.close()"/>
                        </div>
                      </td>
            <%
				}
            %>
           			 </tr>
                  </form>
               </table>
            </div>
	
</body>

</html>
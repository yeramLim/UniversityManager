<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="myUtil.HanConv"%>
<%@page import="student.*"%>
<%@page import="board.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<jsp:useBean id="comment" class="board.CommentBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="comment" />

<%
	// request.setCharacterEncoding("euc-kr");	

	//����¡ ó��
	String pageNUM = request.getParameter("pageNUM");
	if (pageNUM == null) {
		pageNUM = "1";
	}

	// �������� �޾ƿͼ� id�� ����
	int id = (Integer) session.getAttribute("uid"); 

	// �Խñ� ������ȣ
	int cmt_comm_index = Integer.parseInt(request.getParameter("comm_index")); 
	System.out.println("cmt_comm_index > " + cmt_comm_index);
	
	// �л� ���� �޾ƿ���
	StudentDBBean manager = StudentDBBean.getInstance();
	StudentBean stu_b = manager.getStudent(id);
	
	String stu_name = stu_b.getStu_name();
	int stu_id = stu_b.getStu_id();
	
	// ��� ����
	String cmt_content = HanConv.toKor(request.getParameter("comment")); 
	
	// �ۼ��ð�
	Timestamp cmt_date = new Timestamp(System.currentTimeMillis());
	
	int cmt_index = 0, cmt_num = 0, cmt_step = 0, cmt_level = 0, cmt_ref = 1;
	
	// ��� ���� �ε��� �޾ƿ���
	cmt_index = Integer.parseInt(request.getParameter("cmt_index"));
	
	// ���� cmt_level �� 0�� �ƴϸ�
	if(cmt_level != 0){
		// num, step, level, ref �� �����ͼ�
		cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		cmt_step = Integer.parseInt(request.getParameter("cmt_step"));
		cmt_level = Integer.parseInt(request.getParameter("cmt_level"));
		cmt_ref = Integer.parseInt(request.getParameter("cmt_ref"));
		System.out.println("cmt_level >> " + cmt_level);
		System.out.println("cmt_step >> " + cmt_step);
		
		// comment ��ü�� ����
		comment.setCmt_level(cmt_level);
		comment.setCmt_ref(cmt_index);
		comment.setCmt_step(cmt_step);
		
		
	}
	
	// �Խ��� ���� �޾ƿ���
	BoardDBBean bd = BoardDBBean.getInstance();
	BoardBean board = bd.getBoard(cmt_comm_index, true);
	
	if (board != null) {
		cmt_comm_index = board.getComm_index(); // �Խñ� index ��ȣ �޾ƿͼ� ����
	}
	
	comment.setCmt_comm_index(cmt_comm_index);
	comment.setCmt_content(cmt_content);
	comment.setCmt_stu_id(stu_id);
	comment.setCmt_writer(stu_name);
	comment.setCmt_date(cmt_date);
	
	
	// ��� �ν��Ͻ� ����
	CommentDBBean cdb = CommentDBBean.getInstance();
	
	int re = cdb.insertComment(comment);
	
	if (re == 1) { // �޼ҵ带 ���� �� return ���� 1�̸� ����
		String result = request.getParameter("result");
		
		System.out.println("result >"+ result);
		
		if(result.equals("1")){
			out.print("<script>");
			out.print("window.opener.document.location.href='comm_show.jsp'");
			out.print("alert('����� ���������� ��ϵǾ����ϴ�');");
			out.print("window.close()");
			out.print("</script>");
		}else{
			out.print("<script>");
			out.print("alert('����� ���������� ��ϵǾ����ϴ�');");
			out.print("location.href='comm_Show.jsp?comm_index=" + cmt_comm_index + "&pageNUM=" + pageNUM + "'");
			out.print("</script>");	
		}
				
	}else{
		out.print("<script>");
		out.print("alert('��� ��� ����');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	
	
	 %>
<script type="text/javascript">
	window.opener.location.reload();
	window.close();
</script>
	
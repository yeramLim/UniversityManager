<!-- ��� ���� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="student.*"%>
<%@ page import="board.*"%>

	<%
	// �������� �޾ƿͼ� id�� ����
	int id = (Integer) session.getAttribute("uid"); 

	// �л� �ν��Ͻ� ����, �л� ���� �����ͼ� stu_b�� ����
	StudentDBBean manager = StudentDBBean.getInstance(); 
	StudentBean stu_b = manager.getStudent(id); 
	
	// ������ �л� �������� �й��� �����ͼ� ����
	int stu_id = stu_b.getStu_id(); 

	// �Ѿ�� �Խ��� ������ȣ
	int cmt_comm_index = Integer.parseInt(request.getParameter("comm_index"));
	// �Ѿ�� ��� ��ȣ
	int cmtindex = Integer.parseInt(request.getParameter("cmt_index")); 
	
	// ��� �ν��Ͻ� ����
	CommentDBBean cdb = CommentDBBean.getInstance(); 
	CommentBean comment = new CommentBean();
	
	ArrayList<CommentBean> commentList = cdb.getListComment(cmt_comm_index); 
	
	int cmt_num = 0;
	int cmt_stu_id = 0;
	int cmt_index = 0;
	
	// commentList �� ��ȸ �ݺ�(������ �ʿ��� ���� ��������)
	for (int i = 0; i < commentList.size(); i++) { 
		comment = commentList.get(i);
		cmt_index = comment.getCmt_index();
		cmt_stu_id = comment.getCmt_stu_id();
		
		// ���� ��� �ۼ����� �й��� ���� ������ �й��� ����, �Ѿ�� ��۹�ȣ�� commentList�� �ִ� ��۹�ȣ�� ������ ����
		if(cmt_stu_id == stu_id && cmtindex == cmt_index) { 
			
			int re = cdb.deleteComment(cmt_index);

			System.out.print("re >> " + re);
			
			if (re > 0) { // ���� �޼ҵ带 ���� �� return ���� 1�̸� ���� �� ���� �Խñ۷� �̵�
				out.print("<script>");
				out.print("alert('���� �Ϸ�');");
				out.print("location.href='comm_Show.jsp?comm_index=" + cmt_comm_index + "'");
				out.print("</script>");		
			}else{
				out.print("<script>");
				out.print("alert('��� ���� ����');");
				out.print("history.go(-1);");
				out.print("</script>");
			}
		}
	}
	
	%>

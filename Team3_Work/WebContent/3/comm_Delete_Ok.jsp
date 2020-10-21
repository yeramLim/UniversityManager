<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="student.*"%>
<%@ page import="board.*" %>

	<%
		int id = (Integer)session.getAttribute("uid"); // �������� �޾ƿͼ� id�� ����
		
		// �Խ��� ����
		int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn"));
		// �Խñ� ���� ��ȣ
		int comm_index = Integer.parseInt(request.getParameter("comm_index")); 

		// �����ϱ� ���� �Է��� ��й�ȣ
		String board_pwd = request.getParameter("board_pwd"); 

		// �л� �ν��Ͻ� ����
		StudentDBBean manager = StudentDBBean.getInstance();
		StudentBean stu_b = manager.getStudent(id);
		
		// �л��������� ��й�ȣ �޾ƿ�
		String stu_pwd = stu_b.getStu_pwd(); 
		
		// �Է¹��� ��й�ȣ�� �����̸�
		if(board_pwd == null){
			out.print("<script>");
			out.print("alert('��й�ȣ�� �Է��ϼ���');");
			out.print("history.go(-1);");
			out.print("</script>");
		}else{ 
		// �л��������� �޾ƿ� ��й�ȣ�� �Է¹��� ��й�ȣ�� ���� ���� ���
			if(!stu_pwd.equals(board_pwd)){
				out.print("<script>");
				out.print("alert('��й�ȣ�� �ٸ��ϴ�.');");
				out.print("history.go(-1);");
				out.print("</script>");
				
			}else{ // ��й�ȣ�� ���� ���
				BoardDBBean boardDBBean = BoardDBBean.getInstance();
				
				// �۹�ȣ�� �Խñ� ���� ������
				BoardBean board = boardDBBean.getBoard(comm_index, false);
				
				
				int re = boardDBBean.deleteBoard(comm_index, stu_pwd, board_pwd);	
				
				System.out.println("re >>" + re);
				
				if(re > 0){
					
					// ����Ǿ� �ִ� ������ ���� ���, ���丮���� �����ϵ��� ��
					// �۹�ȣ�� ã�� ������ �ִ� systemFileName �� fileName�� ����
					String fileName = board.getComm_systemFileName();
					
					if(fileName != null){
						
						// ������ ������ ��� ','�� �������� ���ϸ��� �߶� array�� �����
						String[] array = fileName.split(",");
						String folder = "C:/upload/";
						
						for(int i = 0; i < array.length; i++){
							System.out.println(array[i]);
							String filePath = folder + "/" + array[i];
							
							File file = new File(filePath);
							if(file.exists()){
								file.delete(); // ������ 1���� ���ε� �Ǳ⶧���� �ѹ��� �������ָ� ��
							}
						
						}
				
					}
					if (comm_groupn == 1) {
						out.print("<script>");
						out.print("alert('���������� �����Ǿ����ϴ�.');");
						out.print("location.href='comm_Freeboard.jsp';");
						out.print("</script>");
					} else {
						out.print("<script>");
						out.print("alert('���������� �����Ǿ����ϴ�.');");
						out.print("location.href='comm_Q_And_A.jsp';");
						out.print("</script>");
					}
				
				}
			}
		}
		
	%>

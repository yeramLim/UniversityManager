<!-- �Խñ� ���� �Ϸ� -->
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="myUtil.HanConv"%>
<%@page import="board.*"%>
<%@page import="student.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.util.Date"%>

<jsp:useBean id="board" class="board.BoardBean">
	<jsp:setProperty property="*" name="board" />
</jsp:useBean>

	<%
	String pageNUM = request.getParameter("pageNUM");
	// �Խ��� ����
	int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn")); 
	// �Խñ� ���� ��ȣ
	int comm_index = Integer.parseInt(request.getParameter("comm_index"));
	
	// �Խñ� �ν��Ͻ� ����
	BoardDBBean db = BoardDBBean.getInstance();
	
	// ���� ���ε�
	// request.getRealPath("/upload") �� ���� ������ ������ ���� ��θ� ���ؿ´�
	// �ü�� �� ������Ʈ�� ������ ȯ�濡 ���� ��ΰ� �ٸ��� ������ �Ʒ�ó�� ���ؿ��� ��
	String comm_title = "";
		String comm_content = "";
		String comm_originFileName = "";
		String comm_systemFileName = "";
		
		int comm_num = 0;
		
		Date date = new Date();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = upload.parseRequest(request);

		String uploadPath = "C:/upload/";
		
		Iterator itr = items.iterator();
	     while (itr.hasNext()) {
	          FileItem item = (FileItem) itr.next();
	          if (item.isFormField()) {
	        	  if(item.getFieldName().equals("comm_title")){
	        		  comm_title = HanConv.toKor(item.getString());
	        	  }else if(item.getFieldName().equals("comm_content")){
	        		  comm_content = HanConv.toKor(item.getString());
	        		  comm_content = comm_content.replace("\n", "<br>");
	        	  }else if(item.getFieldName().equals("comm_index")){
	        		  comm_index = Integer.parseInt(item.getString());	
	        	  }else if(item.getFieldName().equals("comm_num")){
	        		  comm_num = Integer.parseInt(item.getString());	        		  
	        	  }else if(item.getFieldName().equals("comm_groupn")){
	        		  comm_groupn = Integer.parseInt(item.getString());	        		  
	        	  }
	          }else {
	        	  if(item.getFieldName().equals("uploads")){
		        	 	String time = Long.toString(date.getTime());
		             	String itemName = item.getName();
		             	if(itemName.length() != 0){
		            	 	comm_originFileName += itemName + ",";
		            	 	comm_systemFileName += time + "_" + itemName + ",";
		             		File savedFile = new File(uploadPath + "/" + time + "_" +itemName);
		             		File Folder = new File("c:\\upload");
		             		if(!Folder.exists()){
		             			try{
		             				Folder.mkdir(); // ���� ����
		             			}catch(Exception e){
		             				e.getStackTrace();
		             			}
		             		}
		             		item.write(savedFile);	
		            	 }
	             }
	          }
	     }
		
		if(comm_originFileName.length() == 0){
			comm_originFileName = null;
			comm_systemFileName = null;
		}else{
			board.setComm_originFileName(comm_originFileName);
			board.setComm_systemFileName(comm_systemFileName);
		}
	
		String clob = "";
		for(int i=0; i< comm_content.length(); ){ 
			i = i + 2500;
			if(i > comm_content.length()){
				clob += comm_content.substring((i-2500), comm_content.length()-1);
				break;
			}else{
				clob += comm_content.substring((i-2500), i);			
			}
		}

	// ����� ���� �ν��Ͻ��� ����
	board.setComm_title(comm_title);
	board.setComm_content(clob);
	System.out.println(clob);
	System.out.println("comm_groupn >> " + comm_groupn);
	


	int re = db.editBoard(board);

	if (re == 1) {
		out.print("<script>");
		out.print("alert('�Խñ� ������ �Ϸ�Ǿ����ϴ�.');");
		out.print("location.href='comm_Show.jsp?comm_index=" + comm_index + "&pageNUM="+ pageNUM + "'");
		out.print("</script>");	
	} else {
		out.print("<script>");
		out.print("alert('�Խñ� ������ �����߽��ϴ�');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	%>

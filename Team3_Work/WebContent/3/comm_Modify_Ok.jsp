<!-- 게시글 수정 완료 -->
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
	// 게시판 종류
	int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn")); 
	// 게시글 고유 번호
	int comm_index = Integer.parseInt(request.getParameter("comm_index"));
	
	// 게시글 인스턴스 생성
	BoardDBBean db = BoardDBBean.getInstance();
	
	// 파일 업로드
	// request.getRealPath("/upload") 를 통해 파일을 저장할 절대 경로를 구해온다
	// 운영체제 및 프로젝트가 위차할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는 것
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
		             				Folder.mkdir(); // 폴더 생성
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

	// 제목과 본문 인스턴스에 저장
	board.setComm_title(comm_title);
	board.setComm_content(clob);
	System.out.println(clob);
	System.out.println("comm_groupn >> " + comm_groupn);
	


	int re = db.editBoard(board);

	if (re == 1) {
		out.print("<script>");
		out.print("alert('게시글 수정이 완료되었습니다.');");
		out.print("location.href='comm_Show.jsp?comm_index=" + comm_index + "&pageNUM="+ pageNUM + "'");
		out.print("</script>");	
	} else {
		out.print("<script>");
		out.print("alert('게시글 수정에 실패했습니다');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	%>

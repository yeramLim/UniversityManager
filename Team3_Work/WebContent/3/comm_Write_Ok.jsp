<%@page import="javax.swing.plaf.metal.MetalIconFactory.FolderIcon16"%>
<%@page import="sun.invoke.empty.Empty"%>
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

<jsp:useBean id="board" class="board.BoardBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="board" />

	<%
	request.setCharacterEncoding("euc-kr");
	
	// 세션정보 받아와서 id에 저장
	int id = (Integer) session.getAttribute("uid"); 

	// 학생 인스턴스 생성, 학생 정보 가져와서 stu_b에 저장
	StudentDBBean manager = StudentDBBean.getInstance();
	StudentBean stu_b = manager.getStudent(id);
	
	// 가져온 학생의 이름과 학번을 변수에 저장
	String stu_name = stu_b.getStu_name();
	int stu_id = stu_b.getStu_id();

	// 넘어온 게시판종류 저장
	int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn")); 
	
	// 작성일 저장
	board.setComm_date(new Timestamp(System.currentTimeMillis())); 

	// 게시글 객체 생성
	BoardDBBean db = BoardDBBean.getInstance(); 

	// 파일 업로드
	// request.getRealPath("/upload") 를 통해 파일을 저장할 절대 경로를 구해온다
	// 운영체제 및 프로젝트가 위차할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는 것
		String comm_title = "";
		String comm_content = "";
		String comm_originFileName = "";
		String comm_systemFileName = "";
		
		
		int comm_index = 0, comm_num = 0;
		int comm_ref=1, comm_step=0, comm_level=0;
		
		String uploadPath = "C:/upload/";
		

		Date date = new Date();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = upload.parseRequest(request);

		Iterator itr = items.iterator();
	     while (itr.hasNext()) {
	          FileItem item = (FileItem) itr.next();
	          if (item.isFormField()) {
	        	  if(item.getFieldName().equals("comm_groupn")){
	        		  comm_groupn = Integer.parseInt(item.getString());
	        	  }else if(item.getFieldName().equals("comm_title")){
	        		  comm_title = HanConv.toKor(item.getString());
	        	  }else if(item.getFieldName().equals("comm_content")){
	        		  comm_content = HanConv.toKor(item.getString());
	        		  comm_content = comm_content.replace("\n", "<br>");
	        	  }else if(item.getFieldName().equals("comm_index")){
	        		  comm_index = Integer.parseInt(item.getString());	
	        	  }else if(item.getFieldName().equals("comm_num")){
	        		  comm_num = Integer.parseInt(item.getString());	        		  
	        	  }else if(item.getFieldName().equals("comm_ref")){
	        		  comm_ref = Integer.parseInt(item.getString());
	        	  }else if(item.getFieldName().equals("comm_step")){
	        		  comm_step = Integer.parseInt(item.getString());	        		  
	        	  }else if(item.getFieldName().equals("comm_level")){
	        		  comm_level = Integer.parseInt(item.getString());	        		  
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
		
		board.setComm_content(clob);
		System.out.println(clob);
		System.out.println("comm_groupn >> " + comm_groupn);
		
	

	// 받아온 학생이름, 학번을 board 인스턴스에 저장
	board.setComm_writer(stu_name);
	board.setComm_stu_id(stu_id);
	
	// 제목과 본문 인스턴스에 저장
	board.setComm_title(comm_title);
	board.setComm_content(comm_content);
	
	// 그룹번호(게시글의 index값을 받아와서 저장)
	board.setComm_ref(comm_ref); 
	
	board.setComm_groupn(comm_groupn);

	// 답글일 경우 multi.getPara 로 받은 값들 저장
	if (comm_level != 0) { 
		board.setComm_step(comm_step); // 순서
		board.setComm_level(comm_level); // 위치
	}
	
	int re = db.insertBoard(board);

	if (re == 1) {
		if (comm_groupn == 1) {
			out.print("<script>");
			out.print("alert('게시글이 정상적으로 등록되었습니다');");
			out.print("location.href='comm_Freeboard.jsp';");
			out.print("</script>");
		} else if (comm_groupn == 2 || comm_groupn == 3) {
			out.print("<script>");
			out.print("alert('게시글이 정상적으로 등록되었습니다');");
			out.print("location.href='comm_Q_And_A.jsp';");
			out.print("</script>");
		}
	} else {
		out.print("<script>");
		out.print("alert('게시글 작성이 실패했습니다');");
		out.print("history.go(-1)");
		out.print("</script>");
	}
	%>

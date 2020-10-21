<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="student.*"%>
<%@ page import="board.*" %>

	<%
		int id = (Integer)session.getAttribute("uid"); // 세션정보 받아와서 id에 저장
		
		// 게시판 종류
		int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn"));
		// 게시글 고유 번호
		int comm_index = Integer.parseInt(request.getParameter("comm_index")); 

		// 삭제하기 위해 입력한 비밀번호
		String board_pwd = request.getParameter("board_pwd"); 

		// 학생 인스턴스 생성
		StudentDBBean manager = StudentDBBean.getInstance();
		StudentBean stu_b = manager.getStudent(id);
		
		// 학생정보에서 비밀번호 받아옴
		String stu_pwd = stu_b.getStu_pwd(); 
		
		// 입력받은 비밀번호가 공백이면
		if(board_pwd == null){
			out.print("<script>");
			out.print("alert('비밀번호를 입력하세요');");
			out.print("history.go(-1);");
			out.print("</script>");
		}else{ 
		// 학생정보에서 받아온 비밀번호와 입력받은 비밀번호가 같지 않은 경우
			if(!stu_pwd.equals(board_pwd)){
				out.print("<script>");
				out.print("alert('비밀번호가 다릅니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				
			}else{ // 비밀번호가 같을 경우
				BoardDBBean boardDBBean = BoardDBBean.getInstance();
				
				// 글번호로 게시글 정보 가져옴
				BoardBean board = boardDBBean.getBoard(comm_index, false);
				
				
				int re = boardDBBean.deleteBoard(comm_index, stu_pwd, board_pwd);	
				
				System.out.println("re >>" + re);
				
				if(re > 0){
					
					// 저장되어 있는 파일이 있을 경우, 디렉토리에서 삭제하도록 함
					// 글번호로 찾은 정보에 있는 systemFileName 을 fileName에 저장
					String fileName = board.getComm_systemFileName();
					
					if(fileName != null){
						
						// 복수의 파일일 경우 ','을 기준으로 파일명을 잘라서 array에 담아줌
						String[] array = fileName.split(",");
						String folder = "C:/upload/";
						
						for(int i = 0; i < array.length; i++){
							System.out.println(array[i]);
							String filePath = folder + "/" + array[i];
							
							File file = new File(filePath);
							if(file.exists()){
								file.delete(); // 파일은 1개만 업로드 되기때문에 한번만 삭제해주면 됨
							}
						
						}
				
					}
					if (comm_groupn == 1) {
						out.print("<script>");
						out.print("alert('정상적으로 삭제되었습니다.');");
						out.print("location.href='comm_Freeboard.jsp';");
						out.print("</script>");
					} else {
						out.print("<script>");
						out.print("alert('정상적으로 삭제되었습니다.');");
						out.print("location.href='comm_Q_And_A.jsp';");
						out.print("</script>");
					}
				
				}
			}
		}
		
	%>

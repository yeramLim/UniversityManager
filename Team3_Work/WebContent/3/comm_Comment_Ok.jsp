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

	//페이징 처리
	String pageNUM = request.getParameter("pageNUM");
	if (pageNUM == null) {
		pageNUM = "1";
	}

	// 세션정보 받아와서 id에 저장
	int id = (Integer) session.getAttribute("uid"); 

	// 게시글 고유번호
	int cmt_comm_index = Integer.parseInt(request.getParameter("comm_index")); 
	System.out.println("cmt_comm_index > " + cmt_comm_index);
	
	// 학생 정보 받아오기
	StudentDBBean manager = StudentDBBean.getInstance();
	StudentBean stu_b = manager.getStudent(id);
	
	String stu_name = stu_b.getStu_name();
	int stu_id = stu_b.getStu_id();
	
	// 댓글 내용
	String cmt_content = HanConv.toKor(request.getParameter("comment")); 
	
	// 작성시간
	Timestamp cmt_date = new Timestamp(System.currentTimeMillis());
	
	int cmt_index = 0, cmt_num = 0, cmt_step = 0, cmt_level = 0, cmt_ref = 1;
	
	// 댓글 고유 인덱스 받아오기
	cmt_index = Integer.parseInt(request.getParameter("cmt_index"));
	
	// 만약 cmt_level 이 0이 아니면
	if(cmt_level != 0){
		// num, step, level, ref 값 가져와서
		cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		cmt_step = Integer.parseInt(request.getParameter("cmt_step"));
		cmt_level = Integer.parseInt(request.getParameter("cmt_level"));
		cmt_ref = Integer.parseInt(request.getParameter("cmt_ref"));
		System.out.println("cmt_level >> " + cmt_level);
		System.out.println("cmt_step >> " + cmt_step);
		
		// comment 객체에 저장
		comment.setCmt_level(cmt_level);
		comment.setCmt_ref(cmt_index);
		comment.setCmt_step(cmt_step);
		
		
	}
	
	// 게시판 정보 받아오기
	BoardDBBean bd = BoardDBBean.getInstance();
	BoardBean board = bd.getBoard(cmt_comm_index, true);
	
	if (board != null) {
		cmt_comm_index = board.getComm_index(); // 게시글 index 번호 받아와서 저장
	}
	
	comment.setCmt_comm_index(cmt_comm_index);
	comment.setCmt_content(cmt_content);
	comment.setCmt_stu_id(stu_id);
	comment.setCmt_writer(stu_name);
	comment.setCmt_date(cmt_date);
	
	
	// 댓글 인스턴스 생성
	CommentDBBean cdb = CommentDBBean.getInstance();
	
	int re = cdb.insertComment(comment);
	
	if (re == 1) { // 메소드를 돌고 난 return 값이 1이면 삭제
		String result = request.getParameter("result");
		
		System.out.println("result >"+ result);
		
		if(result.equals("1")){
			out.print("<script>");
			out.print("window.opener.document.location.href='comm_show.jsp'");
			out.print("alert('댓글이 정상적으로 등록되었습니다');");
			out.print("window.close()");
			out.print("</script>");
		}else{
			out.print("<script>");
			out.print("alert('댓글이 정상적으로 등록되었습니다');");
			out.print("location.href='comm_Show.jsp?comm_index=" + cmt_comm_index + "&pageNUM=" + pageNUM + "'");
			out.print("</script>");	
		}
				
	}else{
		out.print("<script>");
		out.print("alert('댓글 등록 실패');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	
	
	 %>
<script type="text/javascript">
	window.opener.location.reload();
	window.close();
</script>
	
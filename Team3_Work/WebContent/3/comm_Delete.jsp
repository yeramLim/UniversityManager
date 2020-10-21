<!-- 게시글 삭제 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="board.*"%>
<%@page import="student.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>

	<%
	// 게시판 고유번호
	int comm_index = Integer.parseInt(request.getParameter("comm_index")); 

	// 게시판 인스턴스 생성
	BoardDBBean db = BoardDBBean.getInstance();
	
	// 삭제를 위해 게시판정보를 받아오기 때문에 조회수 변동 없음(false)
	BoardBean board = db.getBoard(comm_index, false);

	String comm_title = "";
	String comm_content = "";
	String comm_writer = "";
	Timestamp comm_date;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int comm_num = 0;
	int comm_hits = 0;
	int comm_groupn = 0;

	if (board != null) {
		comm_num = board.getComm_num();
		comm_title = board.getComm_title();
		comm_content = board.getComm_content();
		comm_date = board.getComm_date();
		comm_hits = board.getComm_hits();
		comm_groupn = board.getComm_groupn();
		comm_writer = board.getComm_writer();
	%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 삭제</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="../3/script.js" charset="utf-8"></script>

<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../resource/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
	
	<div id="contents">
		<div class="container">
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">글삭제</li>
			</ul>
			
			<div id="tab-1" class="tab-content current">
				<form action="comm_Delete_Ok.jsp?comm_index=<%=comm_index%>&comm_groupn=<%=comm_groupn%>" method="post" name="form">
					<div class="table">
						<table class="table table-bordered" cellpadding="10" cellspacing="4" width="800" height="200">
							<tr>
								<th class="menu">글번호</th>
								<td width="300"><%=comm_num%></td>
								<th class="menu">날짜</th>
								<td><%=sdf.format(comm_date)%></td>
							</tr>
							<tr>
								<th class="menu">작성자</th>
								<td><%=comm_writer%></td>
								<th class="menu">조회수</th>
								<td><%=comm_hits%></td>
							</tr>
							<tr height="30"></tr>
							<%
								// 게시판 번호에 따라 분류항목 출력을 위한 조건절
								if (comm_groupn == 1) {
							%>
							<tr>
								<th class="menu">제목</th>
								<td colspan="4" align="left"><%=comm_title%></td>

							</tr>
							<%
								} else if (comm_groupn == 2) {
							%>
							<tr>
								<th class="menu">분류</th>
								<td colspan="3" align="left"><%="[학사 문의]"%></td>
							</tr>
							<tr>
								<th class="menu">제목</th>
								<td colspan="3" align="left"><%=comm_title%></td>
							</tr>
							<%
								} else if (comm_groupn == 3) {
							%>
							<tr>
								<th class="menu">분류</th>
								<td colspan="3" align="left"><%="[학적 문의]"%></td>
							</tr>
							<tr>
								<th class="menu">제목</th>
								<td colspan="3" align="left"><%=comm_title%></td>
							</tr>
							<%
								}
							%>
							<tr height="30">
								<th>비밀번호</th>
								<td colspan="3" align="left">
									<input type="password" name="board_pwd">
								</td>
							</tr>
						</table>
					</div>
					
					<!-- 삭제 및 취소 버튼 -->
					<p class="mbutton">
						<input type="submit" class="button" value="삭제" onclick="delete_ok()" /> 
						&nbsp;&nbsp; 
						<input type="button" class="button" value="취소" onclick="history.go(-1)"/>
					</p>
				</form>
				
			</div> <!-- <div id="tab-1" class="tab-content current"> END -->
		</div> <!-- <div class="container"> END -->
	</div> <!-- <div id="contents"> END -->
	<%
		}
	%>
		<!-- footer -->
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
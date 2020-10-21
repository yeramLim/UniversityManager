<!-- ���ǰԽ��� -->
<%@page import="myUtil.HanConv"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="board.*"%>
<%@page import="student.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>

<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ǰԽ���</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="script.js" charset="utf-8"></script>

<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../resource/js/bootstrap.min.js"></script>
<style>
section {
	height: 80vh;
	display: block;
}
footer {
	clear: both;
	display: block;
}
footer {
	text-align: center;
}
</style>
</head>
<body>
	<%
	// ���� ��������
		String stu_name = request.getParameter("stu_name"); 
		BoardDBBean db = new BoardDBBean();

		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

		// ����¡ ó��
		String pageNUM = request.getParameter("pageNUMQ");
		if (pageNUM == null) {
			pageNUM = "1";
		}
		// �˻�� ���� ���, ���� �޾Ƽ� ������ ����
		if(request.getParameter("search") != null){
			String search_col = HanConv.toKor(request.getParameter("search_col"));
			String search = HanConv.toKor(request.getParameter("search"));
			boardList = db.getListBoard(search_col, search, 2, pageNUM);
			
		}else{
			
			boardList = db.getListBoard("", "", 2, pageNUM);
		}

	String comm_title, comm_date2, comm_writer, comm_originalFileName, comm_systemFileName;
	Timestamp comm_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int comm_index = 0;
	int comm_num = 0;
	int comm_hits = 0;
	int comm_groupn = 0;
	int comm_level = 0;
	%>
	
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
	
	<section>
		<div id="contents">
			<div class="container">
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">�л���ù���</li>
				</ul>

				<div id="tab-1" class="tab-content current">
					<div class="table">
						<table class="table table-bordered" cellpadding="10" cellspacing="3" width="800" height="auto">
							<tr>
								<th>�۹�ȣ</th>
								<th>�з�</th>
								<th width="600">����</th>
								<th>�ۼ���</th>
								<th>�ۼ���</th>
								<th>��ȸ��</th>
							</tr>

							<%
							// ��� ��ü ����
							CommentDBBean cdb = CommentDBBean.getInstance();
							CommentBean comment = new CommentBean();

							int count = 0;

							for (int i = 0; i < boardList.size(); i++) {
								board = boardList.get(i);
								comm_index = board.getComm_index();
								comm_num = board.getComm_num();
								comm_groupn = board.getComm_groupn();
								comm_title = board.getComm_title();
								comm_writer = board.getComm_writer();
								comm_date = board.getComm_date();
								comm_hits = board.getComm_hits();
								comm_level = board.getComm_level();
								comm_originalFileName = board.getComm_originFileName();
								comm_systemFileName = board.getComm_systemFileName();
								
								SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
								String inputDate = sf.format(comm_date);
								String now = sf.format(new Date());

								count = cdb.getCountComment(comm_index); // ��� ����

								if (comm_groupn == 2 || comm_groupn == 3) {
							%>
							<tr class="off" onmouseover="this.className='on'" onmouseout="this.className='off'">
								<td align="center"><%=comm_num%></td>
								<td align="center">
									<%
										if (comm_groupn == 2) {
									%>
									<%="[�л繮��]"%>
									<%
										} else {
									%>
									<%="[��������]"%>
									<%
										}
									%>
								</td>
								<td width="400" align="left">
									<%
										if (comm_level > 0) {
											for (int j = 0; j < comm_level; j++) {
									%>
												&nbsp;&nbsp;
									<%
											}
									%>
										<img alt="����̹���" src="../css/icon.gif" width="30" height="15">

									<%
										}
									%>
										<a href="comm_Show.jsp?comm_index=<%=comm_index%>&pageNUMQ=<%=pageNUM%>">&nbsp;<%=comm_title%></a>
									<%
									if(count != 0){
									%>
									<span style="color:red;"><%="    [" + count + "]"%></span>
									<%
									}
									%>
									
									
									<%
									// ������ ���� ��� ������ ǥ��
									if (comm_originalFileName != null) {
									%>
									&nbsp;<img alt="�������� ������" src="../css/img_b_save.png" width="15" height="15">
									<%
									}
									%>
									<%
									if(inputDate.equals(now)){
									%>
									&nbsp;&nbsp;<img alt="" src="../css/new.png" height="22" width="25">
									<%
									}
									%>
								</td>
								<td align="center"><%=comm_writer%></td>
								<td align="center"><%=sdf.format(comm_date)%></td>
								<td align="center"><%=comm_hits%></td>
							</tr>
							<%
								}
							}
							%>

						</table>
						<!-- �۾��� ��ư -->
						<p class="mbutton">
							<input class="button" type="button" value="�۾���" onclick="location.href='comm_Write.jsp?comm_groupn=2'" />
						</p>
						
						<!-- ����¡ ó�� -->
						<br> <br>
						<div align="center"><%=board.pageNumberqANDa(4)%></div>

						
						<!-- �˻� -->
						<form action="comm_Q_And_A.jsp" method="post" name="search_frm">
							<p class="select">
								<select name="search_col">
									<option value="search_title">����</option>
									<option value="search_content">����</option>
								</select>
								<input type="text" name="search" /> <input type="submit" class="button" value="�˻�" onclick="search_ok()"/>
							</p>
						</form>

					</div>
					<!-- <div class="table"> END  -->
				</div>
				<!-- <div id="tab-1" class="tab-content current"> END -->
			</div>
			<!-- <div class="container"> END -->
		</div>
		<!-- <div id="contents"> END -->
	</section>

	<!-- footer -->
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
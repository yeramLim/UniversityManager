<!-- �л���� -->
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
<title>�л����</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="../3/script.js" charset="utf-8"></script>

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
   BoardDBBean db = new BoardDBBean();

	ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

	// ����¡ ó��
	String pageNUM = request.getParameter("pageNUMN");
	if (pageNUM == null) {
		pageNUM = "1";
	}
	// �˻�� ���� ���, ���� �޾Ƽ� ������ ����
	if(request.getParameter("search_content") != null){
		String search_col = request.getParameter("search_col");
		String search = request.getParameter("search");
		boardList = db.getListBoard(search_col, search, 4, pageNUM);
		
	}else{
		
		boardList = db.getListBoard("", "", 4, pageNUM);
	}


   String comm_title, comm_date2, comm_originalFileName, comm_systemFileName;
   Timestamp comm_date;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   int comm_index = 0;
   int comm_num = 0;
   int comm_hits = 0;
   int comm_groupn = 0;
   %>

   <jsp:include page="../main/menu.jsp"></jsp:include>
   <jsp:include page="../main/sidemenu.jsp"></jsp:include>

   <section>
      <div id="contents">
         <div class="container">
            <ul class="tabs">
               <li class="tab-link current" data-tab="tab-1">�л����</li>
            </ul>

            <div id="tab-1" class="tab-content current">
               <div class="table">
                  <table class="table table-bordered" cellpadding="10" cellspacing="3" width="800" height="auto">
                     <tr>
                        <th>�۹�ȣ</th>
                        <th width="700">����</th>
                        <th>�ۼ���</th>
                        <th>��ȸ��</th>
                     </tr>
                     <%
                        for (int i = 0; i < boardList.size(); i++) {
                        board = boardList.get(i);
                        comm_index = board.getComm_index();
                        comm_num = board.getComm_num();
                        comm_groupn = board.getComm_groupn();
                        comm_title = board.getComm_title();
                        comm_date = board.getComm_date();
                        comm_hits = board.getComm_hits();
                        comm_originalFileName = board.getComm_originFileName();
                        comm_systemFileName = board.getComm_systemFileName();
                        
                        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
                        String inputDate = sf.format(comm_date);
                        String now = sf.format(new Date());

                        if (comm_groupn == 4) {
                     %>
                     <tr class="off" onmouseover="this.className='on'" onmouseout="this.className='off'">
                        <td align="center"><%=comm_num%></td>
                        <td width="500" align="left">
                           <a href="../3/comm_Show.jsp?comm_index=<%=comm_index%>&pageNUMN=<%=pageNUM%>">&nbsp;<%=comm_title%></a>
                           
                           
                           
                           <%
                           // ������ ���� ��� ������ ǥ��
                              if (comm_originalFileName != null) {
                           %>
                           <img alt="�������� ������" src="../css/img_b_save.png" width="15" height="15">
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

                        <td align="center"><%=sdf.format(comm_date)%></td>
                        <td align="center"><%=comm_hits%></td>
                     </tr>
                     <%
                        }
                     }
                     %>
                  </table>
                  <!-- ����¡ ó�� -->
                  <br> <br>
                  <div align="center"><%=board.pageNumberNotice(4)%></div>

                  <!-- �˻� -->
                  <form action="stu_Notice.jsp" method="post" name="search_frm">
                     <p class="select">
                        <select name="search_col">
                           <option value="search_title">����</option>
                           <option value="search_content">����</option>
                        </select>
                        <input type="text" name="search" /> <input class="button" type="submit" value="�˻�" onclick="search_ok()" />
                     </p>
                  </form>

               </div>
               <!-- <div class="table"> END -->
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
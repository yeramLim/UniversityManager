<!-- 게시글 조회 -->
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="board.*"%>
<%@page import="student.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
   <%
   // 게시글 고유번호
   int commindex = Integer.parseInt(request.getParameter("comm_index")); 
   
   // 있던 페이지로 돌아갈 수 있도록 pageNUM 받아옴
   String pageNUMF = request.getParameter("pageNUMF");
   String pageNUMQ = request.getParameter("pageNUMQ");
   String pageNUMN = request.getParameter("pageNUMN");
   System.out.println("pageNUMF >> " + pageNUMF);
   System.out.println("pageNUMQ >> " + pageNUMQ);
   System.out.println("pageNUMN >> " + pageNUMN);

   // 세션정보 받아와서 id에 저장
   int id = (Integer) session.getAttribute("uid"); 

   // 학생 인스턴스 생성
   StudentDBBean manager = StudentDBBean.getInstance(); 
   StudentBean stu_b = manager.getStudent(id); 
   String stu_name = stu_b.getStu_name(); 
   int stu_id = stu_b.getStu_id();

   // 게시판 인스턴스 생성
   BoardDBBean db = BoardDBBean.getInstance(); 
   
   // 매개변수인 게시판종류, 글 번호를 이용하여 생성된 글 정보를 받아옴
   BoardBean board = db.getBoard(commindex, true); 

   String comm_title = "";
   String comm_content = "";
   String comm_writer = "";
   String comm_originalFileName = null;
   String comm_systemFileName = null;
   
   Timestamp comm_date;
   int comm_index = 0;
   int comm_groupn = 0;
   int comm_num = 0;
   int comm_hits = 0;
   int comm_stu_id = 0;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   // board 인스턴스가 null이 아니라면 정보를 가져와서 변수에 저장
   if (board != null) { 
      comm_index = board.getComm_index();
      comm_num = board.getComm_num();
      comm_title = board.getComm_title();
      comm_content = board.getComm_content();
      comm_hits = board.getComm_hits();
      comm_groupn = board.getComm_groupn();
      comm_writer = board.getComm_writer();
      comm_stu_id = board.getComm_stu_id();
      comm_date = board.getComm_date();
      if(board.getComm_originFileName() != null){
      	comm_originalFileName = board.getComm_originFileName();
      	comm_systemFileName = board.getComm_systemFileName();
      }
      
  	ArrayList<BoardBean> files = null;

  	if(board.getComm_originFileName() != null){
  		files = new ArrayList<BoardBean>();
  		StringTokenizer orgTokenizer = new StringTokenizer(board.getComm_originFileName(), ",");
  		StringTokenizer sysTokenizer = new StringTokenizer(board.getComm_systemFileName(), ",");
  	
  		while(orgTokenizer.hasMoreTokens()){
  			files.add(new BoardBean(orgTokenizer.nextToken(), sysTokenizer.nextToken()));	
  		}
  	}
   %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 조회</title>
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
            <li class="tab-link current" data-tab="tab-1">게시글 읽기</li>
         </ul>

         <div id="tab-1" class="tab-content current">
            <div class="table">
               <table class="table table-bordered" cellpadding="10" cellspacing="3" width="800" height="auto" align="center">
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
                     if (comm_groupn == 1 || comm_groupn == 4) {
                  %>
                  <tr>
                     <th class="menu">제목</th>
                     <td colspan="4"><%=comm_title%></td>

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

                  </tr>
                  <tr>
                     <th class="menu" colspan="6">본문</th>
                  </tr>
                  <tr>
                     <td colspan="6" align="left" height="300"><%=comm_content%></td>
                  </tr>
                  <%
                     if (comm_originalFileName != null) {
                  %>
                  <tr>

                     <th class="menu">첨부파일&nbsp;&nbsp;<img alt="다운로드 아이콘" src="../css/download_icon.png" height="22"></th>
                     <td colspan="3">
                       <%
                       String orgName = null;
                       String sysName = null;
                        String saveDirectory = "/upload/";
						for(int i=0; i<files.size(); i++){
							orgName = files.get(i).getComm_originFileName();
							sysName = files.get(i).getComm_systemFileName();
							out.println("<p>첨부파일 " + (i+1) + " : <a href='comm_File_Down.jsp?file_name="+sysName+"&orgName="+orgName+"'><font color='blue'>" + orgName +"</font></a></p>");
					%>
					<img src="<%=saveDirectory + files.get(i).getComm_systemFileName()%>" width="150" alt="">
						<%
						}
               			String path = saveDirectory + sysName;
               			System.out.println(path);
    					%>	
                       </td>
                  </tr>
                  <tr>
	
                  </tr>
                  <%
                     }
                  }
                  %>
               </table>
            </div>
            
            <%
               // 댓글(학사공지는 댓글 필요 없음)
               if (comm_groupn != 4) {
                  CommentDBBean cdb = CommentDBBean.getInstance(); // 댓글 인스턴스 생성
                  CommentBean comment = new CommentBean();
                  
                  // 게시판종류와 게시글 번호를 매개변수로 받아 조회한 댓글들을 commentList에 저장  
                  ArrayList<CommentBean> commentList = cdb.getListComment(comm_index);

                  String cmt_writer = "";
                  String cmt_content = "";
                  String cmt_date = "";
   
                  int cmt_comm_index = comm_index;
                  int cmt_index = 0;
                  int cmt_num = 0;
                  int cmt_stu_id = 0;
                  int cmt_level = 0;
                  int cmt_step = 0;
                  int cmt_ref = 1;
                  
   
            %>
            
            <!-- 댓글 입력 창 -->
            <div class="table">
               <table class="table table-bordered" cellpadding="10" cellspacing="5" width="800" height="auto" align="center">
                  <form action="comm_Comment_Ok.jsp?comm_index=<%=cmt_comm_index%>&cmt_content=<%=cmt_content%>">
                  	<input type="hidden" name="comm_index" value="<%=cmt_comm_index%>">
                  	<input type="hidden" name="cmt_index" value="<%=cmt_index%>">
                  	<input type="hidden" name="result" value="2">
                     <tr height="30"></tr>
                     <tr>
                        <td>
                           <h3 align="left"><img src="../css/comment_icon.png" height="40"> &nbsp;댓글작성</h3> 
                           <p align="left"> [작성자] : <%=stu_name %></p>
                           <textarea name="comment" cols="120" rows="4"></textarea>
                          <div class="mbutton">
                           <input type="submit" class="button" value="댓글입력"/> 
                           &nbsp;&nbsp; 
                           <input type="reset" class="button" value="초기화" />
                           </div>
                        </td>
                     </tr>
                  </form>
               </table>
            </div>
            
            <!-- 댓글 리스트 -->
            <div class="table">
               <table class="table table-bordered" cellpadding="10" cellspacing="5" width="800" height="auto">
                  <%
                     for (int i = 0; i < commentList.size(); i++) { // commnetList를 돌면서 값을 저장
                        comment = commentList.get(i);
                        cmt_index = comment.getCmt_index();
                        cmt_comm_index = comment.getCmt_comm_index();
                        cmt_num = comment.getCmt_num();
                        cmt_writer = comment.getCmt_writer();
                        cmt_content = comment.getCmt_content();
                        cmt_date = comment.getDate2();
                        cmt_stu_id = comment.getCmt_stu_id();
                        cmt_level = comment.getCmt_level();
                  %>
                  <tr class="off" onmouseover="this.className='on'" onmouseout="this.className='off'">
                     <td width="40" id="id" align="center"><%=cmt_num%></td>
                     <td width="60"><%=cmt_writer%></td>
                     <td width="540" align="left" >
                     <%
						// 답댓글일 경우
						if(cmt_level > 0) {
							for (int j = 0; j < cmt_level; j++) {
					%>
						&nbsp;&nbsp;&nbsp;
					<%
						}
					%>
						<img alt="답글이미지" src="../css/icon.gif" width="30" height="15">

					<%
					}
					%>
                     	<%=cmt_content%>
                     </td>

                     <!-- 학번 값 비교하여 댓글 작성자만 삭제버튼 보임 -->
                     <%
                        if (cmt_stu_id == stu_id) {
                     %>
                     <td width="120" align="center"><%=cmt_date%></td>
                     <td width="40" align="center">
                      <input type="button" class="button" value="답댓글" onclick="cmtReplyOpen(<%=cmt_comm_index%>,<%=cmt_index%>)"/><p>
                        <form method="post" action="comm_Comment_Delete_Ok.jsp?comm_index=<%=cmt_comm_index%>&cmt_index=<%=cmt_index%>">
                           <input type="submit" class="button" value="댓글삭제" />
                        </form>
                          
                     </td>
                     <%
                        } else {
                           // 댓글 작성자가 아닐경우 작성일만 출력
                     %>
                     <td width="120" align="center"><%=cmt_date%></td>
                     <td width="40" align="center">
                           <input type="button" class="button" value="답댓글" onclick="cmtReplyOpen(<%=cmt_comm_index%>,<%=cmt_index %>) "/>
                        </td>
                     <%
                        }
                     }
                     %>
                  </tr>
               </table>
               <%
                  } // 댓글 창 END (학사공지 조건절)
               %>
            </div>

            <!-- 수정 & 삭제 & 답글 & 목록 버튼 -->
            <div class="mbutton">
               <%
                  String forwardFile = "";
                  if(comm_groupn == 1){
                     forwardFile = "location.href='comm_Freeboard.jsp?pageNUMF=" + pageNUMF + "';";
                  }else if(comm_groupn == 2 || comm_groupn == 3){
                     forwardFile = "location.href='comm_Q_And_A.jsp?pageNUMQ=" + pageNUMQ + "';";                     
                  }else{
                     forwardFile = "location.href='../2/stu_Notice.jsp?pageNUMN=" + pageNUMN + "';";                     
                  }
               %>
            
            <%
            if (stu_id == comm_stu_id) {
            	if(pageNUMF != null){
            %>	
               <!-- 세션에서 받아온 학번과 작성자 학번의 값이 같으면 수정, 삭제 버튼이 보이도록 -->
               <input type="button" class="button" value="수정" onclick="location.href='comm_Modify.jsp?comm_index=<%=comm_index%>&comm_groupn=<%=comm_groupn%>&pageNUM=<%=pageNUMF %>';" /> 
            <%
            	}else if(pageNUMQ != null){ 
           %>
               <input type="button" class="button" value="수정" onclick="location.href='comm_Modify.jsp?comm_index=<%=comm_index%>&comm_groupn=<%=comm_groupn%>&pageNUM=<%=pageNUMQ %>';" /> 
            <%
            	}
       		%>
               &nbsp;&nbsp; 
               <input type="button" class="button" value="삭제" onclick="location.href='comm_Delete.jsp?comm_index=<%=comm_index%>';"/> 
               &nbsp;&nbsp; 
            <%}
            if(comm_groupn != 4){
            %>
               <input type="button" class="button" value="답글" onclick="location.href='comm_Write.jsp?comm_index=<%=comm_index%>&comm_num=<%=comm_num%>&comm_groupn=<%=comm_groupn%>';" />
               &nbsp;&nbsp; 
            <%}%>
               
               <input type="button" class="button" value="목록으로" onclick="<%=forwardFile%>" />
      
            </div>
            <!-- <div class="table"> END -->
         </div>
         <!-- <div id="tab-1" class="tab-content current"> END -->
      </div>
      <!-- <div class="container"> END -->
   </div>
   <!-- <div id="contents"> END -->
   
   <!-- footer -->
   <jsp:include page="../main/footer.jsp"></jsp:include>
</body>
<script>
	function cmtReplyOpen(cmt_comm_index, cmt_index){
		window.name = "comm_Show";
		window.open("comm_Comment_Reply_Form.jsp?comm_index=" + cmt_comm_index + "&cmt_index=" + cmt_index, "comm_reply", "width=550, height=400, resizable = no, scrollbars = no");
	};

</script>
<!-- 파일 다운로드를 위한 script -->
<%-- <script type="text/javascript">
   // 영문파일은 그냥 다운로드 클릭시 정상작동하지만 한글파일명을 쿼리문으로 날릴경우 인코딩 문제가 발생할 수 있다. 
   // 한글이 깨져 정상작동하지 않을 수 있음
   // 따라서, 쿼리문자열에 한글을 보낼 때는 항상 인코딩을 해서 보내주도록 함.
        
   document.getElementById("downA").addEventListener("click", function(event) {
      event.preventDefault();// a 태그의 기본 동작을 막음
        event.stopPropagation();// 이벤트의 전파를 막음
            
      // 인코딩된 파일이름을 쿼리문자열에 포함시켜 다운로드 페이지로 이동
      window.location.href = "comm_File_Down.jsp?file_name=" + '<%=sysName%>';
   });
</script> --%>
</html>
<!-- 글 수정 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="board.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="../3/script.js" charset="utf-8"></script>
<!-- 
  	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../resource/js/bootstrap.min.js"></script>
 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<!--   	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link href="../resource/css/bootstrap.min.css" rel="stylesheet">
<link href="../resource/css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../resource/js/bootstrap.min.js"></script> -->
</head>
<body>

	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>

	<%
	// 게시판 종류
	int comm_groupn = Integer.parseInt(request.getParameter("comm_groupn"));
	
	// 게시글 고유번호
	int comm_index = Integer.parseInt(request.getParameter("comm_index")); 
	
	String pageNUM = request.getParameter("pageNUM");
	
	// 게시판 인스턴스 생성
	BoardDBBean db = BoardDBBean.getInstance();

	// 글 수정은 조회수 올릴 필요 없기때문에 false 값
	BoardBean board = db.getBoard(comm_index, false); 
	%>

	<div id="contents">
		<div class="container">
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">게시글 수정</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<form action="comm_Modify_Ok.jsp?comm_index=<%=comm_index%>&comm_groupn=<%=comm_groupn%>&pageNUM=<%=pageNUM %>" method="post" name="form" enctype="multipart/form-data">
				<input type="hidden" name="existing_file" value="<%=board.getComm_originFileName()%>">
				<input type="hidden" name="existing_sys_file" value="<%=board.getComm_systemFileName()%>">
					<div class="table">
						<table class="table table-bordered" cellpadding="10" cellspacing="4" width="800" height="auto">
						
							<%
								if (comm_groupn == 1) {
									// 자유게시판에서 글 쓸 경우 select 박스 안보임
							%>

							<%
								} else if (comm_groupn == 2) {
							%>
							<tr>
								<td align="left">
										[학사 문의]
							<%
								}else if(comm_groupn == 3){
							%>
										[학적 문의]
							<%
								}
							%>
								</td>
							</tr>
							<tr>
								<td>
									<input type="text" size="150" name="comm_title" value="<%=board.getComm_title()%>" />
								</td>
							</tr>
							</table>
									<textarea id="summernote" name="comm_content"><%=board.getComm_content().replace("<br>", "\n")%></textarea>
								
							<%
								// 기존에 첨부한 파일이 있을 경우
								if(board.getComm_originFileName() != null){
							%>
									기존 파일 : <%=board.getComm_originFileName() %>
									&nbsp;&nbsp;&nbsp;&nbsp;<br>
									<p>[새 파일 추가 시, 기존 파일은 삭제됩니다.]</p>
									<input type="file" id="file" name="uploads" multiple/>							
							<%
								}else{
									// 기존에 첨부한 파일이 없을 경우
							%>
									<input type="file" id="file" name="uploads" multiple/>
							<%
								}
							%>
							
					</div>
						<div id="selectedFileListWrap" class="table">
	           			 <table id="selectedFileList" class="table table-bordered">
	           			</table>
					</div>

					<!-- 수정 & 초기화 & 목록으로 버튼 -->
					<p class="mbutton">
						<input type="button" class="button" value="수정" onclick="check_ok()" /> 
						&nbsp;&nbsp; 
						<input type="reset" class="button" value="초기화" />
						&nbsp;&nbsp; 
						<input type="button" class="button" value="이전으로" onClick="history.go(-1);"/>
					</p>
				</form>
				
			</div>
			<!-- <div id="tab-1" class="tab-content current"> END -->
		</div>
		<!-- <div class="container"> END -->
	</div>
	<!-- <div id="contents"> END -->
</body>
<script>
$("#selectedFileListWrap").hide();
$(document).ready(function(){
    $('input[type="file"]').change(function(e){
    	$("#selectedFileListWrap").show();
    	const input = document.querySelector('#file');
    	const selectedFiles = input.files;
		var cnt = 1;
		var Parent = document.getElementById("selectedFileList");
		while(Parent.hasChildNodes()){
			Parent.removeChild(Parent.firstChild);		
		}

    	for(const file of selectedFiles) {
    		var tableData = document.getElementById("selectedFileList");
    		var row = tableData.insertRow(tableData.rows.length);
    		var cell = row.insertCell(0);
        	cell.innerHTML = "첨부파일 " + cnt + " <input type='text' readonly value='"+file.name+"'>";
       		cnt++;
    	}
    });
});
</script>
<script>
$(document).ready(function() {
	  $('#summernote').summernote({
		  height: 500,
		  width: 1100,
	        disableResizeEditor: true,
	      
		 
	  });
	});
</script>
</html>
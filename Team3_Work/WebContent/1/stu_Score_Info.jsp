<!-- 학생정보 - 성적확인 -->
<%@page import="scoreclass.ScoreClassBean"%>
<%@page import="student.StudentBean"%>
<%@page import="student.StudentDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>성적 확인</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
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
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
	<%
		int id = (Integer) session.getAttribute("uid"); // 세션정보 받아와서 uid에 저장
	StudentDBBean student = StudentDBBean.getInstance();
	%>
	<section>
		<div id="contents">
			<div class="container">

				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">성적 확인</li>
				</ul>

				<div id="tab-1" class="tab-content current">

					<div>
						<select name="sc_year">
							<%
								/*이수년도별 성적 정보를 위해 년도를 가져옴*/
							ArrayList<Integer> year = student.getYear(id);
							for (int i = 0; i < year.size(); i++) {
								out.println("<option value='" + year.get(i) + "'>" + year.get(i) + "학년</option>");
							}
							%> 
						</select>
						 <select name="sc_semester" id="select">
							<option value="1">1학기</option>
							<option value="2">2학기</option>
						</select> <input type="button" id="test" class="button" value="조회"
							onclick="getScoreInfo(<%=id%>)">
					</div>
					<table width="900" align="center"
						style="margin: 20px; text-align: center" id="result">


					</table>
				</div>
			</div>
		</div>
	</section>
	<script>
		function getScoreInfo(id){
			var sc_year = $("select[name=sc_year]").val();
			var sc_semester = $("select[name=sc_semester]").val();
			 $.ajax({
		           type:"POST",
		           url:"score_search.jsp",
		           data : {"sc_id" : id, "sc_year":sc_year, "sc_semester":sc_semester},
		           success: function(result){
						//table id="result"에 결과값이 표시 됨
		        	   var tableData = document.getElementById("result");
		               tableData.innerHTML = result;
		           },
		           error: function(xhr, status, error) {
		               alert(error);
		           }  
		       });  
			
		}
</script>

	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
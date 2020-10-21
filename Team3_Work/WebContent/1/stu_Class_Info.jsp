<!-- 수강정보 - 시간표확인 / 출석확인 -->
<%@page import="timetable.TimeTableBean"%>
<%@page import="java.sql.Date"%>
<%@page import="attend.AttendBean"%>
<%@page import="attend.View2Bean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="student.StudentBean"%>
<%@page import="student.StudentDBBean"%>
<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강정보</title>
<link rel="stylesheet" href="../css/1_1.css" type="text/css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript" src="script.js"></script>

<style>
section {
	height: 80vh;
	display: block;
}

a:hover{
		text-decoration: none !important;
</style>

</head>
<body>
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
	<%
		int id = (Integer) session.getAttribute("uid"); // 세션정보 받아와서 uid에 저장
		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean stu_b = student.getStudent(id);	
	%>
	<section>
		<div id="contents">
			<div class="container">

				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1" onClick="show()" id="getTimetable"><a style="cursor: pointer;">나의 시간표</a></li>
					<li class="tab-link" data-tab="tab-2" id="getAttend"><a style="cursor: pointer;">나의 출석</a></li>
				</ul>
				<div id="tab-1" class="tab-content current">
					<div class="timetable" id="result">
	
				</div>
			</div>
			</div>
		</div>
	</section>
<script>
$('#getTimetable').trigger("click");

function show(){ //나의 시간표 탭 눌렀을 때
    $.ajax({
        type:"POST",
        url:"stu_TimeTable_Tab1.jsp",
      	//session id 값 보내기
        data : {id : <%=id%>},   
        success: function(result){
            var tableData = document.getElementById("result");
            //id="result"에 시간표 정보 받아와서 넣기
           	tableData.innerHTML = result; 
        },
        error: function(xhr, status, error) {
            alert(error);
        }  
    });
};
//나의 출석 탭 눌렀을 때
$("#getAttend").click(function(){
    $.ajax({
        type:"POST",
        url:"stu_Attend_Tab2.jsp",
        data : {id : <%=id%>},
        success: function(result){
            var tableData = document.getElementById("result");
           	tableData.innerHTML = result;
        },
        error: function(xhr, status, error) {
            alert(error);
        }  
    });
});

/* ================나의 출석 탭에서 수강정보와 해당 수강과목에 관한 출결정보를 확인하는 코드  ================*/
function getClassInfo(id){ //stu_Attend_Tab2.jsp에서 조회버튼 클릭시 메소드
	var grade = $("select[name=sc_grade]").val();
	var semester = $("select[name=sc_semester]").val();

	 $.ajax({
	        type:"POST",
	        url:"class_search.jsp",
	        data : {"id" : id, "grade" : grade, "semester" : semester},
	        success: function(result){
	        	//tab2파일 id="resultClass" 밑에 class_search.jsp정보 넣기
	            var tableData = document.getElementById("resultClass");
	           	tableData.innerHTML = result;
	           	
	           	//다른학기 조회하려고 조회 버튼 다시 누르면 이전 출결조회 사라짐
	           	var resetAtd = document.getElementById("resultAttend");
	           	resetAtd.innerHTML = "";
	        },
	        error: function(xhr, status, error) {
	            alert(error);
	        }  
	    });
	 
}

//class_search.jsp에서 해당 과목 클릭했을 때 메소드
function attend(stu_id, subj_code){ 
	var grade2 = $("select[name=sc_grade]").val();
	var semester2 = $("select[name=sc_semester]").val();

	 $.ajax({
	        type:"POST",
	        url:"attend_search.jsp",
	        data : {"id" : stu_id, "grade" : grade2, "semester" : semester2, "code" : subj_code},
	        success: function(result){
	        	//tab2파일 id="resultClass" 밑에 attend_search.jsp정보 넣기
	            var tableData = document.getElementById("resultAttend");
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
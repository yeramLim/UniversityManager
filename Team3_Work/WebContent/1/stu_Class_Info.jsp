<!-- �������� - �ð�ǥȮ�� / �⼮Ȯ�� -->
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
<title>��������</title>
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
		int id = (Integer) session.getAttribute("uid"); // �������� �޾ƿͼ� uid�� ����
		StudentDBBean student = StudentDBBean.getInstance();
		StudentBean stu_b = student.getStudent(id);	
	%>
	<section>
		<div id="contents">
			<div class="container">

				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1" onClick="show()" id="getTimetable"><a style="cursor: pointer;">���� �ð�ǥ</a></li>
					<li class="tab-link" data-tab="tab-2" id="getAttend"><a style="cursor: pointer;">���� �⼮</a></li>
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

function show(){ //���� �ð�ǥ �� ������ ��
    $.ajax({
        type:"POST",
        url:"stu_TimeTable_Tab1.jsp",
      	//session id �� ������
        data : {id : <%=id%>},   
        success: function(result){
            var tableData = document.getElementById("result");
            //id="result"�� �ð�ǥ ���� �޾ƿͼ� �ֱ�
           	tableData.innerHTML = result; 
        },
        error: function(xhr, status, error) {
            alert(error);
        }  
    });
};
//���� �⼮ �� ������ ��
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

/* ================���� �⼮ �ǿ��� ���������� �ش� �������� ���� ��������� Ȯ���ϴ� �ڵ�  ================*/
function getClassInfo(id){ //stu_Attend_Tab2.jsp���� ��ȸ��ư Ŭ���� �޼ҵ�
	var grade = $("select[name=sc_grade]").val();
	var semester = $("select[name=sc_semester]").val();

	 $.ajax({
	        type:"POST",
	        url:"class_search.jsp",
	        data : {"id" : id, "grade" : grade, "semester" : semester},
	        success: function(result){
	        	//tab2���� id="resultClass" �ؿ� class_search.jsp���� �ֱ�
	            var tableData = document.getElementById("resultClass");
	           	tableData.innerHTML = result;
	           	
	           	//�ٸ��б� ��ȸ�Ϸ��� ��ȸ ��ư �ٽ� ������ ���� �����ȸ �����
	           	var resetAtd = document.getElementById("resultAttend");
	           	resetAtd.innerHTML = "";
	        },
	        error: function(xhr, status, error) {
	            alert(error);
	        }  
	    });
	 
}

//class_search.jsp���� �ش� ���� Ŭ������ �� �޼ҵ�
function attend(stu_id, subj_code){ 
	var grade2 = $("select[name=sc_grade]").val();
	var semester2 = $("select[name=sc_semester]").val();

	 $.ajax({
	        type:"POST",
	        url:"attend_search.jsp",
	        data : {"id" : stu_id, "grade" : grade2, "semester" : semester2, "code" : subj_code},
	        success: function(result){
	        	//tab2���� id="resultClass" �ؿ� attend_search.jsp���� �ֱ�
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
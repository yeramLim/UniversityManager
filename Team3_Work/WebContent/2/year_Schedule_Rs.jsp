<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Univ_Scheduel</title>
<link rel="stylesheet" href="../css/schedule.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<style>
	.pdate1{
		color:#9f2c00;
	}
	
	
 	a:hover{
		text-decoration: none !important;
	} 
</style>
</head>
<body>
	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>
	
    <div id="doc-wrap">
      <article id="container-wrap">
   
        <div id="container">
          <div id="contents" class="div-cont">
            <div id="cont" class="pg-">
            <% int year = Calendar.getInstance().get(Calendar.YEAR);%>            
              <div class="c-tit01"><span id="year"></span>�г⵵ �л�����</div>
              �� �л������� ������ ������ �л������ �Ǵ� �Խ������� �����Ͻñ�
              �ٶ��ϴ�.
              <br />
              <div class="pad20tf c">
                <a class="sg-btn" style="cursor: pointer;" alt="�۳�" onclick="year(2019)">
                  <span>�� 2019�г⵵</span>
                </a>
                <a class="sg-btn" alt="����" onclick="year(2020)" id="currentYear">
                  <span> ���� 2020�г⵵</span>
                </a>
                <a class="sg-btn" style="cursor: pointer;" alt="����" onclick="year(2021)">
                  <span>2021�г⵵��</span>
                </a>
              </div>
        
              <table class="haksa-schedule-tb1" id="result">
              
             
              </table>
            </div>
            <!--pg- END-->
          </div>
          <!--div-cont END-->
        </div>
        <!--container END-->
      </article>
      <!-- -=============== container-wrap END-=============== -->
    </div>
    <!-- -=============== doc-wrap END-=============== -->
 
  </body>
  
  <script>
  var links = $(".sg-btn"); //Ŭ���� �⵵��  ��������
  links.click(function() {
       links.css('background-color', '#f0f0f0');
       links.css('color', '#666666');
       $(this).css('background-color', '#12264f');
       $(this).css('color', '#f0f0f0');
  }); 
//�������ε�� Ŭ���� ȿ���� ��
  $("#currentYear").trigger("click");
  
  function year(num){		
	 	document.getElementById('year').innerHTML = num;
	  $.ajax({
           type:"POST",
           url:"year_Schedule.jsp",
           data : {year : num},//getParameter�� ���� �� �̸�year�� �Ű����� �� num
           success: function(xml){
				//table id="result"�� ������� ǥ�� ��
        	   var tableData = document.getElementById("result");
               tableData.innerHTML = xml;
           },
           error: function(xhr, status, error) {
               alert(error);
           }  
       });  
  }
 
  </script>
  <jsp:include page="../main/footer.jsp"></jsp:include>
</html>
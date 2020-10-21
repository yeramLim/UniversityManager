<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="student.*"%>

<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>BIT</title>

<link rel="shortcut icon" href="../css/mainImg.jpg">
<link rel="stylesheet" type="text/css" href="../css/login.css" />
<script language="JavaScript" src="login_sc.js" charset="utf-8"></script>
</head>
<body>
	<div class="container-fluid conya">
		<div class="side-left">
			
		</div>
		<div class="side-right">
			<h1 style="margin-bottom:30px;">BIT 전문학교</h1>
			<form method="post" name="login_frm" action="loginOk.jsp">
				<div>
					<label class="box-radio-input"><input type="radio" name="class" value="s" checked><span>학 생</span>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label class="box-radio-input"><input type="radio" name="class" value="p"><span>교 직 원</span></label>
				</div>
	
				<div class="form-row">
					<label for="">ID</label> <input name="user_id" type="text"
						placeholder="ID"
						class="form-control form-control-sm">
				</div>
	
				<div class="form-row">
					<label for="">Password</label> <input name="user_pwd" type="password"
						placeholder="Password" class="form-control form-control-sm">
				</div>
	
				<div class="form-row row skjh">
					<div class="col-7 left no-padding">
						
					</div>
					<div class="col-5">
						<span> <a href="" onClick="find_id_pwd(2)">&nbsp;&nbsp; 비밀번호 찾기</a></span>
						<span> <a href="" onClick="find_id_pwd(1)">아이디 &nbsp;&nbsp;/</a></span>
					</div>
				</div>
				<div class="form-row dfr">
					<input type="button" class="btn btn-sm btn-success" value="로그인" onClick="check_ok()"/>
					<!-- <button class="btn btn-sm btn-success" onClick="check_ok()">로그인</button> -->
				</div>
				<div class="ord-v">
					<a href="or login with"></a>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
function find_id_pwd(num){
		 var popupWidth = 500;
		 var popupHeight = 220;
		 var popupX = (window.screen.width/2)-(popupWidth/2);
		 var popupY= (window.screen.height/2)-(popupHeight/2);
		 var options = 'top='+popupY+', left='+popupX+', width='+popupWidth+', height='+popupHeight+', status=no, menubar=no, toolbar=no, resizable=no';
		 if(num == 1){
			 window.open('find_id_pwd.jsp?no=1', '아이디 찾기', options);
		 }else{
			 window.open('find_id_pwd.jsp?no=2', '비밀번호 찾기', options);
		 }
	  }
</script>
</html>

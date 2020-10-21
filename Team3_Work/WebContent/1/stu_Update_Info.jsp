<!-- 기본정보 수정 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="student.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>기본 정보 수정</title>
<style>
.blank {
	height: 50px;
}
</style>
<link rel="stylesheet" href="../css/1_1.css" type="text/css" />
<script type="text/javascript" src="stu_update_check.js" charset="utf-8"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script> <!-- 우편검색 api -->
<script src="find_addr_check.js"></script> <!-- 우편 검색시 js파일로 이동 -->
</head>
<body>
	<%
		int id = (Integer) session.getAttribute("uid");
	StudentDBBean student = new StudentDBBean();
	StudentBean stu_b = student.getStudent(id);
	
	%>


	<jsp:include page="../main/menu.jsp"></jsp:include>
	<jsp:include page="../main/sidemenu.jsp"></jsp:include>

	<div id="contents">
		<div class="container">

			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">학적 정보</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<!-- 파일 업로드를 위해 enctype씀  -->
						<form method="post" action="stu_Update_Ok.jsp" name="stu_frm" enctype="multipart/form-data">
							<tr>
								<td rowspan="5">
								<!--  src: 기본 저장된 이미지 불러오기-->
								  <img id="preimg" src="../main/read_image.jsp?group=2&id=<%=id%>" width="150"  height="158"/> 
								</td>			
								<td align="center" class="menu">성명</td>
								<td><%=stu_b.getStu_name()%></td>
								<td align="center" class="menu">영문 성명</td>
								<td><%=stu_b.getStu_eng_name()%></td>
							</tr>

							<tr>
								<td align="center" class="menu">생년월일</td>
								<td colspan="3">
								<!--주민등록번호를 이용해 년월일 추출하기 위해서 substring 사용  -->
									<%=stu_b.getStu_jumin().substring(0, 2)%>년
									<%=stu_b.getStu_jumin().substring(2, 4)%>월 
									<%=stu_b.getStu_jumin().substring(4, 6)%>일
								</td>
							</tr>

							<tr>
								<td align="center" class="menu">학번</td>
								<td><%=stu_b.getStu_id()%></td>
								<td align="center" class="menu">학적구분</td>
								<td>
									<%
										int state = stu_b.getStu_state();

									if (state == 1) {
										out.print("재학");
									} else if (state == 2) {
										out.print("졸업");
									} else if (state == 3) {
										out.print("휴학");
									} else {
										out.print("자퇴");
									}
									%>
								</td>
							</tr>

							<tr>
								<td align="center" class="menu">소속학부</td>
								<td>상경대</td>
								<td align="center" class="menu">소속학과</td>
								<td><%=stu_b.getStu_major()%></td>
							</tr>

							<tr>
								<td align="center" class="menu">학년</td>
								<td><%=stu_b.getStu_grade()%></td>
								<td align="center" class="menu">지도교수</td>
								<td>
									<%=stu_b.getPro_name()%>
								</td>
							</tr>

							<tr>
													
									<td align="center" class="menu">사진 수정</td>
									<td colspan="4">
										<!-- onchange를 써서 js를 이용해 업로드전 사진 미리보기위함-->
										<input type="file" name="stu_img" onchange="readURL(this);">
									</td>
							</tr>
					</table>
				</div>
		<div class="blank"></div>

			<!-- 수정 가능한 항목들 -->
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">기본 정보</li>
			</ul>

			<div id="tab-1" class="tab-content current">
				<div class="table">
					<table cellpadding="10" cellspacing="3" width="800" height="auto"
						align="center">
						<tr>
							<!--name을 update_ok에 던져서 studentBean에 set으로 값 저장, DBBean에서 get으로 비밀번호받아서 set으로 db에 저장  -->
							<td align="center" class="menu">변경 비밀번호</td>
							<td><input type="password" size="15" name="stu_pwd"></td>
							<td align="center" class="menu">변경 비밀번호 확인</td>
							<td><input type="password" size="15" name="pwd_check"></td>
						</tr>
						<tr>
							<td align="center" class="menu">연락처</td>
							<td><input type="text" size="3" name="stu_tel"
								value="<%=stu_b.getStu_tel().substring(0, 3)%>">-
								
								 <input type="text" size="4" name="num2"
								value="<%=stu_b.getStu_tel().substring(3, 7)%>">- 
								
								<input type="text" size="4" name="num3"
								value="<%=stu_b.getStu_tel().substring(7, 11)%>">
							</td>
								
							<td align="center" class="menu">비상연락망</td>
							<td><%=stu_b.getStu_emg_tel().substring(0, 3)%>- <%=stu_b.getStu_emg_tel().substring(3, 7)%>-
								<%=stu_b.getStu_emg_tel().substring(7, 11)%></td>
						</tr>
					
						<tr>
							<td align="center" class="menu">주소</td>
							<td colspan="3">
								<input type="text" size="50" id="stu_addr" name="stu_addr" value="<%=stu_b.getStu_addr()%>">
							 	<input type="button" value="우편번호  검색" onClick="execPostCode()">
							 	<input type="text" name="detailAddr" id="detailAddr" placeholder="상세주소" value="">
							</td>							
						</tr>

						<tr>
							<td align="center" class="menu">E-mail</td>
							<td colspan="3" align="center">
								<%
									// index로 @의 위치참조 
									int idx = stu_b.getStu_email().indexOf("@");
									String selected = stu_b.getStu_email().substring(idx+1);
								%> 
								<input type="text" size="20" name="stu_email" value="<%=stu_b.getStu_email().substring(0, idx)%>"> @
								 <!--get으로 email값 가져와서 첫번째 숫자부터 @위치-1값에 해당 데이터 추출-->
								<select name="mail2" id="mail2">
									<option selected><%=selected%></option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.com">daum.com</option>
									<option value="nate.com">nate.com</option>
							</select>
							</td>
						</tr>
						</form>
					</table>
				</div>
			</div>
			
				<div class="mbutton">
					<input type="button" class="button" value="수정하기" onClick="update_check_ok()"> &nbsp;&nbsp;
						<input type="button" class="button" value="수정취소" onclick="javascript:history.back(-1)">
						
				</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//사진이 onChange 됐을 때
	function readURL(img) {
//img가 있으면 파일을 읽어옴 img.files[0]은 파일이 여러개일 때 첫번째 파일을 읽어옴
	if (img.files && img.files[0]) {
	var reader = new FileReader();
	reader.onload = function (e) {
//기본정보의 #preimg에 src를 만들어줌
	$('#preimg').attr('src', e.target.result);
	}
	reader.readAsDataURL(img.files[0]);
	}
	}
</script>
	<jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>
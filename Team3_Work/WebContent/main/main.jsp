<%@page import="java.sql.Timestamp"%>
<%@page import="board.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>

<!-- <link rel="stylesheet" href="../css/notice_sty.css" type="text/css"/> -->
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
	<jsp:include page="menu.jsp"></jsp:include>
	<jsp:include page="sidemenu.jsp"></jsp:include>
	<jsp:include page="notice.jsp"></jsp:include>
	
	<footer>
		<jsp:include page="../main/footer.jsp"></jsp:include>
	</footer>

</body>
</html>





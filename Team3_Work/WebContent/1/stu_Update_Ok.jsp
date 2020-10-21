<%@page import="student.StudentBean"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="student.StudentDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="stu" class="student.StudentBean"></jsp:useBean>
<jsp:setProperty property="*" name="stu"/>

<%
	int id =(Integer)session.getAttribute("uid");
	stu.setStu_id(id);
	int size = 1024*1024*10; //저장 가능한 파일 크기
	
	//upload폴더 자동 생성 코드
	 File Folder = new File("C:\\upload");
    if (!Folder.exists()) { //폴더가 존재하지 않으면
      try{
          Folder.mkdir(); //폴더 생성합니다.
       } catch(Exception e){
          e.getStackTrace();
       }
   	}
   
   //자동생성된 폴더의 경로를 path변수에 넣음
	String path = Folder.getPath();
	String encoding = "euc-kr";
	
	MultipartRequest multi = new MultipartRequest(request, path, size, encoding, new DefaultFileRenamePolicy());
	
	String pwd = multi.getParameter(("stu_pwd"));
	String tel = multi.getParameter(("stu_tel"));
	String num2 = multi.getParameter(("num2"));
	String num3 = multi.getParameter(("num3"));
	String addr = multi.getParameter(("stu_addr"));
	String detailAddr = multi.getParameter(("detailAddr"));
	String email = multi.getParameter(("stu_email"));
	String mail2 = multi.getParameter(("mail2"));
	
	
	StudentBean sb = new StudentBean(id, pwd, tel, num2, num3, addr,detailAddr,email,mail2);
	
/* 이미지 처리 부분 */	
	Enumeration files = multi.getFileNames();
	String name1 = (String)files.nextElement();
	String name = multi.getFilesystemName(name1);
	File file = null;
	FileInputStream fis = null;
	
	if(name != null){
		file = new File(path + "/" + name);
		fis = new FileInputStream(file);
	}
	StudentDBBean student = StudentDBBean.getInstance();
	int re = student.updateStudent(sb, file, fis);
	
	
	if(re!=-1){
%>
	<script>
		alert("정보가 수정되었습니다.")
		document.location.href="stu_Basic_Info.jsp";
	</script>
<%
	}else{
%>
	<script>
		alert("수정할 수 없습니다.")
		history.go(-1);
	</script>
<%
	}
%>
<!-- ���� �ٿ�ε� -->
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="myUtil.HanConv"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
	<%
		String filename = HanConv.toKor(request.getParameter("file_name"));
		String orgname = HanConv.toKor(request.getParameter("orgName"));
		
		String saveDirectory = "C:/upload/";
		String path = saveDirectory + File.separator + filename;
		
		System.out.println(path);
		
		File file = new File(path);
		long length = file.length();
		
		response.setContentType("application/octet-stream");
		
		response.setContentLength((int)length);
		
		boolean isIe = request.getHeader("user-agent").toUpperCase().indexOf("MSIE") != -1 ||
					   request.getHeader("user-agent").indexOf("11.0") != -1;
		if(isIe){ // ���ͳ� �ͽ��÷η�
			orgname = URLEncoder.encode(orgname,"UTF-8");
		}
		else{ 
			orgname = new String(orgname.getBytes("UTF-8"), "8859_1");
		}
		response.setHeader("Content-Disposition", "attachment;filename=" + orgname);
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			
		out.clear();
		out = pageContext.pushBody();
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		int data;
		while((data=bis.read()) != -1){
			bos.write(data);
			bos.flush();
		}
		
		//8] ��Ʈ�� �ݱ�
		bis.close();
		bos.close();
%>
<%-- <%
	// a�±��� href��  comm_File_Down.jsp?file_name="<%=fileName1 �� ���� 
	// ������ �ߺ� ���� ó���� ���ϸ� ���� ������
	String fileName = request.getParameter("file_name");
	
	System.out.println(fileName);

	// ���ε��� ������ ��ġ�� ���ε� ������ �̸��� �˾ƾ� ��
	String savePath = "upload";
	// ���� ������ �����, ������ ������ ��¥ ��θ� ���ؿ;� ��
	String sDownPath = request.getRealPath(savePath);
	
	System.out.println("�ٿ�ε� ���� ���� ��� ��ġ >> " + sDownPath);
	System.out.println("fileName1 >> " + fileName);
	
	// ����Ǿ� �ִ� ������� /��������ϸ� ���� Ǯ path �� �������
	// �ڹٿ����� \�� ǥ���ϱ� ���ؼ��� \�� �ѹ� �� �ٿ��ֱ� ������ \\�� ����
	String sFilePath = sDownPath + "\\" + fileName; // ex)c:\\uploat\\image.jpg
	System.out.println("sFilePath >> " + sFilePath);
	
	// Ǯ path�� ���� �� ���� ��ü�� �νĽ�Ŵ
	File outputFile = new File(sFilePath);
	// ����� ������ �ϰϿ� ������ ���۸� �ӽ÷� ����� ������ �뷮�� ������ �ѹ��� ���ε� �� �� �ִ� ���� ũ��� ����
	byte[] temp = new byte[1024*1024*10]; // 10M
	
	// ������ �о�;� ������ inputStream�� ����
	// (Ǯ �н��� ������ ���� ��ü�� �̿��� inputStream�� ����)
	FileInputStream in = new FileInputStream(outputFile);
	
	// ���� Ȯ�� : �о�� ����� ������ ���� -> ������ ������ �� Ÿ���� ����
	String sMimeType = getServletContext().getMimeType(sFilePath);
	
	System.out.println("���� >> " + sMimeType);
	
	// �������� ���� ���� ����ó��
	if(sMimeType == null){
		// �������� ǥ��
		sMimeType = "application.octec-stream"; // �Ϸõ� 8bit ��Ʈ�� ����
		// ������ �˷����� ���� ���Ͽ� ���� �б� ���� ����
	}
	
	// ���� �ٿ�ε� ����
	// ������ ������ �ش�
	response.setContentType(sMimeType); 
	// ������ �������� text/html; charset=utf-8�� ���� mime Ÿ������ ����
			
	// ���ε� ������ ������ ���� �� �����Ƿ� ���ڵ�
	String sEncoding = new String(fileName.getBytes("euc-kr"), "8859_1");
	// String B = "utf-8";
	// String sEncoding = URLEncoder.encode(A,B);
	
	// ��Ÿ ������ ����� �÷�����
	// ��Ÿ ������ ���� ���������� �ٿ�ε�� ȭ�鿡 ��½��� ��
	String AA = "Content-Disposition";
	String BB = "attachment;filename=" + sEncoding;
	response.setHeader(AA, BB);
	
	// �������� ����
	ServletOutputStream out2 = response.getOutputStream();
	
	int numRead = 0;
	
	// ����Ʈ �迭 temp�� 0��° ���� numRead ������ �������� ���
	// ������ ��ġ�� ���� ����� inputStream���� �е�, ��(-1) ������ while�� ��
	while((numRead = in.read(temp, 0, temp.length)) != -1){
		// temp �迭�� �о���µ� 0��° �ε������� �ѹ��� �ִ� temp.length��ŭ �о��
		// �о�ð� ���̻� ������ -1�� �����ϸ鼭 while���� ��������
		
		// �������� ��� : header������ attachment�� �� �������Ƿ� �ٿ�ε尡 ��
		out2.write(temp, 0, numRead);
		// temp�迭�� �ִ� �������� 0��°���� �ִ� numRead��ŭ ���
	}
	
	// �ڿ� ����
	out2.flush();
	out2.close();
	in.close();
%> --%>

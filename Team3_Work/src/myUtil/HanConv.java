package myUtil;

import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;

public class HanConv {
	public static String toKor(String str) {
		// utf-8(�������ڵ�) -> utf-16(�ѱ����ڵ�) html���� �Ѿ���� �ѱ��� ���� ��
		if(str == null || str.contentEquals("") || str.equals("null")) {
			return str;
		}
		try {
			return new String(str.getBytes("8859_1"), "euc-kr"); //8859_1(����)
		}catch(Exception e) {
			e.printStackTrace(); // ���� ������ �ѱ۵� ��������
			return str;
		}
	}



	public static String toKorTwo(String str) {
		// utf-8(�������ڵ�) -> utf-16(�ѱ����ڵ�) html���� �Ѿ���� �ѱ��� ���� ��
		if(str == null || str.contentEquals("") || str.equals("null")) {
			return str;
		}
		try {
			String result=null;
			result=URLEncoder.encode(str, "euc-kr"); // ���ڿ� �޾Ƽ� �ٷ� �ѱ۷� �ٲ�
			return result;
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace(); // ���� ������ �ѱ۵� ��������
			return str;
		}
	}
}
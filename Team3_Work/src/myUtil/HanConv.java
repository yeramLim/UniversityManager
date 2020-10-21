package myUtil;

import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;

public class HanConv {
	public static String toKor(String str) {
		// utf-8(영문인코딩) -> utf-16(한글인코딩) html에서 넘어오는 한글이 깨질 때
		if(str == null || str.contentEquals("") || str.equals("null")) {
			return str;
		}
		try {
			return new String(str.getBytes("8859_1"), "euc-kr"); //8859_1(영문)
		}catch(Exception e) {
			e.printStackTrace(); // 변경 실패한 한글도 돌려주자
			return str;
		}
	}



	public static String toKorTwo(String str) {
		// utf-8(영문인코딩) -> utf-16(한글인코딩) html에서 넘어오는 한글이 깨질 때
		if(str == null || str.contentEquals("") || str.equals("null")) {
			return str;
		}
		try {
			String result=null;
			result=URLEncoder.encode(str, "euc-kr"); // 문자열 받아서 바로 한글로 바꿈
			return result;
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace(); // 변경 실패한 한글도 돌려주자
			return str;
		}
	}
}
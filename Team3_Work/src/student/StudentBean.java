package student;

import java.sql.Blob;

public class StudentBean {
	
	private int stu_id; 
	private String stu_name; 
	private String stu_eng_name; 
	private String stu_pwd; 
	private String stu_jumin;
	
	//학적상태(1: 재학/ 2: 졸업/ 3: 휴학/ 4: 자퇴)
	private int stu_state; 
	private int stu_major; 
	private int stu_grade; 
	
	//학생 담당교수님 코드
	private int stu_pro; 
	// 학생의 학부
	private String dept_name;
	// 학생의 학과
	private String dept_majorname;
	
	private String stu_tel; 
	private String stu_emg_tel; 
	private String stu_addr; 
	private String stu_email;
	//수정을 위한 변수(@*.com)
	private String mail2;
	private Blob stu_img;
	
	//수정을 위한 변수(핸드폰 중간번호)
	private String num2;
	//수정을 위한 변수(핸드폰 끝번호)
	private String num3;
	
	private String detailAddr;
	// 학생 담당교수님 성명
	private String pro_name;
	
	public StudentBean() {
		
	}
	//multipart로 전달시 request.getparameter가 안돼서 null값이 들어가기 때문에 multi로 받은 값을 student객체에 넣음
	public StudentBean(int id, String pwd, String tel,String num2,String num3, 
						String addr, String detailAddr, String email,String mail2){
		this.stu_id = id;
		this.stu_pwd = pwd;
		this.stu_tel = tel;
		this.num2 = num2;
		this.num3 = num3;
		this.stu_addr = addr;
		this.detailAddr = detailAddr;
		this.stu_email = email;
		this.mail2 = mail2;
	}
	
	
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getDept_majorname() {
		return dept_majorname;
	}
	public void setDept_majorname(String dept_majorname) {
		this.dept_majorname = dept_majorname;
	}
	
	public String getDetailAddr() {
		return detailAddr;
	}

	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}

	public Blob getStu_img() {
		return stu_img;
	}



	public void setStu_img(Blob stu_img) {
		this.stu_img = stu_img;
	}



	public String getPro_name() {
		return pro_name;
	}


	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}


	public String getNum2() {
		return num2;
	}

	public void setNum2(String num2) {
		this.num2 = num2;
	}

	public String getNum3() {
		return num3;
	}

	public void setNum3(String num3) {
		this.num3 = num3;
	}

	public String getMail2() {
		return mail2;
	}

	public void setMail2(String mail2) {
		this.mail2 = mail2;
	}

	public int getStu_id() {
		return stu_id;
	}
	public void setStu_id(int stu_id) {
		this.stu_id = stu_id;
	}
	public String getStu_name() {
		return stu_name;
	}
	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}
	public String getStu_eng_name() {
		return stu_eng_name;
	}
	public void setStu_eng_name(String stu_eng_name) {
		this.stu_eng_name = stu_eng_name;
	}
	public String getStu_pwd() {
		return stu_pwd;
	}
	public void setStu_pwd(String stu_pwd) {
		this.stu_pwd = stu_pwd;
	}
	
	public String getStu_jumin() {
		return stu_jumin;
	}
	public void setStu_jumin(String stu_jumin) {
		this.stu_jumin = stu_jumin;
	}
	public int getStu_state() {
		return stu_state;
	}
	public void setStu_state(int stu_state) {
		this.stu_state = stu_state;
	}

	public int getStu_major() {
		return stu_major;
	}

	public void setStu_major(int stu_major) {
		this.stu_major = stu_major;
	}

	public int getStu_grade() {
		return stu_grade;
	}
	public void setStu_grade(int stu_grade) {
		this.stu_grade = stu_grade;
	}
	public int getStu_pro() {
		return stu_pro;
	}
	public void setStu_pro(int stu_pro) {
		this.stu_pro = stu_pro;
	}
	public String getStu_tel() {
		return stu_tel;
	}
	public void setStu_tel(String stu_tel) {
		this.stu_tel = stu_tel;
	}
	public String getStu_emg_tel() {
		return stu_emg_tel;
	}
	public void setStu_emg_tel(String stu_emg_tel) {
		this.stu_emg_tel = stu_emg_tel;
	}
	public String getStu_addr() {
		return stu_addr;
	}
	public void setStu_addr(String stu_addr) {
		this.stu_addr = stu_addr;
	}
	public String getStu_email() {
		return stu_email;
	}
	public void setStu_email(String stu_email) {
		this.stu_email = stu_email;
	}

		

}

package scoreclass;

import subject.SubjectBean;

public class ScoreClassBean {
	private int sc_subj_code; //과목코드
	private int sc_stu_id;
	private int sc_pro_id;
	private int sc_year;
	private int sc_grade;
	private int sc_semester;
	
	private int subj_hakjum;
	private double sc_score; 
	private String sc_retake; //재수강여부
	private String sc_score2;
	private String subj_state; 
	private String subj_name;
	 
	
	
	public int getSubj_hakjum() {
		return subj_hakjum;
	}
	public void setSubj_hakjum(int subj_hakjum) {
		this.subj_hakjum = subj_hakjum;
	}
	public String getSubj_state() {
		return subj_state;
	}
	public void setSubj_state(String subj_state) {
		this.subj_state = subj_state;
	}
	public String getSubj_name() {
		return subj_name;
	}
	public void setSubj_name(String subj_name) {
		this.subj_name = subj_name;
	}
	public String getSc_score2() {
		return sc_score2;
	}
	public void setSc_score2(String sc_score2) {
		this.sc_score2 = sc_score2;
	}
	public int getSc_subj_code() {
		return sc_subj_code;
	}
	public void setSc_subj_code(int sc_subj_code) {
		this.sc_subj_code = sc_subj_code;
	}
	public int getSc_stu_id() {
		return sc_stu_id;
	}
	public void setSc_stu_id(int sc_stu_id) {
		this.sc_stu_id = sc_stu_id;
	}
	public int getSc_pro_id() {
		return sc_pro_id;
	}
	public void setSc_pro_id(int sc_pro_id) {
		this.sc_pro_id = sc_pro_id;
	}
	public int getSc_year() {
		return sc_year;
	}
	public void setSc_year(int sc_year) {
		this.sc_year = sc_year;
	}
	public int getSc_grade() {
		return sc_grade;
	}
	public void setSc_grade(int sc_grade) {
		this.sc_grade = sc_grade;
	}
	public int getSc_semester() {
		return sc_semester;
	}
	public void setSc_semester(int sc_semester) {
		this.sc_semester = sc_semester;
	}
	
	public double getSc_score() {
		return sc_score;
	}
	public void setSc_score(double sc_score) {
		this.sc_score = sc_score;
	}
	public String getSc_retake() {
		return sc_retake;
	}
	public void setSc_retake(String sc_retake) {
		this.sc_retake = sc_retake;
	}
	
	
}

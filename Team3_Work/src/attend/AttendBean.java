package attend;

import java.sql.Date;

public class AttendBean {
	private int atd_subj_code;
	private int atd_stu_id;
	private int atd_pro_id;
	private int atd_year;
	private int atd_grade; 
	private int atd_semester; 
	private Date atd_date; 
	//출석상태(출석,결석 등)
	private String atd_state; 
	//출결 비고사항
	private String atd_remark; 
	
	public AttendBean(Date atd_date, String atd_state, String atd_remark) {
		this.atd_date = atd_date;
		this.atd_state = atd_state;
		this.atd_remark = atd_remark;
	}
	
	public AttendBean(int atd_subj_code, int atd_stu_id, int atd_pro_id, int atd_year, int atd_grade, int atd_semester,
			Date atd_date, String atd_state, String atd_remark) {
		this.atd_subj_code = atd_subj_code;
		this.atd_stu_id = atd_stu_id;
		this.atd_pro_id = atd_pro_id;
		this.atd_year = atd_year;
		this.atd_grade = atd_grade;
		this.atd_semester = atd_semester;
		this.atd_date = atd_date;
		this.atd_state = atd_state;
		this.atd_remark = atd_remark;
	}
	public int getAtd_subj_code() {
		return atd_subj_code;
	}
	public void setAtd_subj_code(int atd_subj_code) {
		this.atd_subj_code = atd_subj_code;
	}
	public int getAtd_stu_id() {
		return atd_stu_id;
	}
	public void setAtd_stu_id(int atd_stu_id) {
		this.atd_stu_id = atd_stu_id;
	}
	public int getAtd_pro_id() {
		return atd_pro_id;
	}
	public void setAtd_pro_id(int atd_pro_id) {
		this.atd_pro_id = atd_pro_id;
	}
	public int getAtd_year() {
		return atd_year;
	}
	public void setAtd_year(int atd_year) {
		this.atd_year = atd_year;
	}
	public int getAtd_grade() {
		return atd_grade;
	}
	public void setAtd_grade(int atd_grade) {
		this.atd_grade = atd_grade;
	}
	public int getAtd_semester() {
		return atd_semester;
	}
	public void setAtd_semester(int atd_semester) {
		this.atd_semester = atd_semester;
	}
	public Date getAtd_date() {
		return atd_date;
	}
	public void setAtd_date(Date atd_date) {
		this.atd_date = atd_date;
	}
	public String getAtd_state() {
		return atd_state;
	}
	public void setAtd_state(String atd_state) {
		this.atd_state = atd_state;
	}
	public String getAtd_remark() {
		return atd_remark;
	}
	public void setAtd_remark(String atd_remark) {
		this.atd_remark = atd_remark;
	}
	
	
}

package attend;

public class View2Bean {
	private int stu_id;
	private int sc_grade;
	private int sc_semester;
	//이수구분: 전공필수, 전공선택 , 교양
	private String subj_state;
	private String subj_name;
	private int subj_hakjum;
	private String pro_name;
	private int sc_subj_code;
	
	public int getStu_id() {
		return stu_id;
	}
	public void setStu_id(int stu_id) {
		this.stu_id = stu_id;
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
	public int getSubj_hakjum() {
		return subj_hakjum;
	}
	public void setSubj_hakjum(int subj_hakjum) {
		this.subj_hakjum = subj_hakjum;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public int getSc_subj_code() {
		return sc_subj_code;
	}
	public void setSc_subj_code(int sc_subj_code) {
		this.sc_subj_code = sc_subj_code;
	}
}

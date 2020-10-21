package subject;

public class SubjectBean {
	private int subj_code;
	private String subj_state; //전공, 교양 등
	private String subj_name;	
	private int subj_hakjum; //몇학점 수업인지
	private int subj_pro; 
	private int subj_starttime;//수업 시작 교시
	private int subj_endtime; //수업 끝나는 교시
	private String subj_room; //강의실이름	
	

	public int getSubj_code() {
		return subj_code;
	}
	public void setSubj_code(int subj_code) {
		this.subj_code = subj_code;
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
	public int getSubj_pro() {
		return subj_pro;
	}
	public void setSubj_pro(int subj_pro) {
		this.subj_pro = subj_pro;
	}
	public int getSubj_starttime() {
		return subj_starttime;
	}
	public void setSubj_starttime(int subj_starttime) {
		this.subj_starttime = subj_starttime;
	}
	public int getSubj_endtime() {
		return subj_endtime;
	}
	public void setSubj_endtime(int subj_endtime) {
		this.subj_endtime = subj_endtime;
	}
	public String getSubj_room() {
		return subj_room;
	}
	public void setSubj_room(String subj_room) {
		this.subj_room = subj_room;
	}
	
	
}

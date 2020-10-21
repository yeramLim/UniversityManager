package timetable;

public class TimeTableBean {
	private String subj_name;
	private String subj_room;
	
	private String subj_day1;
	private int subj_stime1;
	private int subj_etime1;
	
	private String subj_day2;
	private int subj_stime2;
	private int subj_etime2;
	
	public String getSubj_name() {
		return subj_name;
	}
	public void setSubj_name(String subj_name) {
		this.subj_name = subj_name;
	}
	public String getSubj_room() {
		return subj_room;
	}
	public void setSubj_room(String subj_room) {
		this.subj_room = subj_room;
	}
	public String getSubj_day1() {
		return subj_day1;
	}
	public void setSubj_day1(String subj_day1) {
		this.subj_day1 = subj_day1;
	}
	public String getSubj_day2() {
		return subj_day2;
	}
	public void setSubj_day2(String subj_day2) {
		this.subj_day2 = subj_day2;
	}
	public int getSubj_stime1() {
		return subj_stime1;
	}
	public void setSubj_stime1(int subj_stime1) {
		this.subj_stime1 = subj_stime1;
	}
	public int getSubj_etime1() {
		return subj_etime1;
	}
	public void setSubj_etime1(int subj_etime1) {
		this.subj_etime1 = subj_etime1;
	}
	public int getSubj_stime2() {
		return subj_stime2;
	}
	public void setSubj_stime2(int subj_stime2) {
		this.subj_stime2 = subj_stime2;
	}
	public int getSubj_etime2() {
		return subj_etime2;
	}
	public void setSubj_etime2(int subj_etime2) {
		this.subj_etime2 = subj_etime2;
	}
}

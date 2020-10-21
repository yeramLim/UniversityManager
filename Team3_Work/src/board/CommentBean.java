package board;

import java.sql.Timestamp;

public class CommentBean {
	
	private int cmt_index; // 게시글 고유번호
	private int cmt_comm_index;
	private int cmt_num; // 댓글 번호
	private String cmt_writer; // 댓글 작성자
	private String cmt_content; // 댓글 본문
	private Timestamp cmt_date; // 작성일
	private String date2;
	private int cmt_stu_id; // 학번
	private int cmt_step = 0; // 댓글 위치
	private int cmt_level = 0; // 답댓글 순위
	private int cmt_ref = 0;

	
	public CommentBean() {}
	
	/*
	 * // 매개변수 있는 생성자 추가 public CommentBean(int cmt_index, String cmt_writer, String
	 * cmt_content, Timestamp cmt_date, int cmt_stu_id) { this.cmt_index =
	 * cmt_index; this.cmt_writer = cmt_writer; this.cmt_content = cmt_content;
	 * this.cmt_date = cmt_date; this.cmt_stu_id = cmt_stu_id; }
	 * 
	 * 
	 */
	public int getCmt_index() {
		return cmt_index;
	}
	public void setCmt_index(int cmt_index) {
		this.cmt_index = cmt_index;
	}

	
	public int getCmt_comm_index() {
		return cmt_comm_index;
	}

	public void setCmt_comm_index(int cmt_comm_index) {
		this.cmt_comm_index = cmt_comm_index;
	}

	public int getCmt_num() {
		return cmt_num;
	}
	public void setCmt_num(int cmt_num) {
		this.cmt_num = cmt_num;
	}
	public String getCmt_writer() {
		return cmt_writer;
	}
	public void setCmt_writer(String cmt_writer) {
		this.cmt_writer = cmt_writer;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public Timestamp getCmt_date() {
		return cmt_date;
	}
	public void setCmt_date(Timestamp cmt_date) {
		this.cmt_date = cmt_date;
	}
	public String getDate2() {
		return date2;
	}
	public void setDate2(String date2) {
		this.date2 = date2;
	}
	public int getCmt_stu_id() {
		return cmt_stu_id;
	}
	public void setCmt_stu_id(int cmt_stu_id) {
		this.cmt_stu_id = cmt_stu_id;
	}

	public int getCmt_step() {
		return cmt_step;
	}

	public void setCmt_step(int cmt_step) {
		this.cmt_step = cmt_step;
	}

	public int getCmt_level() {
		return cmt_level;
	}

	public void setCmt_level(int cmt_level) {
		this.cmt_level = cmt_level;
	}

	public int getCmt_ref() {
		return cmt_ref;
	}

	public void setCmt_ref(int cmt_ref) {
		this.cmt_ref = cmt_ref;
	}


	
	

}

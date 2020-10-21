package board;

import java.sql.Timestamp;

public class BoardBean {
	
	private int comm_index;
	private int comm_num;
	private int comm_groupn;
	private Timestamp comm_date;
	private String comm_title;
	private String comm_writer;
	private String comm_content;
	private int comm_hits;
	private int comm_stu_id;
	private int comm_ref = 0; // 글 그룹 번호 컬럼
	private int comm_step = 0; // 글 위치
	private int comm_level = 0; // 답변 순위
	private String comm_originFileName;
	private String comm_systemFileName;
	
	public static int pagesize = 10; // 한 페이지에 출력될 게시물 갯수
	public static int pagecountF = 1;
	public static int pageNUMF = 1;

	public static int pagecountQ = 1;
	public static int pageNUMQ = 1;

	public static int pagecountN = 1;
	public static int pageNUMN = 1;

	public static String pageNumberFree(int limit) {
		String str="";
		int temp=(pageNUMF-1) % limit;
		int startPage = pageNUMF - temp;
		
		if((startPage - limit) > 0) {
			str = "<a href='comm_Freeboard.jsp?pageNUMF="+(startPage-1)+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		for(int i=startPage; i<(startPage+limit); i++) {
			if(i == pageNUMF) {
				str += "["+i+"]&nbsp;&nbsp;";
			}else {
				str += "<a href='comm_Freeboard.jsp?pageNUMF="+i+"'>["+i+"]</a>&nbsp;&nbsp;";
			}
			
			if(i >= pagecountF) break;
		}
		
		if ((startPage+limit) <= pagecountF) {
			str += "<a href='comm_Freeboard.jsp?pageNUMF="+(startPage+limit)
					+"'>[다음]</a>";
		}
		return str;
	}
	
	public static String pageNumberqANDa(int limit) {
		String str="";
		int temp=(pageNUMQ-1) % limit;
		int startPage = pageNUMQ - temp;

		if((startPage - limit) > 0) {
			str = "<a href='comm_Q_And_A.jsp?pageNUMQ="+(startPage-1)
				+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		for(int i=startPage; i<(startPage+limit); i++) {
			if(i == pageNUMQ) {
				str += "["+i+"]&nbsp;&nbsp;";
			}else {
				str += "<a href='comm_Q_And_A.jsp?pageNUMQ="+i
						+"'>["+i+"]</a>&nbsp;&nbsp;";
			}
			
			if(i >= pagecountQ) break;
		}
		
		if ((startPage+limit) <= pagecountQ) {
			str += "<a href='comm_Q_And_A.jsp?pageNUMQ="+(startPage+limit)
					+"'>[다음]</a>";
		}
		return str;
	}
	
	public static String pageNumberNotice(int limit) {
		String str="";
		int temp=(pageNUMN-1) % limit;
		int startPage = pageNUMN - temp;
	
		if((startPage - limit) > 0) {
			str = "<a href='stu_Notice.jsp?pageNUMN="+(startPage-1)
				+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		for(int i=startPage; i<(startPage+limit); i++) {
			if(i == pageNUMN) {
				str += "["+i+"]&nbsp;&nbsp;";
			}else {
				str += "<a href='stu_Notice.jsp?pageNUMN="+i
						+"'>["+i+"]</a>&nbsp;&nbsp;";
			}
			
			if(i >= pagecountN) break;
		}
		
		if ((startPage+limit) <= pagecountN) {
			str += "<a href='stu_Notice.jsp?pageNUMN="+(startPage+limit)
					+"'>[다음]</a>";
		}
		return str;
	}

	
	public BoardBean() {
		super();
	}
	
	
	public BoardBean(String comm_originFileName, String comm_systemFileName) {
		this.comm_originFileName = comm_originFileName;
		this.comm_systemFileName = comm_systemFileName;
	}

	public int getComm_index() {
		return comm_index;
	}

	public void setComm_index(int comm_index) {
		this.comm_index = comm_index;
	}

	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public int getComm_groupn() {
		return comm_groupn;
	}
	public void setComm_groupn(int comm_groupn) {
		this.comm_groupn = comm_groupn;
	}
	public Timestamp getComm_date() {
		return comm_date;
	}
	public void setComm_date(Timestamp comm_date) {
		this.comm_date = comm_date;
	}
	public String getComm_title() {
		return comm_title;
	}
	public void setComm_title(String comm_title) {
		this.comm_title = comm_title;
	}
	public String getComm_writer() {
		return comm_writer;
	}
	public void setComm_writer(String comm_writer) {
		this.comm_writer = comm_writer;
	}
	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	public int getComm_hits() {
		return comm_hits;
	}
	public void setComm_hits(int comm_hits) {
		this.comm_hits = comm_hits;
	}

	public int getComm_stu_id() {
		return comm_stu_id;
	}

	public void setComm_stu_id(int comm_stu_id) {
		this.comm_stu_id = comm_stu_id;
	}
	public int getComm_ref() {
		return comm_ref;
	}
	public void setComm_ref(int comm_ref) {
		this.comm_ref = comm_ref;
	}
	public int getComm_step() {
		return comm_step;
	}
	public void setComm_step(int comm_step) {
		this.comm_step = comm_step;
	}
	public int getComm_level() {
		return comm_level;
	}
	public void setComm_level(int comm_level) {
		this.comm_level = comm_level;
	}

	public String getComm_originFileName() {
		return comm_originFileName;
	}
	public void setComm_originFileName(String comm_originFileName) {
		this.comm_originFileName = comm_originFileName;
	}
	public String getComm_systemFileName() {
		return comm_systemFileName;
	}
	public void setComm_systemFileName(String comm_systemFileName) {
		this.comm_systemFileName = comm_systemFileName;
	}
	
	
	

}

package student;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.MultipartConfigElement;
import javax.servlet.annotation.MultipartConfig;
import javax.sql.DataSource;

import attend.AttendBean;
import attend.View2Bean;
import schedule.ScheduleBean;
import scoreclass.ScoreClassBean;
import subject.SubjectBean;
import timetable.TimeTableBean;


public class StudentDBBean {
	private static StudentDBBean instance = new StudentDBBean();
	
	//StudentDBBean 객체의 메소드 사용 편하게 불러오기 위한 메소드
	public static StudentDBBean getInstance() {
		return instance;
	}
	
	//DB와 연결 메소드
	public Connection getConnection() throws Exception { 
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}

	//=====================학생 개인정보 조회 메소드, 담당교수님, 학부/학과도 불러옴=====================//
	public StudentBean getStudent(int id) {
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StudentBean stu = null;
		String sql="SELECT S.*, P.PRO_NAME, D.DEPT_NAME, D.DEPT_MAJORNAME FROM STUDENT S JOIN PROFESSOR P"
					+ " ON S.STU_PRO=P.PRO_ID JOIN DEPARTMENT D ON S.STU_MAJOR=D.DEPT_MAJORCODE WHERE S.STU_ID=?";
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			//where문의 학생의 학번을 조건으로 줘서 해당 학생의 정보를 불러올 수 있음
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			
			//쿼리문의 실행 값이 있다면 그 값을 set으로 학생 객체의 변수에 뿌려줌
			if(rs.next()) {
				stu=new StudentBean();
				stu.setStu_id(rs.getInt(1));
				stu.setStu_pwd(rs.getString(2));
				stu.setStu_name(rs.getString(3));
				stu.setStu_eng_name(rs.getString(4));
				stu.setStu_jumin(rs.getString(5));
				stu.setStu_state(rs.getInt(6));
				stu.setStu_major(rs.getInt(7));
				stu.setStu_grade(rs.getInt(8));
				stu.setStu_pro(rs.getInt(9));
				stu.setStu_tel(rs.getString(10));
				stu.setStu_emg_tel(rs.getString(11));
				stu.setStu_addr(rs.getString(12));
				stu.setStu_email(rs.getString(13));
				stu.setStu_img(rs.getBlob(14)); //이미지컬럼 추가완료	
				stu.setPro_name(rs.getString(15));
				stu.setDept_name(rs.getString(16));
				stu.setDept_majorname(rs.getString(17));
			}
			rs.close();
			pstmt.close();
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return stu;
		}
	
//========================학생들이 정보 수정할 때 sql 업데이트 메소드=========================//
	public int updateStudent(StudentBean stu_b, File file, FileInputStream fis) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql = null;
		//이미지를 업로드 한다면 -> null이 아니니까 STU_IMG도 UPDATE
		if(fis != null) {
		sql ="UPDATE STUDENT SET STU_PWD=?, STU_TEL=?,"
				+ "STU_ADDR=?, STU_EMAIL=?, STU_IMG=? WHERE STU_ID=?";
		//이미지가 기존에 있어서 이미지 업로드 하지 않을 때
		}else {
		sql ="UPDATE STUDENT SET STU_PWD=?, STU_TEL=?,"
				+ "STU_ADDR=?, STU_EMAIL=? WHERE STU_ID=?"; 			
		}
		int re=-1;
		try {
			con=getConnection();
			pstmt = con.prepareStatement(sql);
			//updateOk.jsp로 부터 받은 수정 항목의 값을 데이터베이스에 저장
			pstmt.setString(1, stu_b.getStu_pwd()); 
			pstmt.setString(2, stu_b.getStu_tel()+stu_b.getNum2()+stu_b.getNum3()); 
			pstmt.setString(3, stu_b.getStu_addr()+" "+stu_b.getDetailAddr());
			pstmt.setString(4, stu_b.getStu_email()+"@"+stu_b.getMail2());
			if(fis != null) {
				pstmt.setBinaryStream(5, fis, (int)file.length()); 
				pstmt.setInt(6, stu_b.getStu_id());
			}else {
				pstmt.setInt(5, stu_b.getStu_id());
			}

			re = pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
			
			System.out.println("변경 성공");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("변경 실패");
		}
		
		return re;
	}
	
	//========================들었던 과목정보와 , 출결정보 가져오는 메소드=========================//
	
	//출결조회가 가능한 학년만을 option으로 주기위한 메소드
	public ArrayList<Integer> getGrade(int stu_id) {
		Connection con=null;
		PreparedStatement ps = null;
		ResultSet rs=null;
	      ArrayList<Integer> grade = new ArrayList<Integer>();
	      try {
	    	 con=getConnection();
	         ps = con.prepareStatement("SELECT DISTINCT SC_GRADE FROM SCORECLASS WHERE SC_STU_ID = " + stu_id + " ORDER BY 1");
	         rs = ps.executeQuery();
	         while (rs.next()) {
	        	 grade.add(rs.getInt("SC_GRADE"));
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(con != null) con.close();
				}catch(Exception e2) {
					e2.printStackTrace();
				}
			}
	         
	      return grade;
	   }
	
	//해당학년 학기에 들었던 과목의 출결상태를 확인하기 전, 수강과목의 정보를 보여줌
	public ArrayList<View2Bean> classView(int id, int grade, int semester){
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		View2Bean v2 = null;
		String sql="SELECT * FROM ATD2 WHERE SC_GRADE=? AND SC_SEMESTER=? AND SC_STU_ID=?"; 
		ArrayList<View2Bean> viewlist = new ArrayList<View2Bean>();
		
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setInt(2, semester);
			pstmt.setInt(3, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				v2=new View2Bean();
				v2.setSc_subj_code(rs.getInt(1));
				v2.setStu_id(rs.getInt(2));
				v2.setSc_grade(rs.getInt(3));
				v2.setSc_semester(rs.getInt(4));
				v2.setSubj_state(rs.getString(5));
				v2.setSubj_name(rs.getString(6));
				v2.setSubj_hakjum(rs.getInt(7));
				v2.setPro_name(rs.getString(8));
				
				viewlist.add(v2);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return viewlist;
	}
	
	//해당과목을 클릭시 출결정보를 가져오는 메소드
	
	public ArrayList<AttendBean> AtdView(int id, int grade, int semester,int subj_code){
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		AttendBean attend = null;
		String sql="SELECT TO_CHAR(ATD_DATE,'YYYY-MM-DD'), ATD_STATE,ATD_REMARK FROM ATTEND "
							+ "WHERE ATD_STU_ID=? AND ATD_GRADE=? AND ATD_SEMESTER=? AND ATD_SUBJ_CODE=?";		
		
		ArrayList<AttendBean> viewlist = new ArrayList<AttendBean>();
		
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, grade);
			pstmt.setInt(3, semester);
			pstmt.setInt(4, subj_code);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//atd_remark[rs.getString(3)]이 null이면 공란,아니면  데이터 가져옴
				attend=new AttendBean(rs.getDate(1), rs.getString(2), rs.getString(3)==null? "":rs.getString(3));
				viewlist.add(attend);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return viewlist;
	}
	
	//========================학생의 성적조회를 위한 메소드=========================//
	
	//성적조회 가능한 년도를 option으로 주기 위한 메소드
	public ArrayList<Integer> getYear(int stu_id) {
		Connection con=null;
		PreparedStatement ps = null;
		ResultSet rs=null;
	      ArrayList<Integer> year = new ArrayList<Integer>();
	      try {
	    	 con=getConnection();
	         ps = con.prepareStatement("SELECT DISTINCT SC_YEAR FROM SCORECLASS WHERE SC_STU_ID = " + stu_id + " ORDER BY 1");
	         rs = ps.executeQuery();
	         while (rs.next()) {
	        	 year.add(rs.getInt("SC_YEAR"));
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(con != null) con.close();
				}catch(Exception e2) {
					e2.printStackTrace();
				}
			}
	         
	      return year;
	   }
	
	public ArrayList<ScoreClassBean> getScore(int id, int year, int semester) {
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ScoreClassBean sc = null;
		String sql=null;
		
		ArrayList<ScoreClassBean> scorelist = new ArrayList<ScoreClassBean>();
		try {
			con=getConnection();
			sql ="SELECT C.SC_YEAR, C.SC_GRADE, C.SC_SEMESTER, S.SUBJ_STATE, S.SUBJ_NAME, S.SUBJ_HAKJUM, C.SC_SCORE, C.SC_SCORE2 "
					+ "FROM SCORECLASS C JOIN SUBJECT S"
					+ " ON C.SC_SUBJ_CODE=S.SUBJ_CODE WHERE SC_STU_ID=? AND SC_YEAR=? AND SC_SEMESTER=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			rs=pstmt.executeQuery();
			
			
			while(rs.next()) {
				sc=new ScoreClassBean();
				
				sc.setSc_year(rs.getInt(1));
				sc.setSc_grade(rs.getInt(2));
				sc.setSc_semester(rs.getInt(3));
				sc.setSubj_state(rs.getString(4));
				sc.setSubj_name(rs.getString(5));
				sc.setSubj_hakjum(rs.getInt(6));
				sc.setSc_score(rs.getDouble(7));
				sc.setSc_score2(rs.getString(8));
			
				scorelist.add(sc);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return scorelist;
		}
	
	//========================시간표 조회를 위한 메소드=========================//	
	
	public ArrayList<TimeTableBean> timeScheduleView(int id){
		StudentBean s = getStudent(id);
		int grade = s.getStu_grade();
		int semester = 0;

		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH)+1;
		
		//현재 월을 불러와서 1학기(3~6월)에 해당하면
		if(3 <= month && month <= 6) {
			semester = 1;
		}else if(9 <= month && month <= 12) {
			semester = 2;
		}else {
			//방학기간
			return null;
		}

		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		TimeTableBean tbl = null;
		String sql=null; 
		ArrayList<TimeTableBean> viewlist = new ArrayList<TimeTableBean>();
		
		try {
			con=getConnection();
			sql="SELECT SUBJ_NAME,SUBJ_ROOM,SUBJ_DAY1,SUBJ_DAY2 FROM SUBJECT, SCORECLASS"
					+ " WHERE SC_SUBJ_CODE=SUBJ_CODE AND SC_STU_ID=? AND SC_GRADE=? AND SC_SEMESTER=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, grade);
			pstmt.setInt(3, semester);
			
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tbl =new TimeTableBean();
				tbl.setSubj_name(rs.getString(1));
				tbl.setSubj_room(rs.getString(2));
				
					//한 컬럼에 있는 요일,시작시간, 끝시간을 ',' 단위로 자르기 위해 씀
				 StringTokenizer tokenizer1 = new StringTokenizer(rs.getString(3), ",");
			      StringTokenizer tokenizer2 = null;
			      
			      //어떤 과목이 일주일에 두번 수업이 있는 경우에 두번째 수업의 요일,시간을 불러옴
			      if(rs.getString("SUBJ_DAY2") != null){
			         String subj_day2 = rs.getString(4);
			         tokenizer2 = new StringTokenizer(subj_day2, ",");
			      }
			      
			      tbl.setSubj_day1(tokenizer1.nextToken());
			      tbl.setSubj_stime1(Integer.parseInt(tokenizer1.nextToken()));
			      tbl.setSubj_etime1(Integer.parseInt(tokenizer1.nextToken()));
			      
			      String subj_day2 = "";
			      int subj_stime2 = 0;
			      int subj_etime2 = 0;
			      
			      if(tokenizer2 != null){
			         subj_day2 = tokenizer2.nextToken();
				     subj_stime2 = Integer.parseInt(tokenizer2.nextToken());
				     subj_etime2 = Integer.parseInt(tokenizer2.nextToken());
			      }
			      tbl.setSubj_day2(subj_day2);
				  tbl.setSubj_stime2(subj_stime2);
				  tbl.setSubj_etime2(subj_etime2);
				viewlist.add(tbl);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return viewlist;
	}
	//=======================년도별 학사 일정 조회  메소드=========================//
	public ArrayList<ScheduleBean> ScheduleView(boolean bol, int year){
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ScheduleBean schedule = null;
		String sql=null; 
		ArrayList<ScheduleBean> viewlist = new ArrayList<ScheduleBean>();
		
		try {
			con=getConnection();
			if(bol) {
				//메인화면에서 현재 월에 해당하는 일정 보여주기 위해서 
				sql="SELECT * FROM SCHEDULE WHERE SCHE_STARTYEAR=? AND SCHE_STARTMONTH =? ORDER BY SCHE_STARTMONTH, SCHE_STARTDAY";				
			}else { 
				// 학사일정 메뉴에서 년도별 전체 일정 보여주기 위해서 
				sql="SELECT * FROM SCHEDULE WHERE SCHE_STARTYEAR=? ORDER BY SCHE_STARTMONTH, SCHE_STARTDAY";				
			}
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, year);
			if(bol)
				pstmt.setInt(2, Calendar.getInstance().get(Calendar.MONTH)+1);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				schedule =new ScheduleBean();
				schedule.setSche_content(rs.getString(2));
				schedule.setShce_startyear(rs.getInt(3));
				schedule.setShce_startmonth(rs.getInt(4));
				schedule.setShce_startday(rs.getInt(5));
				schedule.setShce_endyear(rs.getInt(6));
				schedule.setShce_endmonth(rs.getInt(7));
				schedule.setShce_endday(rs.getInt(8));
				schedule.setShce_holiday(rs.getInt(9));
				viewlist.add(schedule);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return viewlist;
	}	
	
	//=======================비밀번호 찾기 후 새로운 비밀번호로 수정했을 때  메소드=========================//
	public int updatePwd(String id, String pwd) {
		Connection con=null;
		PreparedStatement pstmt = null;
		int result=-1;
		
		try {
			con=getConnection();
			String sql="UPDATE STUDENT SET STU_PWD =? WHERE STU_ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return result;
	}
	
}




























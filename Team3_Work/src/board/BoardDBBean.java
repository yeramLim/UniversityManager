package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import myUtil.HanConv;

public class BoardDBBean {

	private static BoardDBBean instance = new BoardDBBean(); // 객체 생성

	public static BoardDBBean getInstance() { // getInstance()호출 시 BoardDBBean을 참조하는 객체 리턴
		return instance;
	}

	public Connection getConnection() throws Exception { // db 연결하는 메소드

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		Connection conn = ds.getConnection();
		return conn;
	}

	// 게시판 작성
	public int insertBoard(BoardBean board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int num = 0;
		
		int index = board.getComm_index(); // 글 고유 index번호 
		int comm_num = board.getComm_num();
		int groupn = board.getComm_groupn();
		int ref = board.getComm_ref(); // 글 그룹 번호(원글 index 번호)
		int step = board.getComm_step(); // 글 위치
		int level = board.getComm_level(); // 답변 순위

		try {
			con = getConnection();

			// 게시글 고유 인덱스번호 가장 큰 값 가져와서 +1
			sql = "select max(comm_index) from community";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = rs.getInt(1) + 1;
			} else {
				index = 1;
				rs.getInt(1);
			}
			pstmt.close();
			rs.close();

			// groupn 당 comm_num(게시글번호) 가장 큰 값 가져와서 +1
			if (groupn == 1) {
				sql = "select max(comm_num) from (select * from community where comm_groupn=1)";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if (rs.next()) { // null이 아니면
					num = rs.getInt(1) + 1; // 여기서 (1)은 컬럼 인덱스

				} else {
					num = 1;
					rs.getInt(2);
				}
				pstmt.close();
				rs.close();
				
			} else {
				sql = "select max(comm_num) from (select * from community where comm_groupn=2 or comm_groupn=3)";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if (rs.next()) { // null이 아니면
					num = rs.getInt(1) + 1; // 여기서 (1)은 컬럼 인덱스

				} else {
					num = 1;
					rs.getInt(2);
				}
				pstmt.close();
				rs.close();
			}
			
			// 만약 글 고유 index번호가 0이 아니면
			if (comm_num != 0) {
				sql = "update community set comm_step = comm_step+1 where comm_ref=? and comm_step > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();

				step += 1;
				level += 1;
				
			} else {
				ref = index;
				step = 0;
				level = 0;
			}

			// comm_index 중 가장 큰 값에 +1 더한 값을 포함하여 모든 입력 값 저장
			if(board.getComm_originFileName() == null) {
				sql = "insert into community (comm_index, comm_num, comm_groupn, comm_date, comm_title, comm_content, comm_hits, comm_writer, comm_stu_id, comm_step, comm_level, comm_ref) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";				
			}else
				sql = "insert into community (comm_index, comm_num, comm_groupn, comm_date, comm_title, comm_content, comm_hits, comm_writer, comm_stu_id, comm_step, comm_level, comm_ref, comm_originFileName, comm_systemFileName) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, index);
			pstmt.setInt(2, num);
			pstmt.setInt(3, groupn);
			pstmt.setTimestamp(4, board.getComm_date());
			pstmt.setString(5, board.getComm_title());
			pstmt.setString(6, board.getComm_content().replace("\r\n", "<br>"));
			pstmt.setInt(7, board.getComm_hits());
			pstmt.setString(8, board.getComm_writer());
			pstmt.setInt(9, board.getComm_stu_id());
			pstmt.setInt(10, step);
			pstmt.setInt(11, level);
			pstmt.setInt(12, ref);
			if(board.getComm_originFileName() != null) {
				pstmt.setString(13, board.getComm_originFileName());
				pstmt.setString(14, board.getComm_systemFileName());
			}
			pstmt.executeUpdate();

			pstmt.close();

			System.out.println("추가 성공");

		} catch (Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return 1;
	}

	// 글 목록 조회
	public ArrayList<BoardBean> getListBoard(String col, String word, int comm_groupn, String pageNumber) { // 제네릭은
																											// 파일파라미터

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet pageset = null;

		int absolutepage = 1; // 절대 페이지
		int dbcount = 0; // 글의 총 개수

		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

		String sql = "";
			if(col.equals("search_title")) {
				word = " and comm_title like '%" + word + "%'";
			}else if(col.equals("search_content")) {
				word = " and comm_content like '%" + word + "%'";
			}
		try {
			con = getConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			if(comm_groupn == 2) {
				pageset = stmt.executeQuery("select count(*) from community where comm_groupn in (2,3)" + word);
			}else {
				pageset = stmt.executeQuery("select count(*) from community where comm_groupn=" + comm_groupn + word);
			}			
			
			if(pageset.next()) {
				dbcount = pageset.getInt(1);
				pageset.close();
			}
			
			if(dbcount % BoardBean.pagesize == 0) {
				if(comm_groupn == 1)
					BoardBean.pagecountF = dbcount / (BoardBean.pagesize);
				else if(comm_groupn == 2 || comm_groupn == 3)
					BoardBean.pagecountQ = dbcount / (BoardBean.pagesize);				
				else if(comm_groupn == 4)
					BoardBean.pagecountN = dbcount / (BoardBean.pagesize);
			}else {
				if(comm_groupn == 1)
					BoardBean.pagecountF = dbcount / (BoardBean.pagesize)+1;
				else if(comm_groupn == 2 || comm_groupn == 3)
					BoardBean.pagecountQ = dbcount / (BoardBean.pagesize)+1;				
				else if(comm_groupn == 4)
					BoardBean.pagecountN = dbcount / (BoardBean.pagesize)+1;
			}
			
			if(pageNumber != null) {
				if(comm_groupn == 1) {
					BoardBean.pageNUMF = Integer.parseInt(pageNumber);
					absolutepage=(BoardBean.pageNUMF-1) 
							* BoardBean.pagesize+1;
				}else if(comm_groupn == 2 || comm_groupn == 3) {
					BoardBean.pageNUMQ = Integer.parseInt(pageNumber);
					absolutepage=(BoardBean.pageNUMQ-1) 
							* BoardBean.pagesize+1;
				}else if(comm_groupn == 4) {
					BoardBean.pageNUMN = Integer.parseInt(pageNumber);
					absolutepage=(BoardBean.pageNUMN-1) 
							* BoardBean.pagesize+1;
				}
			}

			if(comm_groupn == 2) {
				sql = "select c.*, cnt.cont from community c left join (select cmt_index, count(*) cont from comments group by cmt_index) cnt on cnt.cmt_index = c.comm_index where c.comm_groupn in (2,3)" + word + " order by comm_ref desc, comm_step asc";
			}else {
				sql = "select c.*, cnt.cont from community c left join (select cmt_index, count(*) cont from comments group by cmt_index) cnt on cnt.cmt_index = c.comm_index where c.comm_groupn = " + comm_groupn + word + " order by comm_ref desc, comm_step asc";
			}
			rs = stmt.executeQuery(sql);
				
			if (rs.next()) {
				rs.absolute(absolutepage);
				int count = 0;

				while (count < BoardBean.pagesize) {
					BoardBean board = new BoardBean();
					board.setComm_index(rs.getInt(1));
					board.setComm_num(rs.getInt(2));
					board.setComm_groupn(rs.getInt(3));
					board.setComm_date(rs.getTimestamp(4));
					board.setComm_title(rs.getString(5));
					board.setComm_content(rs.getString(6));
					board.setComm_hits(rs.getInt(7));
					board.setComm_writer(rs.getString(8));
					board.setComm_stu_id(rs.getInt(9));
					board.setComm_step(rs.getInt(10));
					board.setComm_level(rs.getInt(11));
					board.setComm_ref(rs.getInt(12));
					board.setComm_originFileName(rs.getString(13));
					board.setComm_systemFileName(rs.getString(14));

					boardList.add(board);

					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
					count++;
				}
			}

		} catch (

		Exception e) {
			e.printStackTrace();
			System.out.println("조회 성공");
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return boardList;
	}

	// 게시글 조회
	public BoardBean getBoard(int comm_index, boolean hitadd) { // true 면 조회수 올리고, false 면 조회수 그대로
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		BoardBean board = null;

		try {
			con = getConnection();

			if (hitadd == true) { // 조회수 1올리기
				sql = "update community set comm_hits = comm_hits+1 where comm_index=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, comm_index);
				pstmt.executeUpdate();
				pstmt.close();
			}
			sql = "select * from community where comm_index=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comm_index);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardBean(); // 객체 생성을 해서 아래의 내용을 담음
				board.setComm_index(rs.getInt(1));
				board.setComm_num(rs.getInt(2));
				board.setComm_groupn(rs.getInt(3));
				board.setComm_date(rs.getTimestamp(4));
				board.setComm_title(rs.getString(5));
				board.setComm_content(rs.getString(6));
				board.setComm_hits(rs.getInt(7));
				board.setComm_writer(rs.getString(8));
				board.setComm_stu_id(rs.getInt(9));
				board.setComm_step(rs.getInt(10));
				board.setComm_level(rs.getInt(11));
				board.setComm_ref(rs.getInt(12));
				board.setComm_originFileName(rs.getString(13));
				board.setComm_systemFileName(rs.getString(14));

			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("출력 실패");
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return board;
	}

	// 게시판 글 삭제
	public int deleteBoard(int comm_index, String stu_pwd, String board_pwd) {
		Connection con = null;
		PreparedStatement pstmt = null; // 쿼리사용
		ResultSet rs = null; // 결과값

		String sql = "";
	
		int re = -1;

		try {
			con = getConnection();

			if (stu_pwd.equals(board_pwd)) {

				sql = "delete community where comm_index=? or comm_ref=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, comm_index);
				pstmt.setInt(2, comm_index);
						
				re = pstmt.executeUpdate();
				
				
			} else {
				System.out.println("비번틀림");
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("삭제 실패");

		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;

	}

	// 게시글 수정
	public int editBoard(BoardBean board) {
		Connection con = null;
		PreparedStatement pstmt = null; // 쿼리사용
		ResultSet rs = null; // 결과값

		String sql = "";

		int re = -1;

		try {
			con = getConnection();
			if(board.getComm_originFileName() != null) {
			sql = "update community set comm_title=?, comm_content=?, comm_originfilename=?, comm_systemfilename=? where comm_index=?";
			}else {
				sql = "update community set comm_title=?, comm_content=? where comm_index=?";				
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getComm_title());
			pstmt.setString(2, board.getComm_content());
			if(board.getComm_originFileName() != null) {
				pstmt.setString(3, board.getComm_originFileName());
				pstmt.setString(4, board.getComm_systemFileName());
				pstmt.setInt(5, board.getComm_index());
			}else {
				pstmt.setInt(3, board.getComm_index());				
			}
			re = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("수정 실패");
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}

}

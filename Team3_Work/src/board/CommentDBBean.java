package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import myUtil.HanConv;

public class CommentDBBean {

	private static CommentDBBean instance = new CommentDBBean(); // 객체 생성

	public static CommentDBBean getInstance() { // getInstance()호출 시 CommentDBBean을 참조하는 객체 리턴
		return instance;
	}

	public Connection getConnection() throws Exception { // db 연결하는 메소드

		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		Connection conn = ds.getConnection();
		return conn;
	}
	

	// 댓글 입력
	public int insertComment(CommentBean comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int num = 0;
		int re = -1;
		
		
		int cmt_num = comment.getCmt_num();
		System.out.println("cmt_num : " + cmt_num);
		
		int step = comment.getCmt_step(); // 글 위치
		int level = comment.getCmt_level(); // 답변 순위
		int ref = comment.getCmt_ref(); // 원 댓글 번호
		
		System.out.println("cmt_ref : " + ref);
		int index = comment.getCmt_index();
		int comm_index = comment.getCmt_comm_index();
	

		try {
			con = getConnection();
			// 댓글 고유 인덱스번호 가장 큰 값 가져와서 +1
			sql = "select max(cmt_index) from comments";
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
			
			
			// 게시글에 해당하는 댓글 num 주기 : 0이 아니면 가장 큰 값 가져와서 +1
			if(comm_index != 0) {
				sql = "select max(cmt_num) from comments where cmt_comm_index=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, comm_index);
	
				rs = pstmt.executeQuery();
	
				if (rs.next()) { // null이 아니면
					num = rs.getInt(1) + 1; // 여기서 (1)은 컬럼 인덱스
	
				} else {
					num = 1;
					rs.getInt(1);
				}
				pstmt.close();
				rs.close();
			}

			// 만약 댓글 번호가 0이 아니면
			if (cmt_num != 0) {
				sql = "update comments set cmt_step = cmt_step+1 where cmt_ref=? and cmt_step > ?";
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
				System.out.println("ref:" + ref);
			}
			
			
			// 위에서 실행한 쿼리 중, 댓글번호 가장 큰 값에 +1 더한 값을 포함하여 모든 입력 값 저장
			sql = "insert into comments (cmt_index, cmt_comm_index, cmt_num, cmt_writer, cmt_content, cmt_date, cmt_stu_id, cmt_step, cmt_level, cmt_ref) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, index);
			pstmt.setInt(2, comm_index);
			pstmt.setInt(3, num);
			pstmt.setString(4, comment.getCmt_writer());
			pstmt.setString(5, comment.getCmt_content());
			pstmt.setTimestamp(6, comment.getCmt_date());
			pstmt.setInt(7, comment.getCmt_stu_id());
			pstmt.setInt(8, step);
			pstmt.setInt(9, level);
			pstmt.setInt(10, ref);
			

			re = pstmt.executeUpdate();

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
		return re;
	}

	// 게시물 번호에 해당하는 댓글 출력
	public ArrayList<CommentBean> getListComment(int cmt_comm_index) { // 제네릭은 파일파라미터 라고도 함

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			ArrayList<CommentBean> commentList = new ArrayList<CommentBean>();

			String sql = "";

			try {
				con = getConnection();

				sql = "select * from (select a.*, to_char(cmt_date,'YYYY-MM-DD hh24:mi') date2 from comments a order by cmt_ref asc, cmt_step asc) where cmt_comm_index=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cmt_comm_index);
				
			
				rs = pstmt.executeQuery();

				while (rs.next()) {

					CommentBean comment = new CommentBean();
					
					comment.setCmt_index(rs.getInt(1));
					comment.setCmt_comm_index(rs.getInt(2));
					comment.setCmt_num(rs.getInt(3));
					comment.setCmt_writer(rs.getString(4));
					comment.setCmt_content(rs.getString(5));
					comment.setCmt_date(rs.getTimestamp(6));
					comment.setCmt_stu_id(rs.getInt(7));
					comment.setCmt_step(rs.getInt(8));
					comment.setCmt_level(rs.getInt(9));
					comment.setCmt_ref(rs.getInt(10));
					comment.setDate2(rs.getString(11));
					
					commentList.add(comment);
					
					
				}

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("조회 성공");
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
			return commentList;
		}
	
	// 댓글 한개 정보 가져오기(답댓글을 위함)
	public CommentBean getComment(int cmt_index) { // true 면 조회수 올리고, false 면 조회수 그대로
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		CommentBean comment = null;

		try {
			con = getConnection();

			/*
			 * if (hitadd == true) { // 조회수 1올리기 sql =
			 * "update community set comm_hits = comm_hits+1 where comm_index=?"; pstmt =
			 * con.prepareStatement(sql); pstmt.setInt(1, cmt_index); pstmt.executeUpdate();
			 * pstmt.close(); }
			 */
			sql = "select * from (select a.*, to_char(cmt_date,'YYYY-MM-DD hh24:mi') date2 from comments a order by cmt_num) where cmt_index=? order by cmt_ref desc, cmt_step asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cmt_index);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				comment = new CommentBean();
				comment.setCmt_index(rs.getInt(1));
				comment.setCmt_comm_index(rs.getInt(2));
				comment.setCmt_num(rs.getInt(3));
				comment.setCmt_writer(rs.getString(4));
				comment.setCmt_content(rs.getString(5));
				comment.setCmt_date(rs.getTimestamp(6));
				comment.setCmt_stu_id(rs.getInt(7));
				comment.setCmt_step(rs.getInt(8));
				comment.setCmt_level(rs.getInt(9));
				comment.setCmt_ref(rs.getInt(10));
				comment.setDate2(rs.getString(11));
				
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
		return comment;
	}
	
	
	// 댓글 개수 출력
	public int getCountComment(int cmt_comm_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select count(*) from comments where cmt_comm_index=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cmt_comm_index);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				re = rs.getInt(1);
				
			}

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
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
	
	
	// 댓글 글 삭제
		public int deleteComment(int cmt_index) {
			Connection con = null;
			PreparedStatement pstmt = null; // 쿼리사용
			ResultSet rs = null; // 결과값

			String sql = "";
			
			int re = -1;

			try {
				con = getConnection();
				
			
				sql = "delete comments where cmt_index=? or cmt_ref=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cmt_index);
				pstmt.setInt(2, cmt_index);
					
				re = pstmt.executeUpdate();
				

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
		


		
}

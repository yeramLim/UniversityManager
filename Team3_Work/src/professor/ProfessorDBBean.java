package professor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import student.StudentDBBean;

public class ProfessorDBBean {
	private static ProfessorDBBean instance = new ProfessorDBBean();
	
	public static ProfessorDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception { //oracle과 연결 메소드
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	public ProfessorBean getProfessor(int id) {
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ProfessorBean prof =null;
		String sql = "select * from professor where prof_id=?";
		
		try {
			con=getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				prof = new ProfessorBean();
				prof.setPro_id(rs.getInt("prof_id"));
				prof.setPro_pwd(rs.getString("prof_pwd"));
				prof.setPro_name(rs.getString("prof_name"));
				
			}
			
			rs.close();
			pstmt.close();
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return prof;
	}
}
	
	
	
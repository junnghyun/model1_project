package kr.co.truetrue.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * DB와 연결된 Connection을 반환하고. DB관련 객체들의 연결을 끊는 일을 한다..
 */
public class DbConnection {
	private static DbConnection dbCon;

	private DbConnection() {

	}// constructor

	public static DbConnection getInstance() {
		if (dbCon == null) {
			dbCon = new DbConnection();
		}

		return dbCon;
	}// getInstance

	public Connection getConn() throws SQLException {
		Connection con = null;
		
		//1. JNDI 사용객체 생성
		try {
			Context ctx=new InitialContext();
			//2. DBCP에서 DataDource 얻기
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/dbcp");
			//3. Connection 얻기
			con=ds.getConnection();
		}catch(NamingException ne) {
			ne.printStackTrace();
		}//end catch
		return con;
	}//getConn

	public Connection getConn(String jndiName) throws SQLException {
		Connection con = null;
		//1. JNDI 사용객체 생성
		try {
			Context ctx=new InitialContext();
			//2. DBCP에서 DataDource 얻기
			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/"+jndiName);
			//3. Connection 얻기
			con=ds.getConnection();
		}catch(NamingException ne) {
			ne.printStackTrace();
		}//end catch
		return con;
	}// getconn

	/**
	 * DB객체들의 연결을 끊는 일
	 * 
	 * @param rs
	 * @param stmt
	 * @param con
	 * @throws SQLException
	 */
	public void dbClose(ResultSet rs, Statement stmt, Connection con) throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (con != null) {
			con.close();
		}
	}// dbClose

}
// Class

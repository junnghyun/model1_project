package kr.co.truetrue.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class userDAO {
	
	public static final int SUCCESS_LOGIN = 1;
	public static final int FAILED_LOGIN = 2;
	public static final int NOT_FOUND_ID = 3;
	public static final int WHAT_THE_FUCK = 4;
	public static final int SUCCESS_CHANGE = 1;
	public static final int FAILED_CHANGE_PASS = 2;
	public static final int PASS_NOT_MATCH = 3;
	
	public static userDAO uDAO;
	
	public userDAO() {
	}
	
	public static userDAO getInstance() {
		if(uDAO==null) {
			uDAO=new userDAO();
		}
		return uDAO;
	}
	
	public void updateUser(userVO uVO)throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		StringBuilder updateUserInfo=new StringBuilder("	update	users	set	");
		boolean setAdded=false;
		if(uVO.getName()!=null) {
			updateUserInfo.append("	name	=	?	,	");
			setAdded=true;
		}
		if(uVO.getBirth()!=null) {
			updateUserInfo.append("	birth	=	?	,	");
			setAdded=true;
		}
		if(uVO.getPhone()!=null) {
			updateUserInfo.append("	phone	=	?	,	");
			setAdded=true;
		}
		if(uVO.getEmail()!=null) {
			updateUserInfo.append("	email	=	?	,	");
			setAdded=true;
		}
		if(uVO.getZip_code()!=null) {
			updateUserInfo.append("	zip_code	=	?	,	");
			setAdded=true;
		}
		if(uVO.getAddress()!=null) {
			updateUserInfo.append("	address	=	?	,	");
			setAdded=true;
		}
		if(uVO.getAddress_detail()!=null) {
			updateUserInfo.append("	address_detail	=	?	,	");
			setAdded=true;
		}
		/*
		 * if() { updateUserInfo.append(""); }
		 */
		if(setAdded) {
			updateUserInfo.setLength(updateUserInfo.length()-2);
			updateUserInfo.append("	where	id	=	?	");

			try {
				con=dbCon.getConn();
				pstmt=con.prepareStatement(updateUserInfo.toString());
				int paramIndex=1;
				
				if(uVO.getName() !=null) {
					pstmt.setString(paramIndex++, uVO.getName());
				}
				if(uVO.getBirth() !=null) {
					pstmt.setString(paramIndex++, uVO.getBirth());
				}
				if(uVO.getPhone() !=null) {
					pstmt.setString(paramIndex++, uVO.getPhone());
				}
				if(uVO.getEmail() !=null) {
					pstmt.setString(paramIndex++, uVO.getEmail());
				}
				if(uVO.getZip_code() !=null) {
					pstmt.setString(paramIndex++, uVO.getZip_code());
				}
				if(uVO.getAddress() !=null) {
					pstmt.setString(paramIndex++, uVO.getAddress());
				}
				if(uVO.getAddress_detail() !=null) {
					pstmt.setString(paramIndex++, uVO.getAddress_detail());
				}
				pstmt.setString(paramIndex, uVO.getUser_id());
/*				if(uVO !=null) {
					pstmt
				}*/
				pstmt.executeUpdate();
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}//finally
		}//if
	}//updateUser
	
	public String deleteUser(userVO uVO)throws SQLException {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		String deleteUser="update	users	set	withdrawn_flag	=	'd'	where	user_id	=	?	";
		
		try {
			con=dbCon.getConn();
			pstmt=con.prepareStatement(deleteUser);
			
			pstmt.setString(1, uVO.getUser_id());
			
			int affectedRows=pstmt.executeUpdate();
			
			if(affectedRows>0) {
				return uVO.getUser_id();
			}else {
				return "fail";
			}
		}catch(SQLException se){
			se.printStackTrace();
			return "error";
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}
		
	}//deleteUser
	
	public int totalUser(userVO uVO) throws SQLException {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		String searchTotalUser="	select	count(*)	from	users	where	withdrawn_flag	=	'Y'	";
		
		try {
			con=dbCon.getConn();
			pstmt=con.prepareStatement(searchTotalUser);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return 0;
	}
	
	public void joinInfo(userVO uVO) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    if (uVO.getUser_id() == null || uVO.getName() == null || uVO.getBirth() == null || uVO.getPass() == null) {
	        return;
	    }

	    StringBuilder joinInfoVal = new StringBuilder("insert into users (user_id, name, pass, birth");
	    
	    if (uVO.getPhone() != null) {
	        joinInfoVal.append(", phone");
	    }
	    if (uVO.getEmail() != null) {
	        joinInfoVal.append(", email");
	    }
	    if (uVO.getZip_code() != null) {
	        joinInfoVal.append(", zip_code");
	    }
	    if (uVO.getAddress() != null) {
	        joinInfoVal.append(", address");
	    }
	    if (uVO.getAddress_detail() != null) {
	        joinInfoVal.append(", address_detail");
	    }
	    
	    joinInfoVal.append(") values (?, ?, ?, ?");
	    
	    if (uVO.getPhone() != null) {
	        joinInfoVal.append(", ?");
	    }
	    if (uVO.getEmail() != null) {
	        joinInfoVal.append(", ?");
	    }
	    if (uVO.getZip_code() != null) {
	        joinInfoVal.append(", ?");
	    }
	    if (uVO.getAddress() != null) {
	        joinInfoVal.append(", ?");
	    }
	    if (uVO.getAddress_detail() != null) {
	        joinInfoVal.append(", ?");
	    }
	    
	    joinInfoVal.append(")");

	    try {
	        con = dbCon.getConn();
	        pstmt = con.prepareStatement(joinInfoVal.toString());
	        
	        pstmt.setString(1, uVO.getUser_id());
	        pstmt.setString(2, uVO.getName());
	        pstmt.setString(3, uVO.getPass());
	        pstmt.setString(4, uVO.getBirth());
	        
	        int index = 5;
	        if (uVO.getPhone() != null) {
	            pstmt.setString(index++, uVO.getPhone());
	        }
	        if (uVO.getEmail() != null) {
	            pstmt.setString(index++, uVO.getEmail());
	        }
	        if (uVO.getZip_code() != null) {
	            pstmt.setString(index++, uVO.getZip_code());
	        }
	        if (uVO.getAddress() != null) {
	            pstmt.setString(index++, uVO.getAddress());
	        }
	        if (uVO.getAddress_detail() != null) {
	            pstmt.setString(index++, uVO.getAddress_detail());
	        }

	        pstmt.executeUpdate();
	   
	    } finally {
	        dbCon.dbClose(null, pstmt, con);
	    }
	}
	
	public List<userVO> selectUser(userVO uVO)throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<userVO> userList=new ArrayList<userVO>();
		
		DbConnection dbCon=DbConnection.getInstance();
		con=dbCon.getConn();
		
		try {
			String selectUser="select * from users where user_id = ? ";
			pstmt=con.prepareStatement(selectUser);
			pstmt.setString(1,uVO.getUser_id());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				userVO uVO2=new userVO();
				uVO2.setUser_id(rs.getString("user_id"));
				uVO2.setName(rs.getString("name"));
				
				userList.add(uVO2);
			}
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
				
		return userList;
	}
	
	public int login(userVO uVO)throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		int status=userDAO.NOT_FOUND_ID;
		
		DbConnection dbCon=DbConnection.getInstance();
		con=dbCon.getConn();
		
		try {
			String userLogin=" select pass from users where user_id = ? ";
			pstmt=con.prepareStatement(userLogin);
			pstmt.setString(1, uVO.getUser_id());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(uVO.getPass())) {
					status=userDAO.SUCCESS_LOGIN; //로그인성공
				}else {
					status= userDAO.FAILED_LOGIN; //로그인실패
				}
			}
		}catch(SQLException se){
			se.printStackTrace();
			status=userDAO.WHAT_THE_FUCK; //망함
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return status; 
	}
	
	public userVO selectMyInfo()throws SQLException {
		userVO uVO=new userVO();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		con=dbCon.getConn();
		
		try {
			String selectInfo="select * from users where user_id = ? ";
			pstmt=con.prepareStatement(selectInfo);
			pstmt.setString(1,uVO.getUser_id());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				uVO.setUser_id(rs.getString("user_id"));
				uVO.setName(rs.getString("name"));
				uVO.setAddress(rs.getString("address"));
				uVO.setAddress_detail(rs.getString("address_detail"));
				uVO.setPhone(rs.getString("phone"));
				uVO.setEmail(rs.getString("email"));
				uVO.setZip_code(rs.getString("zip_code"));
				uVO.setPass(rs.getString("pass"));
				uVO.setAlluser(rs.getInt("alluser"));
				uVO.setWithdrawn_flag(rs.getString("withdrawn_flag"));
				uVO.setJoin_date(rs.getDate("join_date"));
				uVO.setBirth(rs.getString("birth"));
				
//				private String user_id,name,address,address_detail,phone,email,zip_code,pass;
//				private int alluser ;
//				private char withdrawn_flag;
//				private Date join_date,birth;
			}
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return uVO;
	}
	
	public void updateMyInfo(userVO uVO)throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		StringBuilder updateMyInfo=new StringBuilder("	update	users	set	");
		boolean setAdded=false;
		if(uVO.getName()!=null) {
			updateMyInfo.append("	name	=	?	,	");
			setAdded=true;
		}
		if(uVO.getBirth()!=null) {
			updateMyInfo.append("	birth	=	?	,	");
			setAdded=true;
		}
		if(uVO.getPhone()!=null) {
			updateMyInfo.append("	phone	=	?	,	");
			setAdded=true;
		}
		if(uVO.getEmail()!=null) {
			updateMyInfo.append("	email	=	?	,	");
			setAdded=true;
		}
		if(uVO.getZip_code()!=null) {
			updateMyInfo.append("	zip_code	=	?	,	");
			setAdded=true;
		}
		if(uVO.getAddress()!=null) {
			updateMyInfo.append("	address	=	?	,	");
			setAdded=true;
		}
		if(uVO.getAddress_detail()!=null) {
			updateMyInfo.append("	address_detail	=	?	,	");
			setAdded=true;
		}
		/*
		 * if() { updateUserInfo.append(""); }
		 */
		if(setAdded) {
			updateMyInfo.setLength(updateMyInfo.length()-2);
			updateMyInfo.append("	where	id	=	?	");

			try {
				con=dbCon.getConn();
				pstmt=con.prepareStatement(updateMyInfo.toString());
				int paramIndex=1;
				
				if(uVO.getName() !=null) {
					pstmt.setString(paramIndex++, uVO.getName());
				}
				if(uVO.getBirth() !=null) {
					pstmt.setString(paramIndex++, uVO.getBirth());
				}
				if(uVO.getPhone() !=null) {
					pstmt.setString(paramIndex++, uVO.getPhone());
				}
				if(uVO.getEmail() !=null) {
					pstmt.setString(paramIndex++, uVO.getEmail());
				}
				if(uVO.getZip_code() !=null) {
					pstmt.setString(paramIndex++, uVO.getZip_code());
				}
				if(uVO.getAddress() !=null) {
					pstmt.setString(paramIndex++, uVO.getAddress());
				}
				if(uVO.getAddress_detail() !=null) {
					pstmt.setString(paramIndex++, uVO.getAddress_detail());
				}
				pstmt.setString(paramIndex, uVO.getUser_id());
/*				if(uVO !=null) {
					pstmt
				}*/
				pstmt.executeUpdate();
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}//finally
		}//if
	}
	
	public int updateMyPass(userVO uVO)throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		con=dbCon.getConn();
		int status=userDAO.FAILED_CHANGE_PASS;
		
		try {
			String changePass=" update users set pass = ? where user_id = ? ";
			pstmt=con.prepareStatement(changePass);
			pstmt.setString(1, uVO.getUser_id());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
			}
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return status;
	}
	
}//class

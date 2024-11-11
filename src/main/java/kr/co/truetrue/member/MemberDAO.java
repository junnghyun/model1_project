package kr.co.truetrue.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;


public class MemberDAO {
    private static MemberDAO mDAO;
    
    private MemberDAO() {
    }
    
    public static MemberDAO getInstance() {
        if(mDAO == null) {
            mDAO = new MemberDAO();
        }
        return mDAO;
    }
    
    /**
     * 이름, 생일, 전화번호를 입력받아 DB에서 해당 조건에 맞는 아이디가 존재하는지 검사 후 아이디 반환
     * @param name 사용자 이름
     * @param birth 사용자 생일
     * @param phone 사용자 전화번호
     * @return 사용중-true, 미사용-false
     * @throws SQLException
     */
    public String findId(String name, String birth, String phone) throws SQLException {
        String userId = null;
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();

            String query = "SELECT user_id FROM users WHERE name = ? AND birth = ? AND phone = ?";
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, name);
            pstmt.setString(2, birth);
            pstmt.setString(3, phone);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                userId = rs.getString("user_id"); // 아이디가 존재하면 해당 아이디를 가져옴
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return userId; // 아이디가 없으면 null 반환
        
    }//findId
    
    
    /**
     * 이름, 생일, 전화번호를 입력받아 DB에서 해당 조건에 맞는 사용자의 비밀번호를 업데이트
     * @param name 사용자 이름
     * @param birth 사용자 생일
     * @param phone 사용자 전화번호
     * @param newPassword 새로운 비밀번호
     * @return true 성공적으로 비밀번호가 변경되었을때 true 반환, false 예외
     * @throws SQLException
     */
    public boolean updatePassword(String name, String birth, String phone, String newPassword) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();
        boolean isUpdated = false;

        try {
            con = dbCon.getConn();
            String query = "UPDATE users SET pass = ? WHERE name = ? AND birth = ? AND phone = ?";
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, newPassword);
            pstmt.setString(2, name);
            pstmt.setString(3, birth);
            pstmt.setString(4, phone);

            int rowsAffected = pstmt.executeUpdate();
            isUpdated = (rowsAffected > 0); // Update successful if rows affected
            
            System.out.println("Rows affected: " + rowsAffected); // 디버그 메시지
            System.out.println("Update Success: " + isUpdated);   // 디버그 메시지
            
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return isUpdated;
    }//updatePassword
    
 /**
  * 사용자로부터 현재의 비밀번호를 입력받아 DB에서 해당 조건에 맞는 사용자의 비밀번호를 새로운 비밀번호로 업데이트
  * @param currentPassword
  * @param newPassword
  * @return
  */
    public boolean verifyAndUpdatePassword(String userId, String currentPassword, String newPassword) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        String verifyQuery = "SELECT user_id FROM users WHERE user_id = ? AND pass = ?";
        String updateQuery = "UPDATE users SET pass = ? WHERE user_id = ?";
        boolean isUpdated = false;

        try {
            con = dbCon.getConn();
            pstmt = con.prepareStatement(verifyQuery);
            pstmt.setString(1, userId);
            pstmt.setString(2, currentPassword);
            rs = pstmt.executeQuery();

            if (rs.next()) { // 사용자가 검증됨
                pstmt.close();
                rs.close();

                pstmt = con.prepareStatement(updateQuery);
                pstmt.setString(1, newPassword);
                pstmt.setString(2, userId);

                int updatedRows = pstmt.executeUpdate();
                if (updatedRows > 0) {
                    isUpdated = true; // 업데이트 성공
                    con.commit(); // 커밋 수행
                }//end if
            }//end if

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isUpdated;
    }//verifyAndUpdatePassword

    
}//class

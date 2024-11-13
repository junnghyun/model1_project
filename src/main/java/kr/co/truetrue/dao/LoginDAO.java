package kr.co.truetrue.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;

public class LoginDAO {
    private DbConnection dbConnection;

    public LoginDAO() {
        dbConnection = DbConnection.getInstance();
    }

    /**
     * 사용자 로그인 확인 메서드
     *
     * @param userId 사용자 ID
     * @param password 사용자 비밀번호
     * @return 로그인 성공 여부
     */
    public boolean validateUser(String userId, String pass) {
        boolean isValidUser = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dbConnection.getConn();
            if (conn == null) {
                System.out.println("데이터베이스 연결 실패");
                return false;
            }

            // SQL 쿼리 작성: user_id와 pass가 일치하는지 확인
            StringBuilder select=new StringBuilder();
			select
			.append("	select user_id, pass	")
			.append("	from users	")
			.append("	where user_id=? and pass=?	");
			
			pstmt=conn.prepareStatement(select.toString());
            pstmt.setString(1, userId);
            pstmt.setString(2, pass);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                isValidUser = true;
                System.out.println("로그인 성공");
            }else {
            System.out.println("로그인 실패: 사용자 정보가 일치하지 않습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("오류 발생: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isValidUser;
    }
}

package kr.co.turetrue.admin.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;

public class AdminDAO {

    private static AdminDAO aDAO;

    private AdminDAO() { }

    public static AdminDAO getInstance() {
        if (aDAO == null) {
            aDAO = new AdminDAO();
        }
        return aDAO;
    }

    public boolean selectLogin(AdminVO aVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        boolean isValid = false;

        try {
            con = dbCon.getConn();
            StringBuilder select = new StringBuilder();
            select
                .append("SELECT admin_id, pass ")
                .append("FROM admin ")
                .append("WHERE admin_id = ? AND pass = ?");
            
            pstmt = con.prepareStatement(select.toString());
            pstmt.setString(1, aVO.getAdmin_id());
            pstmt.setString(2, aVO.getPass());
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                isValid = true; // 로그인 성공
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return isValid;
    }
}

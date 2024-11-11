package kr.co.truetrue.crawler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;


public class CrawlerDAO {
	
	private static CrawlerDAO cDAO;
	
	CrawlerDAO() {
	}
	
	public static CrawlerDAO getInstance() {
        if (cDAO == null) {
            cDAO = new CrawlerDAO();
        }
        return cDAO;
    }
	
	public void insertStore(CrawlerVO cVO) throws SQLException {
		Connection con = null;
        PreparedStatement pstmt = null;

        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            StringBuilder insertStore = new StringBuilder();
            insertStore.append("INSERT INTO store (store_id, store_name, store_phone, store_address, lat, lng) ")
                       .append("VALUES (seq_store_id.nextval, ?, ?, ?, ?, ?, ?)");

            pstmt = con.prepareStatement(insertStore.toString());
            pstmt.setString(1, cVO.getStore_name());
            pstmt.setString(2, cVO.getStore_phone());
            pstmt.setString(3, cVO.getStore_address());
            pstmt.setDouble(4, cVO.getLat());
            pstmt.setDouble(5, cVO.getLng());

            pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
	}
	
	public CrawlerVO selectDetailStore(String store_address) throws SQLException{
		CrawlerVO cVO=null;
		
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            StringBuilder selectOneStore = new StringBuilder();
            selectOneStore.append("SELECT store_name, store_phone, store_address, lat, lng ")
                           .append("FROM store ")
                           .append("WHERE store_id = ?");

            pstmt = con.prepareStatement(selectOneStore.toString());
            pstmt.setString(1, store_address);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                cVO = new CrawlerVO();
                cVO.setStore_name(rs.getString("store_name"));
                cVO.setStore_phone(rs.getString("store_phone"));
                cVO.setStore_address(rs.getString("store_address"));
                cVO.setLat(rs.getDouble("lat"));
                cVO.setLng(rs.getDouble("lng"));
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
		
		return cVO;
	}
}

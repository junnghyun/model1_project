package kr.co.truetrue.ad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;

public class AdMainDAO {

	
	private static AdMainDAO dMDAO;

	public AdMainDAO() {
	
	}

	public static AdMainDAO getInstance() {
		if (dMDAO == null) {
			dMDAO = new AdMainDAO();
		} // end if
		return dMDAO;
	}// getInstance
	
	/**
	 * 하나의 광고를 선택하는 method(사용자)
	 * 
	 * @param adVO
	 * @return
	 * @throws SQLException
	 */
	public AdVO selectOneAd(int adId) throws SQLException {

		AdVO adVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 1.JNDI사용객체 생성
		// 2.DBCP에서 DataSource 얻기
		DbConnection dbCon = DbConnection.getInstance();
		// 3.Connection얻기
		try {
			con = dbCon.getConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder selectOneId = new StringBuilder();
			selectOneId.append(
					"select ad_id, ad_start_date, ad_end_date, advertiser, ad_phone,  ad_price, clicks, input_date, ad_active ")
					.append("from ad ").append("where ad_id = ?");
 			// 5.바인드에 변수 값 설정
			pstmt.setInt(1, adId);
			// 6.쿼리문 수행 후 결과얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				adVO = new AdVO();
				adVO.setAd_Id(rs.getInt("ad_id"));
				adVO.setAd_Start_Date(rs.getString("ad_start_date")); // 광고 시작일 설정
				adVO.setAd_End_Date(rs.getString("ad_end_date")); // 광고 종료일 설정
				adVO.setAdvertiser(rs.getString("advertiser"));
				adVO.setAd_Phone(rs.getString("ad_phone"));
				adVO.setAd_Price(rs.getInt("ad_price"));
				adVO.setClicks(rs.getInt("clicks"));
				adVO.setInput_Date(rs.getDate("input_date"));
				adVO.setAd_Active(rs.getInt("ad_active"));
			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return adVO;
	}

	
}//AdMainDAO

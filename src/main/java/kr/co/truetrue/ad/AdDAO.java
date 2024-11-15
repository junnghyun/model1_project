package kr.co.truetrue.ad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.truetrue.dao.DbConnection;

public class AdDAO {

	private static AdDAO dDAO;

	private AdDAO() {
	}

	public static AdDAO getInstance() {
		if (dDAO == null) {
			dDAO = new AdDAO();
		} // end if
		return dDAO;
	}// getInstance

	/**
	 * 모든 광고를 조회하는 method
	 * 
	 * @param List<AdVO> 광고목록 리스트
	 * @throws SQLException
	 */
	public List<AdVO> selectAllAd(SearchAdVO shaVO) throws SQLException {
	    List<AdVO> adList = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();
	        StringBuilder selectAllAdQuery = new StringBuilder();
	        selectAllAdQuery.append(
	            "SELECT ad_id, ad_start_date, ad_end_date, advertiser, ad_price, clicks, ad_phone, input_date, ad_active ")
	            .append("FROM ( ")
	            .append("    SELECT ad_id, ad_start_date, ad_end_date, advertiser, ad_price, clicks, ad_phone, input_date, ad_active, ")
	            .append("           ROW_NUMBER() OVER (ORDER BY input_date ASC) AS rnum ")
	            .append("    FROM ad ")
	            .append("    WHERE delete_flag = 'Y' ");

	        if (shaVO.getKeyword() != null && !"".equals(shaVO.getKeyword())) {
	            selectAllAdQuery.append("AND instr(advertiser, ?) > 0 ");
	        }
	        selectAllAdQuery.append(") WHERE rnum BETWEEN ? AND ?");

	        pstmt = con.prepareStatement(selectAllAdQuery.toString());
	        int paramIndex = 1;

	        if (shaVO.getKeyword() != null && !"".equals(shaVO.getKeyword())) {
	            pstmt.setString(paramIndex++, shaVO.getKeyword());
	        }

	        pstmt.setInt(paramIndex++, shaVO.getStartNum());
	        pstmt.setInt(paramIndex, shaVO.getEndNum());

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            AdVO adVO = new AdVO();
	            adVO.setAd_Id(rs.getInt("ad_id"));
	            adVO.setAd_Start_Date(rs.getString("ad_start_date"));
	            adVO.setAd_End_Date(rs.getString("ad_end_date"));
	            adVO.setAdvertiser(rs.getString("advertiser"));
	            adVO.setAd_Price(rs.getInt("ad_price"));
	            adVO.setClicks(rs.getInt("clicks"));
	            adVO.setAd_Phone(rs.getString("ad_phone"));
	            adVO.setInput_Date(rs.getDate("input_date"));
	            adVO.setAd_Active(rs.getInt("ad_active"));

	            adList.add(adVO);
	        }

	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return adList;
	}


	/**
	 * 시작과 끝 값을 받아 총수익을 구하는 메서드
	 * 
	 * @param List<AdVO> 광고목록 리스트
	 * @throws SQLException
	 */
	public List<AdVO> selectAllDAO(SearchAdVO shaVO) throws SQLException {
		List<AdVO> adList = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();

			StringBuilder selectAllDAOQuery = new StringBuilder();
			selectAllDAOQuery.append(
					"SELECT ad_id, ad_start_date, ad_end_date, advertiser, ad_price, clicks, input_date, ad_active, ")
					.append("(SELECT SUM(ad_price) FROM ad WHERE delete_flag = 'Y') AS total_profit ")
					.append("FROM ad ").append("WHERE delete_flag = 'Y' ");

			// 광고의 활성 번호로 필터링할 경우
			if (shaVO.getAdvertiser() != null && !"".equals(shaVO.getAdvertiser())) {
				selectAllDAOQuery.append("AND ad_active = ? ");
			}

			// 광고의 키워드(광고주 이름)로 필터링할 경우
			if (shaVO.getKeyword() != null && !"".equals(shaVO.getKeyword())) {
				selectAllDAOQuery.append("AND instr(advertiser, ?) > 0 ");
			}

			selectAllDAOQuery.append("ORDER BY input_date DESC");

			pstmt = con.prepareStatement(selectAllDAOQuery.toString());

			int paramIndex = 1;

			if (shaVO.getAdvertiser() != null && !"".equals(shaVO.getAdvertiser())) {
				pstmt.setString(paramIndex++, shaVO.getAdvertiser());
			}

			if (shaVO.getKeyword() != null && !"".equals(shaVO.getKeyword())) {
				pstmt.setString(paramIndex++, shaVO.getKeyword());
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				AdVO adVO = new AdVO();
				adVO.setAd_Id(rs.getInt("ad_id"));
				adVO.setAd_Start_Date(rs.getString("ad_start_date"));
				adVO.setAd_End_Date(rs.getString("ad_end_date"));
				adVO.setAdvertiser(rs.getString("advertiser"));
				adVO.setAd_Price(rs.getInt("ad_price"));
				adVO.setClicks(rs.getInt("clicks"));
				adVO.setInput_Date(rs.getDate("input_date"));
				adVO.setAd_Active(rs.getInt("ad_active"));
				adList.add(adVO);
			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}

		return adList;
	}

	/**
	 * 하나의 광고를 선택하는 method
	 * 
	 * @param adVO
	 * @return
	 * @throws SQLException
	 */

	public AdVO selectOneAd(int ad_Id) throws SQLException {
	    AdVO adVO = null;
	    System.out.println("받은 ad_Id: " + ad_Id); // 디버깅용: ad_Id 출력
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();
	        String query = "SELECT ad_start_date, ad_end_date, advertiser, ad_phone, ad_price, ad_detail, ad_img "
	                     + "FROM ad WHERE ad_id = ? AND delete_flag = 'Y'";
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, ad_Id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            adVO = new AdVO();
	            adVO.setAd_Id(ad_Id);
	            adVO.setAd_Start_Date(rs.getString("ad_start_date"));
	            adVO.setAd_End_Date(rs.getString("ad_end_date"));
	            adVO.setAdvertiser(rs.getString("advertiser"));
	            adVO.setAd_Phone(rs.getString("ad_phone"));
	            adVO.setAd_Price(rs.getInt("ad_price"));
	            adVO.setAd_Detail(rs.getString("ad_detail"));
	            adVO.setAd_Img(rs.getString("ad_img"));
	            System.out.println("광고주 이름 확인: " + adVO.getAdvertiser()); // 디버깅용
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }
	    return adVO;
	}


	/**
	 * 광고 삽입(추가) 하는 method
	 * 
	 * @param adVO
	 * @throws SQLException
	 */
	/*
	 * public void insertAd(AdVO adVO) throws SQLException { Connection con = null;
	 * PreparedStatement pstmt = null; DbConnection dbCon =
	 * DbConnection.getInstance();
	 * 
	 * SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); try { con =
	 * dbCon.getConn(); // 쿼리문 생성객체 얻기 StringBuilder insertQuery = new
	 * StringBuilder(); insertQuery
	 * .append("insert into ad(ad_id, advertiser, ad_start_date, ad_end_date, ad_phone, ad_price,  ad_detail, ad_img ) "
	 * ) .append("values (seq_ad_id.nextval,?, ?, ?, ?, ?, ?, ?)");
	 * 
	 * // 날짜 형식을 문자열로 변환 (예: "20240101" 형식) String adStartDate = new
	 * java.text.SimpleDateFormat("yyyy-MM-dd").format(adVO.getAd_Start_Date());
	 * String adEndDate = new
	 * java.text.SimpleDateFormat("yyyy-MM-dd").format(adVO.getAd_End_Date());
	 * 
	 * // 바인드 변수에 값 설정 pstmt.setString(1, adVO.getAdvertiser()); pstmt.setString(2,
	 * adStartDate); pstmt.setString(3, adEndDate); pstmt.setString(4,
	 * adVO.getAd_Phone()); pstmt.setInt(5, adVO.getAd_Price()); pstmt.setString(6,
	 * adVO.getAd_Detail()); // ad_detail 바인딩 변수 추가 pstmt.setString(7,
	 * adVO.getAd_Img()); // ad_img 바인딩 변수 추가
	 * 
	 * 
	 * // SQL 실행 pstmt.executeUpdate(); } finally { dbCon.dbClose(null, pstmt, con);
	 * } }
	 */
	// insertAd 메서드 수정된 부분
	public int insertAd(AdVO adVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();
        int rowCount = 0;

        try {
            // Connection 얻기
            con = dbCon.getConn();

            // insert 쿼리 작성
            String insertQuery = "insert into ad "
                    + "(ad_id, ad_start_date, ad_end_date, advertiser, ad_detail, ad_phone, ad_img, ad_price, clicks, ad_active) "
                    + "values (seq_ad_id.nextval, ?, to_date(?, 'yyyy-mm-dd'), ?, ?, ?, ?, ?, ?, ?)";

            pstmt = con.prepareStatement(insertQuery);

            // Null 방지를 위한 기본값 설정
            String adStartDate = adVO.getAd_Start_Date() != null ? adVO.getAd_Start_Date().replaceAll("-", "") : "20240101";
            String adEndDate = adVO.getAd_End_Date() != null ? adVO.getAd_End_Date().replaceAll("-", "") : "20240331";
            String advertiser = adVO.getAdvertiser() != null ? adVO.getAdvertiser() : "뚜레쥬르";
            String adDetail = adVO.getAd_Detail() != null ? adVO.getAd_Detail() : "뚜레쥬르 광고";
            String adPhone = adVO.getAd_Phone() != null ? adVO.getAd_Phone() : "01012345678";
            String adImg = adVO.getAd_Img() != null ? adVO.getAd_Img() : "default.jpg";
            int adPrice = adVO.getAd_Price() != 0 ? adVO.getAd_Price() : 500000;
            int clicks = adVO.getClicks() != 0 ? adVO.getClicks() : 0;
            int adActive = adVO.getAd_Active() != 0 ? adVO.getAd_Active() : 1;

            // PreparedStatement에 값 설정
            pstmt.setString(1, adStartDate);      // 광고 시작일
            pstmt.setString(2, adEndDate);        // 광고 종료일
            pstmt.setString(3, advertiser);       // 광고주 이름
            pstmt.setString(4, adDetail);         // 광고 내용
            pstmt.setString(5, adPhone);          // 광고주 연락처
            pstmt.setString(6, adImg);            // 광고 이미지
            pstmt.setInt(7, adPrice);             // 광고 비용
            pstmt.setInt(8, clicks);              // 클릭 수
            pstmt.setInt(9, adActive);            // 광고 활성 상태(숫자번호)

            // SQL 실행
            rowCount = pstmt.executeUpdate();

            // 디버깅 로그: 삽입된 행 개수 확인
            System.out.println("rowCount (삽입된 행 수): " + rowCount);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("광고 삽입 중 오류가 발생했습니다: " + e.getMessage());
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
        return rowCount;
    }

	
	public int findNextId() throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    DbConnection dbCon = DbConnection.getInstance();
	    int nextId = 1;

	    try {
	        con = dbCon.getConn();
	        String query = "SELECT COALESCE(MAX(ad_id), 0) + 1 AS nextId FROM ad";
	        pstmt = con.prepareStatement(query);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            nextId = rs.getInt("nextId");
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return nextId;
	}

	/**
	 * 광고 업데이트(수정,편집)하는 method
	 * 
	 * @param adVO
	 * @throws SQLException
	 */
	/*
	 * public int updateAd(AdVO adVO) throws SQLException { Connection con = null;
	 * PreparedStatement pstmt = null; DbConnection dbCon =
	 * DbConnection.getInstance(); int rowCount = 0;
	 * 
	 * try { con = dbCon.getConn(); StringBuilder updateQuery = new StringBuilder();
	 * updateQuery.append("update ad ")
	 * .append("set advertiser=?, ad_start_date=?, ad_end_date=?, ad_phone=?, ad_price=?, ad_detail=?, ad_img=? "
	 * ) .append("where ad_id=?");
	 * 
	 * pstmt = con.prepareStatement(updateQuery.toString()); pstmt.setString(1,
	 * adVO.getAdvertiser()); pstmt.setString(2, adVO.getAd_Start_Date());
	 * pstmt.setString(3, adVO.getAd_End_Date()); pstmt.setString(4,
	 * adVO.getAd_Phone()); pstmt.setInt(5, adVO.getAd_Price()); pstmt.setString(6,
	 * adVO.getAd_Detail()); pstmt.setString(7, adVO.getAd_Img()); pstmt.setInt(8,
	 * adVO.getAd_Id());
	 * 
	 * rowCount = pstmt.executeUpdate(); // 업데이트된 행의 개수 반환
	 * 
	 * } finally { dbCon.dbClose(null, pstmt, con); } return rowCount; }
	 */
	
	public int updateAd(AdVO adVO) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    DbConnection dbCon = DbConnection.getInstance();
	    int rowCount = 0;

	    try {
	        // connection 얻기
	        con = dbCon.getConn();

	        // 디버깅 로그: adVO의 필드 값들을 출력
	        System.out.println("ad_Start_Date: " + adVO.getAd_Start_Date());
	        System.out.println("ad_End_Date: " + adVO.getAd_End_Date());
	        System.out.println("ad_Phone: " + adVO.getAd_Phone());
	        System.out.println("ad_Price: " + adVO.getAd_Price());
	        System.out.println("ad_Detail: " + adVO.getAd_Detail());
	        System.out.println("ad_Img: " + adVO.getAd_Img());
	        System.out.println("ad_Id: " + adVO.getAd_Id());
	        System.out.println("advertiser: " + adVO.getAdvertiser());

	        StringBuilder updateQuery = new StringBuilder();
	        updateQuery.append("UPDATE ad SET ")
	                   .append("ad_start_date = ?, ad_end_date = ?, advertiser = ?, ad_phone = ?, ad_price = ?, ad_detail = ?, ad_img = ? ")
	                   .append("WHERE ad_id = ?");

	        pstmt = con.prepareStatement(updateQuery.toString());

	        // adVO에서 날짜를 가져와 yyyyMMdd 형식의 문자열로 포맷팅
	        String formattedStartDate = adVO.getAd_Start_Date().replaceAll("-", "");
	        String formattedEndDate = adVO.getAd_End_Date().replaceAll("-", "");

	        // PreparedStatement 파라미터 설정
	        pstmt.setString(1, formattedStartDate);  // yyyyMMdd 형식으로 설정
	        pstmt.setString(2, formattedEndDate);    // yyyyMMdd 형식으로 설정
	        pstmt.setString(3, adVO.getAdvertiser());
	        pstmt.setString(4, adVO.getAd_Phone());
	        pstmt.setInt(5, adVO.getAd_Price());
	        pstmt.setString(6, adVO.getAd_Detail());
	        pstmt.setString(7, adVO.getAd_Img());
	        pstmt.setInt(8, adVO.getAd_Id());

	        // SQL 실행
	        rowCount = pstmt.executeUpdate();

	        // 디버깅 로그: rowCount 값 확인
	        System.out.println("rowCount (업데이트된 행 수): " + rowCount);

	    } finally {
	        dbCon.dbClose(null, pstmt, con);
	    }
	    return rowCount;
	}

	

	/**
	 * 하나의 광고를 삭제하는 method
	 * 
	 * @param adId
	 * @throws SQLException
	 */
	public int deleteAd(AdVO adVO) throws SQLException {
		int rowCnt = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();
			String deleteQuery = "delete from ad where ad_id = ?";
			pstmt = con.prepareStatement(deleteQuery);
			pstmt.setInt(1, adVO.getAd_Id());
			rowCnt = pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
		return rowCnt;
	}

	/** 광고의 우선순위를 설정하여 몇 번째 광고인지 지정하는 메서드 */
	public void adState(int ad_Id, int ad_Active) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();
			StringBuilder updateAdPriorityQuery = new StringBuilder();

			updateAdPriorityQuery.append(" update ad     ").append(" set ad_active = ?     ")
					.append(" where ad_id = ? and delete_flag = 'y'");

			pstmt = con.prepareStatement(updateAdPriorityQuery.toString());
			pstmt.setInt(1, ad_Active); // 광고의 우선순위를 설정
			pstmt.setInt(2, ad_Id);
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
	}

	/** 광고의 게재 여부를 설정하는 메서드 (delete_flag를 'D'로 설정하여 비활성화) */
	public void adPost(int ad_Id, boolean delete_Flag) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();
			StringBuilder updateAdStatusQuery = new StringBuilder();

			updateAdStatusQuery.append(" 	update ad       ").append(" 	set delete_flag = ?       ")
					.append("  	where ad_id = ?      ");

			pstmt = con.prepareStatement(updateAdStatusQuery.toString());
			pstmt.setString(1, delete_Flag ? "Y" : "D"); // Y로 활성화, D로 비활성화
			pstmt.setInt(2, ad_Id);
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
	}

	/** 활성 광고 수(active_ad)와 총 클릭 수(click)를 가져오는 메서드(활성광고 클릭수) */
	public Map<String, Integer> activeAd_Click() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dbCon = DbConnection.getInstance();
		Map<String, Integer> resultMap = new HashMap<>();

		try {
			con = dbCon.getConn();
			StringBuilder activeAdClickQuery = new StringBuilder();
			activeAdClickQuery.append("select count(*) as active_ads, coalesce(sum(clicks), 0) as total_clicks ")
					.append("from ad ").append("where delete_flag = 'Y' and ad_active > 0 ");

			pstmt = con.prepareStatement(activeAdClickQuery.toString());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int activeAds = rs.getInt("active_ads");
				int totalClicks = rs.getInt("total_clicks");
				// System.out.println("활성 광고 수: " + activeAds);
				// System.out.println("총 클릭 수: " + totalClicks);
				// 값 없을 경우 0으로 설정
				resultMap.put("activeAds", activeAds);
				resultMap.put("totalClicks", totalClicks != 0 ? totalClicks : 0);

			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return resultMap;

	}

	// 활성광고 수 가져오기
	public int getActiveAdCount(SearchAdVO shaVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dbCon = DbConnection.getInstance();
		int totalCount = 0;

		try {
			con = dbCon.getConn();
			StringBuilder selectCount = new StringBuilder();
			selectCount.append("SELECT COUNT(ad_id) cnt FROM ad");

			// 검색 조건 확인
			if (shaVO.getKeyword() != null && !"".equals(shaVO.getKeyword())) {
				selectCount.append(" WHERE instr(advertiser, ?) > 0");
				pstmt = con.prepareStatement(selectCount.toString());
				pstmt.setString(1, shaVO.getKeyword());
			} else {
				pstmt = con.prepareStatement(selectCount.toString());
			}

			// 쿼리 실행 및 결과 확인
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt("cnt");
			} else {
				totalCount = 0; // 결과가 없는 경우 기본값 설정
			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return totalCount;
	}
	
	
	

	/** 특정 광고의 클릭 수를 증가시키는 메서드 */
	public void countClick(int adId) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();
			StringBuilder incrementClickQuery = new StringBuilder();
			incrementClickQuery.append("update ad ").append("set clicks = clicks + 1 ")
					.append("where ad_id = ? and delete_flag = 'y'");
			pstmt = con.prepareStatement(incrementClickQuery.toString());
			pstmt.setInt(1, adId);
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
	}

}// class
package kr.co.truetrue.user.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.dao.DbConnection;

/**
 * 매장 리스트, 상세조회, 추가, 삭제, 변경 업무
 */
public class StoreDAO {
    private static StoreDAO sDAO;

    private StoreDAO() {
    }

    public static StoreDAO getInstance() {
        if (sDAO == null) {
            sDAO = new StoreDAO();
        }
        return sDAO;
    }

    /**
     * 총 매장의 수 검색
     * @param sVO
     * @return 매장의 수
     * @throws SQLException
     */
    public int selectTotalCount(StoreSearchVO sVO) throws SQLException {
        int totalCount = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder selectCount = new StringBuilder();
            selectCount.append("SELECT COUNT(store_id) AS cnt FROM store ");

            // 검색 키워드가 있는 경우
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                selectCount.append("WHERE instr(")
                           .append(sVO.getField())
                           .append(", ?) != 0");
            }

            pstmt = con.prepareStatement(selectCount.toString());
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                pstmt.setString(1, sVO.getKeyword());
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("cnt");
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return totalCount;
    }

    /**
     * 매장 목록 조회
     * @param sVO
     * @return 매장 목록
     * @throws SQLException
     */
    public List<StoreVO> selectStore(StoreSearchVO sVO) throws SQLException {
        List<StoreVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder selectStore = new StringBuilder();
            selectStore.append("SELECT store_id, store_name, store_phone, store_address, store_status ")
                       .append("FROM (SELECT store_id, store_name, store_phone, store_address, store_status, ")
                       .append("ROW_NUMBER() OVER (ORDER BY store_id) AS rnum ")
                       .append("FROM store ");

            // 검색 키워드가 있는 경우
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                selectStore.append("WHERE instr(")
                           .append(sVO.getField())
                           .append(", ?) != 0");
            }

            selectStore.append(") WHERE rnum BETWEEN ? AND ?");

            pstmt = con.prepareStatement(selectStore.toString());
            int bindIndex = 0;
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                pstmt.setString(++bindIndex, sVO.getKeyword());
            }
            pstmt.setInt(++bindIndex, sVO.getStartNum());
            pstmt.setInt(++bindIndex, sVO.getEndNum());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                StoreVO sVOResult = new StoreVO();
                sVOResult.setStore_id(rs.getInt("store_id"));
                sVOResult.setStore_name(rs.getString("store_name"));
                sVOResult.setStore_phone(rs.getString("store_phone"));
                sVOResult.setStore_address(rs.getString("store_address"));
                sVOResult.setStore_status(rs.getString("store_status").charAt(0)); // char 타입으로 변환

                list.add(sVOResult);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return list;
    }

    /**
     * 매장 추가
     * @param sVO
     * @throws SQLException
     */
    public void insertStore(StoreVO sVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder insertStore = new StringBuilder();
            insertStore.append("INSERT INTO store (store_id, store_name, store_phone, store_address, store_status, lat, lng) ")
                       .append("VALUES (seq_store_id.nextval, ?, ?, ?, ?, ?, ?)");

            pstmt = con.prepareStatement(insertStore.toString());
            pstmt.setString(1, sVO.getStore_name());
            pstmt.setString(2, sVO.getStore_phone());
            pstmt.setString(3, sVO.getStore_address());
            pstmt.setString(4, String.valueOf(sVO.getStore_status())); // char 타입으로 변환
            pstmt.setDouble(5, sVO.getLat());
            pstmt.setDouble(6, sVO.getLng());

            pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
    }

    /**
     * 매장 상세 조회
     * @param storeId
     * @return 매장 정보
     * @throws SQLException
     */
    public StoreVO selectDetailStore(int store_id) throws SQLException {
        StoreVO sVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder selectOneStore = new StringBuilder();
            selectOneStore.append("SELECT store_id, store_name, store_phone, store_address, store_status, lat, lng ")
                           .append("FROM store ")
                           .append("WHERE store_id = ?");

            pstmt = con.prepareStatement(selectOneStore.toString());
            pstmt.setInt(1, store_id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                sVO = new StoreVO();
                sVO.setStore_id(rs.getInt("store_id"));
                sVO.setStore_name(rs.getString("store_name"));
                sVO.setStore_phone(rs.getString("store_phone"));
                sVO.setStore_address(rs.getString("store_address"));
                sVO.setStore_status(rs.getString("store_status").charAt(0)); // char 타입으로 변환
                sVO.setLat(rs.getDouble("lat"));
                sVO.setLng(rs.getDouble("lng"));
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return sVO;
    }

    /**
     * 매장 정보 업데이트
     * @param sVO
     * @throws SQLException
     */
    public void updateStore(StoreVO sVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder updateStore = new StringBuilder();
            updateStore.append("UPDATE store SET ")
                       .append("store_name = ?, store_phone = ?, store_address = ?, ")
                       .append("store_status = ?, lat = ?, lng = ? ")
                       .append("WHERE store_id = ?");

            pstmt = con.prepareStatement(updateStore.toString());
            pstmt.setString(1, sVO.getStore_name());
            pstmt.setString(2, sVO.getStore_phone());
            pstmt.setString(3, sVO.getStore_address());
            pstmt.setString(4, String.valueOf(sVO.getStore_status())); // char 타입으로 변환
            pstmt.setDouble(5, sVO.getLat());
            pstmt.setDouble(6, sVO.getLng());
            pstmt.setInt(7, sVO.getStore_id());

            int affectedRows = pstmt.executeUpdate(); // 업데이트된 행 수를 확인
            if (affectedRows == 0) {
                throw new SQLException("매장 정보 수정 실패: 매장 ID가 존재하지 않습니다.");
            }
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
    }


    /**
     * 매장 삭제
     * @param storeId
     * @throws SQLException
     */
    public void deleteStore(int store_id) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            String deleteStore = "DELETE FROM store WHERE store_id = ?";

            pstmt = con.prepareStatement(deleteStore);
            pstmt.setInt(1, store_id);

            pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
    }
    
    /**
     * 'Y' 상태 매장의 총 개수 검색
     * @param sVO
     * @return 'Y' 상태 매장의 수
     * @throws SQLException
     */
    public int selectTotalCountY(StoreSearchVO sVO) throws SQLException {
        int totalCount = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder selectCount = new StringBuilder();
            selectCount.append("SELECT COUNT(store_id) AS cnt FROM store WHERE store_status = 'Y' ");

            // 지역 조건 추가
            if (sVO.getProvince() != null && !sVO.getProvince().isEmpty()) {
                selectCount.append("AND store_address LIKE ?");
            }
            if (sVO.getCity() != null && !sVO.getCity().isEmpty()) {
                selectCount.append(" AND store_address LIKE ?");
            }

            // 검색 키워드가 있는 경우
            if (sVO.getKeyword() != null && !sVO.getKeyword().isEmpty()) {
                selectCount.append(" AND instr(store_name, ?) != 0");
            }

            pstmt = con.prepareStatement(selectCount.toString());
            int bindIndex = 0;

            // 지역 조건 설정
            if (sVO.getProvince() != null && !sVO.getProvince().isEmpty()) {
                pstmt.setString(++bindIndex, "%" + sVO.getProvince() + "%");
            }
            if (sVO.getCity() != null && !sVO.getCity().isEmpty()) {
                pstmt.setString(++bindIndex, "%" + sVO.getCity() + "%");
            }

            // 검색 키워드 설정
            if (sVO.getKeyword() != null && !sVO.getKeyword().isEmpty()) {
                pstmt.setString(++bindIndex, sVO.getKeyword());
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("cnt");
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return totalCount;
    }

    
    public List<StoreVO> selectStoreY(StoreSearchVO sVO) throws SQLException {
        List<StoreVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder selectStore = new StringBuilder();
            selectStore.append("SELECT store_id, store_name, store_phone, store_address, store_status, lat, lng ") // lat, lng 추가
                       .append("FROM (SELECT store_id, store_name, store_phone, store_address, store_status, lat, lng, ")
                       .append("ROW_NUMBER() OVER (ORDER BY store_id) AS rnum ")
                       .append("FROM store WHERE store_status = 'Y' "); // 매장 상태가 'Y'인 경우만 조회

            // province 필터링
            if (sVO.getProvince() != null && !sVO.getProvince().isEmpty()) {
                selectStore.append(" AND store_address LIKE ?");
            }

            // city 필터링
            if (sVO.getCity() != null && !sVO.getCity().isEmpty()) {
                selectStore.append(" AND store_address LIKE ?");
            }

            // 검색 키워드가 있는 경우
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                selectStore.append(" AND instr(store_name, ?) != 0");
            }

            selectStore.append(") WHERE rnum BETWEEN ? AND ?");

            pstmt = con.prepareStatement(selectStore.toString());
            int bindIndex = 0;

            // province 필터링을 위한 바인딩
            if (sVO.getProvince() != null && !sVO.getProvince().isEmpty()) {
                pstmt.setString(++bindIndex, "%" + sVO.getProvince() + "%");
            }

            // city 필터링을 위한 바인딩
            if (sVO.getCity() != null && !sVO.getCity().isEmpty()) {
                pstmt.setString(++bindIndex, "%" + sVO.getCity() + "%");
            }

            // 검색 키워드를 위한 바인딩
            if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
                pstmt.setString(++bindIndex, sVO.getKeyword());
            }

            pstmt.setInt(++bindIndex, sVO.getStartNum());
            pstmt.setInt(++bindIndex, sVO.getEndNum());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                StoreVO sVOResult = new StoreVO();
                sVOResult.setStore_id(rs.getInt("store_id"));
                sVOResult.setStore_name(rs.getString("store_name"));
                sVOResult.setStore_phone(rs.getString("store_phone"));
                sVOResult.setStore_address(rs.getString("store_address"));
                sVOResult.setStore_status(rs.getString("store_status").charAt(0)); // char 타입으로 변환
                
                // 위경도 추가
                sVOResult.setLat(rs.getDouble("lat"));
                sVOResult.setLng(rs.getDouble("lng"));

                list.add(sVOResult);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return list;
    }

}

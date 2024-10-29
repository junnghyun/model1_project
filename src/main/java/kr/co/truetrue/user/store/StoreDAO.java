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
    public StoreVO selectDetailStore(int storeId) throws SQLException {
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
            pstmt.setInt(1, storeId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                sVO = new StoreVO();
                sVO.setStore_id(rs.getInt("store_id"));
                sVO.setStore_name(rs.getString("store_name"));
                sVO.setStore_phone(rs.getString("store_phone"));
                sVO.setStore_address(rs.getString("store_address"));
                sVO.setStore_status(rs.getString("store_status").charAt(0)); // char 타입으로 변환
                sVO.setLat(rs.getInt("lat"));
                sVO.setLng(rs.getInt("lng"));
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

            pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
    }

    /**
     * 매장 삭제
     * @param storeId
     * @throws SQLException
     */
    public void deleteStore(int storeId) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            String deleteStore = "DELETE FROM store WHERE store_id = ?";

            pstmt = con.prepareStatement(deleteStore);
            pstmt.setInt(1, storeId);

            pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
    }

}

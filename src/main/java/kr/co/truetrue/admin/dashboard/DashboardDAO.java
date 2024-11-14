package kr.co.truetrue.admin.dashboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.admin.order.OrderVO;
import kr.co.truetrue.dao.DbConnection;

public class DashboardDAO {
    private static DashboardDAO dDAO;
    
    private DashboardDAO() {}
    
    public static DashboardDAO getInstance() {
        if(dDAO == null) {
            dDAO = new DashboardDAO();
        }
        return dDAO;
    }
    
    public List<Integer> getWeeklyVisitors() throws SQLException {
        List<Integer> weeklyData = new ArrayList<>(7);
        for(int i = 0; i < 7; i++) {
            weeklyData.add(0);
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            conn = dbCon.getConn();
            // SQL 쿼리 수정
            String sql = 
                "SELECT TO_NUMBER(TO_CHAR(connect_date, 'D')) as day_of_week, " +
                "       COUNT(DISTINCT user_id) as visitor_count " +
                "FROM connect_history " +
                "WHERE connect_date >= SYSDATE - 7 " +  // 최근 7일 데이터 조회
                "GROUP BY TO_NUMBER(TO_CHAR(connect_date, 'D')) " +
                "ORDER BY day_of_week";
                
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            // 디버깅을 위한 출력
            System.out.println("쿼리 실행 결과:");
            while(rs.next()) {
                int dayOfWeek = rs.getInt("day_of_week");
                int visitorCount = rs.getInt("visitor_count");
                System.out.println("Day: " + dayOfWeek + ", Count: " + visitorCount);
                
                // 일요일(1)을 7로 변경, 나머지는 1 빼서 0-6 인덱스로 변환
                int arrayIndex = (dayOfWeek == 1) ? 6 : dayOfWeek - 2;
                weeklyData.set(arrayIndex, visitorCount);
            }
            
            // 최종 결과 출력
            System.out.println("Final weekly data: " + weeklyData);
            
        } finally {
            dbCon.dbClose(rs, pstmt, conn);
        }
        
        return weeklyData;
    }
    
 // 상품별 주문량을 가져오는 메소드
public List<OrderVO> getTopOrderProducts() throws SQLException {
    List<OrderVO> orderData = new ArrayList<>();
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DbConnection dbCon = DbConnection.getInstance();
    
    try {
        conn = dbCon.getConn();
        // FETCH FIRST 6 ROWS ONLY 추가
        String sql = 
        		"SELECT * FROM (" +
        			    "    SELECT p.product_name, NVL(SUM(cp.quantity), 0) as total_quantity " +
        			    "    FROM product p " +
        			    "    LEFT JOIN cart_product cp ON p.product_id = cp.product_id AND cp.order_flag = 'A' " +
        			    "    WHERE p.category_id IN ('1', '2') " +
        			    "    GROUP BY p.product_id, p.product_name " +
        			    "    ORDER BY total_quantity DESC" +
        			    ") WHERE ROWNUM <= 6";  // 상위 6개만 조회
            
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        
        while(rs.next()) {
            String productName = rs.getString("product_name");
            int totalQuantity = rs.getInt("total_quantity");
            orderData.add(new OrderVO(productName, totalQuantity));
        }
        
    } finally {
        dbCon.dbClose(rs, pstmt, conn);
    }
    
    return orderData;
}
}
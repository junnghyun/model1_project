package kr.co.truetrue.order;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import kr.co.truetrue.dao.DbConnection;

public class OrderDAO {
    private static OrderDAO instance; // 싱글톤 인스턴스
    private Connection conn;

    // 생성자를 private으로 설정하여 외부에서 인스턴스화 방지
    private OrderDAO() {
        try {
            conn = DbConnection.getInstance().getConn(); // DbConnection의 getConn() 사용
        } catch (SQLException e) {
            e.printStackTrace(); // 연결 오류 처리
        }
    }

    // OrderDAO의 싱글톤 인스턴스를 반환하는 메서드
    public static synchronized OrderDAO getInstance() {
        if (instance == null) {
            instance = new OrderDAO();
        }
        return instance;
    }

    // 사용자 ID와 날짜 범위에 따른 주문 내역 조회 메서드
    public List<OrderVO> getOrdersByUserAndDateRange(String userId, Date startDate, Date endDate) {
        List<OrderVO> orderList = new ArrayList<>();
        String query = "SELECT order_id, product_names, order_date, total_amount, delivery_complete_date, delivery_status " +
                       "FROM user_order_detail_view " +
                       "WHERE user_id = ? AND order_date BETWEEN ? AND ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, userId);
            pstmt.setDate(2, startDate);
            pstmt.setDate(3, endDate);
            
            System.out.println(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderVO order = new OrderVO();
                order.setOrderId(rs.getInt("order_id"));
                order.setProductNames(rs.getString("product_names"));
                order.setOrderDate(rs.getString("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setDeliveryCompleteDate(rs.getString("delivery_complete_date"));
                order.setDeliveryStatus(rs.getString("delivery_status"));
                orderList.add(order);
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }
    
 // 최근 6개월의 월별 매출 조회
    public Map<String, Double> getMonthlySales() {
        Map<String, Double> monthlySales = new HashMap<>();
        String query = "SELECT TO_CHAR(payment_date, 'YYYY-MM') AS month, SUM(total_price) AS monthly_total " +
                "FROM orders " +
                "WHERE payment_date >= ADD_MONTHS(SYSDATE, -6) " +
                "GROUP BY TO_CHAR(payment_date, 'YYYY-MM') " +
                "ORDER BY month";

        try (PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String month = rs.getString("month");
                Double total = rs.getDouble("monthly_total");
                monthlySales.put(month, total);
            }

            // 현재 월부터 6개월 전까지의 모든 월을 추가하고 매출이 없는 경우 0으로 설정
            for (int i = 5; i >= 0; i--) {
                String monthKey = LocalDate.now().minusMonths(i).format(DateTimeFormatter.ofPattern("yyyy-MM"));
                monthlySales.putIfAbsent(monthKey, 0.0);
            }
            
         // 역순으로 정렬
            monthlySales = monthlySales.entrySet()
                                       .stream()
                                       .sorted(Collections.reverseOrder(Map.Entry.comparingByKey()))
                                       .collect(Collectors.toMap(
                                           Map.Entry::getKey,
                                           Map.Entry::getValue,
                                           (e1, e2) -> e1,
                                           LinkedHashMap::new
                                       ));

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlySales;
    }


}

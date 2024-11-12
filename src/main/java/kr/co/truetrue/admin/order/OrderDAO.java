package kr.co.truetrue.admin.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.dao.DbConnection;

public class OrderDAO {
	private static OrderDAO oDAO;
	
	private OrderDAO() {
		
	}
	
	public static OrderDAO getInstance() {
		if(oDAO==null) {
			oDAO=new OrderDAO();
		}
		return oDAO;
	}
	
    // 전체 주문 건수를 조회하는 메소드
	public int selectTotalCount() throws SQLException {
	    int totalCount = 0;
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn();
	        
	        // 뷰를 사용한 실제 주문 건수 조회 (중복 제거)
	        String selectTotal = "SELECT COUNT(*) cnt FROM order_detail_view";
	            
	        pstmt = con.prepareStatement(selectTotal);
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            totalCount = rs.getInt("cnt");
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }
	    
	    return totalCount;
	}
	
    // 페이징 처리된 전체 주문 목록을 조회하는 메소드
	public List<OrderVO> selectAllOrder(int startNum, int endNum) throws SQLException {
	    List<OrderVO> list = new ArrayList<OrderVO>();
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn();
	        
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT * ")
	            .append(" FROM (SELECT rownum rnum, a.* ")
	            .append("       FROM (SELECT representative_order_id as order_id, ")
	            .append("                    user_id, ")
	            .append("                    TO_CHAR(payment_date, 'YYYY-MM-DD') AS payment_date, ")
	            .append("                    total_price, ")
	            .append("                    address, ")
	            .append("                    delivery_status, ")
	            .append("                    product_info ")
	            .append("             FROM order_detail_view ")
	            .append("             ORDER BY payment_date DESC) a ")
	            .append("       WHERE rownum <= ?) ")
	            .append(" WHERE rnum >= ? ");
	            
	        pstmt = con.prepareStatement(selectOrder.toString());
	        
	        pstmt.setInt(1, endNum);
	        pstmt.setInt(2, startNum);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            OrderVO oVO = new OrderVO();
	            oVO.setOrder_id(rs.getInt("order_id"));
	            oVO.setUser_id(rs.getString("user_id"));
	            oVO.setPayment_date(rs.getString("payment_date"));
	            oVO.setTotal_price(rs.getInt("total_price"));
	            oVO.setAddress(rs.getString("address"));
	            oVO.setDelivery_status(rs.getString("delivery_status"));
	            oVO.setProduct_info(rs.getString("product_info"));
	            list.add(oVO);
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }
	    
	    return list;
	}
	
	// 주문 상태를 업데이트하는 메소드
    // - 배송 시작, 배송 완료, 주문 취소 등의 상태 변경
	public void updateStatus(OrderVO oVO) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn();
	        
	        StringBuilder updateOrder = new StringBuilder();
	        updateOrder
	            .append(" UPDATE orders ")
	            .append(" SET delivery_status = ?, ")
	            // 배송완료일 경우에만 delivery_date 설정
	            .append("     delivery_date = CASE WHEN ? = 'C' THEN SYSDATE ELSE delivery_date END ")
	            .append(" WHERE order_id = ? ")  // representative_order_id로 조회
	            .append(" OR order_id IN ( ")    // 같은 payment_date와 user_id를 가진 주문들 조회
	            .append("     SELECT o2.order_id ")
	            .append("     FROM orders o2 ")
	            .append("     JOIN orders o1 ON o1.payment_date = o2.payment_date ")
	            .append("     JOIN cart_product cp1 ON o1.cart_product_id = cp1.cart_product_id ")
	            .append("     JOIN cart_product cp2 ON o2.cart_product_id = cp2.cart_product_id ")
	            .append("     WHERE o1.order_id = ? ")
	            .append("     AND cp1.user_id = cp2.user_id ")
	            .append(" ) ");

	        pstmt = con.prepareStatement(updateOrder.toString());
	        
	        pstmt.setString(1, oVO.getDelivery_status());
	        pstmt.setString(2, oVO.getDelivery_status());  // CASE 문에서 사용
	        pstmt.setInt(3, oVO.getOrder_id());
	        pstmt.setInt(4, oVO.getOrder_id());
	        
	        pstmt.executeUpdate();
	        
	    } finally {
	        dbCon.dbClose(null, pstmt, con);
	    }
	}
	
	// 신규 주문('주문 확인' 상태) 건수를 조회하는 메소드
	public int selectNewOrderCount() throws SQLException {
	    int totalCount = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        String selectTotal = "SELECT COUNT(*) cnt FROM order_detail_view WHERE delivery_status = '주문 확인'";
	        pstmt = con.prepareStatement(selectTotal);
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            totalCount = rs.getInt("cnt");
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return totalCount;
	}
	
	 // 신규 주문 목록을 페이징 처리하여 조회하는 메소드
	public List<OrderVO> selectNewOrder(int startNum, int endNum) throws SQLException {
	    List<OrderVO> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT * ")
	            .append(" FROM (SELECT rownum rnum, a.* ")
	            .append("       FROM (SELECT representative_order_id as order_id, ")
	            .append("                    user_id, ")
	            .append("                    TO_CHAR(payment_date, 'YYYY-MM-DD') AS payment_date, ")
	            .append("                    total_price, ")
	            .append("                    address, ")
	            .append("                    delivery_status, ")
	            .append("                    product_info ")
	            .append("             FROM order_detail_view ")
	            .append("             WHERE delivery_status = '주문 확인' ")
	            .append("             ORDER BY payment_date DESC) a ")
	            .append("       WHERE rownum <= ?) ")
	            .append(" WHERE rnum >= ? ");
	            
	        pstmt = con.prepareStatement(selectOrder.toString());
	        pstmt.setInt(1, endNum);
	        pstmt.setInt(2, startNum);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            OrderVO oVO = new OrderVO();
	            oVO.setOrder_id(rs.getInt("order_id"));
	            oVO.setUser_id(rs.getString("user_id"));
	            oVO.setPayment_date(rs.getString("payment_date"));
	            oVO.setTotal_price(rs.getInt("total_price"));
	            oVO.setAddress(rs.getString("address"));
	            oVO.setDelivery_status(rs.getString("delivery_status"));
	            oVO.setProduct_info(rs.getString("product_info"));
	            list.add(oVO);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return list;
	}
	
	// 배송 완료된 주문 목록을 페이징 처리하여 조회하는 메소드
	public List<OrderVO> selectCompletedOrder(int startNum, int endNum) throws SQLException {
	    List<OrderVO> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT * ")
	            .append(" FROM (SELECT rownum rnum, a.* ")
	            .append("       FROM (SELECT representative_order_id as order_id, ")
	            .append("                    user_id, ")
	            .append("                    TO_CHAR(payment_date, 'YYYY-MM-DD') AS payment_date, ")
	            .append("                    total_price, ")
	            .append("                    address, ")
	            .append("                    delivery_status, ")
	            .append("                    product_info ")
	            .append("             FROM order_detail_view ")
	            .append("             WHERE delivery_status = '배송완료' ")
	            .append("             ORDER BY payment_date DESC) a ")
	            .append("       WHERE rownum <= ?) ")
	            .append(" WHERE rnum >= ? ");
	            
	        pstmt = con.prepareStatement(selectOrder.toString());
	        pstmt.setInt(1, endNum);
	        pstmt.setInt(2, startNum);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            OrderVO oVO = new OrderVO();
	            oVO.setOrder_id(rs.getInt("order_id"));
	            oVO.setUser_id(rs.getString("user_id"));
	            oVO.setPayment_date(rs.getString("payment_date"));
	            oVO.setTotal_price(rs.getInt("total_price"));
	            oVO.setAddress(rs.getString("address"));
	            oVO.setDelivery_status(rs.getString("delivery_status"));
	            oVO.setProduct_info(rs.getString("product_info"));
	            list.add(oVO);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return list;
	}
	
	// 배송 완료된 주문 건수를 조회하는 메소드
	public int selectCompletedOrderCount() throws SQLException {
	    int totalCount = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        String selectTotal = "SELECT COUNT(*) cnt FROM order_detail_view WHERE delivery_status = '배송완료'";
	        pstmt = con.prepareStatement(selectTotal);
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            totalCount = rs.getInt("cnt");
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return totalCount;
	}
	
	// 검색 조건에 맞는 주문 건수를 조회하는 메소드
    // - 기간과 사용자 ID 기준으로 검색
	public int selectSearchCount(String startDate, String endDate, String userId) throws SQLException {
	    int totalCount = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder sql = new StringBuilder();
	        sql.append(" SELECT COUNT(DISTINCT representative_order_id) cnt ")
	           .append(" FROM order_detail_view ")
	           .append(" WHERE user_id = ? ")
	           .append(" AND payment_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') ")
	           .append(" AND TO_DATE(?, 'YYYY-MM-DD') ");
	        
	        pstmt = con.prepareStatement(sql.toString());
	        pstmt.setString(1, userId);
	        pstmt.setString(2, startDate);
	        pstmt.setString(3, endDate);
	        
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            totalCount = rs.getInt("cnt");
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return totalCount;
	}

	// 검색 조건에 맞는 주문 목록을 페이징 처리하여 조회하는 메소드
	public List<OrderVO> selectSearchOrders(String startDate, String endDate, String userId, int startNum, int endNum) throws SQLException {
	    List<OrderVO> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder sql = new StringBuilder();
	        sql.append(" SELECT * ")
	           .append(" FROM (SELECT rownum rnum, a.* ")
	           .append("       FROM (SELECT representative_order_id as order_id, ") // 수정된 부분
	           .append("                    user_id, ")
	           .append("                    TO_CHAR(payment_date, 'YYYY-MM-DD') AS payment_date, ")
	           .append("                    total_price, ")
	           .append("                    address, ")
	           .append("                    delivery_status, ")
	           .append("                    product_info ")
	           .append("             FROM order_detail_view ")
	           .append("             WHERE user_id = ? ")
	           .append("             AND payment_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') ")
	           .append("             AND TO_DATE(?, 'YYYY-MM-DD') ")
	           .append("             ORDER BY payment_date DESC) a ")
	           .append("       WHERE rownum <= ?) ")
	           .append(" WHERE rnum >= ? ");
	        
	        pstmt = con.prepareStatement(sql.toString());
	        pstmt.setString(1, userId);
	        pstmt.setString(2, startDate);
	        pstmt.setString(3, endDate);
	        pstmt.setInt(4, endNum);
	        pstmt.setInt(5, startNum);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            OrderVO oVO = new OrderVO();
	            oVO.setOrder_id(rs.getInt("order_id"));
	            oVO.setUser_id(rs.getString("user_id"));
	            oVO.setPayment_date(rs.getString("payment_date"));
	            oVO.setTotal_price(rs.getInt("total_price"));
	            oVO.setAddress(rs.getString("address"));
	            oVO.setDelivery_status(rs.getString("delivery_status"));
	            oVO.setProduct_info(rs.getString("product_info"));
	            list.add(oVO);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    return list;
	}
	
	// 특정 사용자의 가장 최근 주문 정보를 조회하는 메소드
	public OrderVO selectLastOrder(String userId) throws SQLException {
	    OrderVO lastOrder = null;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT o.order_id, o.recipient, o.recipient_phone, ")
	            .append("        o.zip_code, o.address, o.address_detail, o.request ")
	            .append(" FROM orders o ")
	            .append(" JOIN cart_product cp ON o.cart_product_id = cp.cart_product_id ")
	            .append(" WHERE cp.user_id = ? ")
	            .append(" AND o.payment_date = ( ")
	            .append("     SELECT MAX(payment_date) ")
	            .append("     FROM orders o2 ")
	            .append("     JOIN cart_product cp2 ON o2.cart_product_id = cp2.cart_product_id ")
	            .append("     WHERE cp2.user_id = ? ")
	            .append(" )");
	        
	        pstmt = con.prepareStatement(selectOrder.toString());
	        pstmt.setString(1, userId);
	        pstmt.setString(2, userId);
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            lastOrder = new OrderVO();
	            lastOrder.setOrder_id(rs.getInt("order_id"));
	            lastOrder.setRecipient(rs.getString("recipient"));
	            lastOrder.setRecipient_phone(rs.getString("recipient_phone"));
	            lastOrder.setZip_code(rs.getString("zip_code"));
	            lastOrder.setAddress(rs.getString("address"));
	            lastOrder.setAddress_detail(rs.getString("address_detail"));
	            lastOrder.setRequest(rs.getString("request"));
	            
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    
	    return lastOrder;
	}
	
	// 새로운 주문을 등록하는 메소드
	public void insertOrder(OrderVO orderVO) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;

	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder insertOrder = new StringBuilder();
	        insertOrder
	            .append(" INSERT INTO orders ")
	            .append(" (order_id, cart_product_id, payment_date, total_price, ")
	            .append(" recipient, recipient_phone, zip_code, address, address_detail, ")
	            .append(" request, delivery_status) ")
	            .append(" VALUES ")
	            .append(" (?, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?) ");

	        pstmt = con.prepareStatement(insertOrder.toString());
	        pstmt.setInt(1, orderVO.getOrder_id());  // 시퀀스 대신 전달받은 order_id 사용
	        pstmt.setInt(2, orderVO.getCart_product_id());
	        pstmt.setInt(3, orderVO.getTotal_price());
	        pstmt.setString(4, orderVO.getRecipient());
	        pstmt.setString(5, orderVO.getRecipient_phone());
	        pstmt.setString(6, orderVO.getZip_code());
	        pstmt.setString(7, orderVO.getAddress());
	        pstmt.setString(8, orderVO.getAddress_detail());
	        pstmt.setString(9, orderVO.getRequest());
	        pstmt.setString(10, orderVO.getDelivery_status());

	        pstmt.executeUpdate();
	    } finally {
	        DbConnection.getInstance().dbClose(null, pstmt, con);
	    }
	}
	
	// 특정 사용자의 가장 최근 주문 그룹 정보를 조회하는 메소드
	public OrderVO selectLastOrderGroup(String userId) throws SQLException {
	    OrderVO lastOrder = null;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT o.order_id, o.recipient, o.recipient_phone, ")
	            .append("        o.zip_code, o.address, o.address_detail, o.request ")
	            .append(" FROM orders o ")
	            .append(" JOIN cart_product cp ON o.cart_product_id = cp.cart_product_id ")
	            .append(" WHERE cp.user_id = ? ")
	            .append(" AND o.payment_date = ( ")
	            .append("     SELECT MAX(o2.payment_date) ")
	            .append("     FROM orders o2 ")
	            .append("     JOIN cart_product cp2 ON o2.cart_product_id = cp2.cart_product_id ")
	            .append("     WHERE cp2.user_id = ? ")
	            .append(" ) ")
	            .append(" AND ROWNUM = 1 ");  // 같은 주문 그룹 중 하나만 가져옴
	        
	        pstmt = con.prepareStatement(selectOrder.toString());
	        pstmt.setString(1, userId);
	        pstmt.setString(2, userId);
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            lastOrder = new OrderVO();
	            lastOrder.setOrder_id(rs.getInt("order_id"));
	            lastOrder.setRecipient(rs.getString("recipient"));
	            lastOrder.setRecipient_phone(rs.getString("recipient_phone"));
	            lastOrder.setZip_code(rs.getString("zip_code"));
	            lastOrder.setAddress(rs.getString("address"));
	            lastOrder.setAddress_detail(rs.getString("address_detail"));
	            lastOrder.setRequest(rs.getString("request"));
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    
	    return lastOrder;
	}
	
	// 다음 주문 ID를 생성하는 메소드
    // - 기존 주문 ID 중 최대값 + 1
	public int getNextOrderId() throws SQLException {
	    // 가장 큰 order_id 조회 후 +1
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int nextOrderId = 1;

	    try {
	        con = DbConnection.getInstance().getConn();
	        String sql = "SELECT NVL(MAX(order_id), 0) + 1 FROM orders";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            nextOrderId = rs.getInt(1);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    
	    return nextOrderId;
	}

	// 장바구니 상품 ID로 주문 ID를 조회하는 메소드
	public int getOrderIdByCartProductId(String cartProductId) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int orderId = -1;

	    try {
	        con = DbConnection.getInstance().getConn();
	        String sql = "SELECT order_id FROM orders WHERE cart_product_id = ?";
	        
	        System.out.println("Executing query with cart_product_id: " + cartProductId);
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, cartProductId);
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            orderId = rs.getInt("order_id");
	            System.out.println("Found order_id: " + orderId);
	        } else {
	            System.out.println("No order found for cart_product_id: " + cartProductId);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    
	    return orderId;
	}
	
	// 특정 주문 ID에 해당하는 주문 상세 정보를 조회하는 메소드
    // - 주문한 상품 정보, 배송 정보 등을 포함
	public List<OrderVO> selectOrderDetailsByOrderId(int orderId) throws SQLException {
	    List<OrderVO> orderDetails = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DbConnection.getInstance().getConn();
	        StringBuilder selectOrder = new StringBuilder();
	        selectOrder
	            .append(" SELECT o.order_id, o.cart_product_id, o.total_price, ")
	            .append("        o.recipient, o.recipient_phone, ")
	            .append("        o.zip_code, o.address, o.address_detail, ")
	            .append("        o.request, o.delivery_status, o.payment_date, ")
	            .append("        p.product_name, p.product_img, ")
	            .append("        cp.quantity ")
	            .append(" FROM orders o ")
	            .append(" JOIN cart_product cp ON o.cart_product_id = cp.cart_product_id ")
	            .append(" JOIN product p ON cp.product_id = p.product_id ")
	            .append(" WHERE o.order_id = ? ")
	            .append(" ORDER BY o.payment_date DESC ");
	            
	        pstmt = con.prepareStatement(selectOrder.toString());
	        pstmt.setInt(1, orderId);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            OrderVO order = new OrderVO();
	            order.setOrder_id(rs.getInt("order_id"));
	            order.setCart_product_id(rs.getInt("cart_product_id"));
	            order.setTotal_price(rs.getInt("total_price"));
	            order.setRecipient(rs.getString("recipient"));
	            order.setRecipient_phone(rs.getString("recipient_phone"));
	            order.setZip_code(rs.getString("zip_code"));
	            order.setAddress(rs.getString("address"));
	            order.setAddress_detail(rs.getString("address_detail"));
	            order.setRequest(rs.getString("request"));
	            order.setDelivery_status(rs.getString("delivery_status"));
	            order.setPayment_date(rs.getString("payment_date"));
	            
	            // 제품 정보 설정
	            order.setProduct_name(rs.getString("product_name"));
	            order.setProduct_img(rs.getString("product_img"));
	            order.setQuantity(rs.getInt("quantity"));
	            
	            orderDetails.add(order);
	        }
	    } finally {
	        DbConnection.getInstance().dbClose(rs, pstmt, con);
	    }
	    
	    return orderDetails;
	}
}

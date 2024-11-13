package kr.co.truetrue.user.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.dao.DbConnection;

public class CartDAO {
private static CartDAO cDAO;
	
	private CartDAO() {
		
	}
	
	public static CartDAO getInstance() {
		if(cDAO==null) {
			cDAO=new CartDAO();
		}
		return cDAO;
	}
	// 장바구니 목록 조회
	public List<CartVO> selectCartItems(String user_id) throws SQLException {
	    List<CartVO> cartItems = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn();
	        
	        StringBuilder selectCart = new StringBuilder();
	        selectCart
	            .append(" SELECT cp.cart_product_id, cp.user_id, cp.product_id, ")
	            .append(" p.product_name, p.product_img, p.price, cp.quantity, cp.order_flag ")
	            .append(" FROM cart_product cp ")
	            .append(" JOIN product p ON cp.product_id = p.product_id ")
	            .append(" WHERE cp.user_id = ? AND cp.order_flag = 'B' ")  // 주문 전 상품만 조회
	            .append(" ORDER BY cp.input_date DESC ");
	            
	        pstmt = con.prepareStatement(selectCart.toString());
	        pstmt.setString(1, user_id);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            CartVO item = new CartVO();
	            item.setCart_product_id(rs.getInt("cart_product_id"));
	            item.setUser_id(rs.getString("user_id"));
	            item.setProduct_id(rs.getInt("product_id"));
	            item.setProduct_name(rs.getString("product_name"));
	            item.setProduct_img(rs.getString("product_img"));
	            item.setPrice(rs.getInt("price"));
	            item.setQuantity(rs.getInt("quantity"));
	            item.setOrder_flag(rs.getString("order_flag"));
	            cartItems.add(item);
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }
	    
	    return cartItems;
	}
    
    // 장바구니 수량 변경
	public int updateQuantity(int cart_product_id, int quantity) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    int rowCnt = 0;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn();
	        
	        StringBuilder updateQuantity = new StringBuilder();
	        updateQuantity
	            .append(" UPDATE cart_product ")
	            .append(" SET quantity = ? ")
	            .append(" WHERE cart_product_id = ? ");
	            
	        pstmt = con.prepareStatement(updateQuantity.toString());
	        
	        pstmt.setInt(1, quantity);
	        pstmt.setInt(2, cart_product_id);
	        
	        rowCnt = pstmt.executeUpdate();
	        
	    } finally {
	        dbCon.dbClose(null, pstmt, con);
	    }
	    
	    return rowCnt;
	}
    
    // 장바구니 선택 삭제
    public int deleteCartItems(String[] cart_product_ids) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rowCnt = 0;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            
            StringBuilder deleteItems = new StringBuilder();
            deleteItems
                .append(" DELETE FROM cart_product ")
                .append(" WHERE cart_product_id IN (");
            
            for(int i = 0; i < cart_product_ids.length; i++) {
                if(i > 0) deleteItems.append(",");
                deleteItems.append("?");
            }
            deleteItems.append(")");
                
            pstmt = con.prepareStatement(deleteItems.toString());
            
            for(int i = 0; i < cart_product_ids.length; i++) {
                pstmt.setString(i + 1, cart_product_ids[i]);
            }
            
            rowCnt = pstmt.executeUpdate();
            
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }
        
        return rowCnt;
    }
    
    // 장바구니 상태 변경 (주문완료로 변경)
    public int updateOrderStatus(String[] cart_product_ids) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rowCnt = 0;
        
        try {
            con = DbConnection.getInstance().getConn();
            
            StringBuilder updateStatus = new StringBuilder();
            updateStatus
                .append(" UPDATE cart_product ")
                .append(" SET order_flag = 'A' ")  // 주문 완료 상태로 변경
                .append(" WHERE cart_product_id IN (");
            
            for(int i = 0; i < cart_product_ids.length; i++) {
                if(i > 0) updateStatus.append(",");
                updateStatus.append("?");
            }
            updateStatus.append(")");
                
            pstmt = con.prepareStatement(updateStatus.toString());
            
            for(int i = 0; i < cart_product_ids.length; i++) {
                pstmt.setString(i + 1, cart_product_ids[i]);
            }
            
            rowCnt = pstmt.executeUpdate();
            
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }
        
        return rowCnt;
    }

    public CartVO selectCartItem(String cartProductId) throws SQLException {
        CartVO item = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            
            StringBuilder selectCart = new StringBuilder();
            selectCart
                .append(" SELECT cp.cart_product_id, cp.user_id, cp.product_id, ")
                .append(" p.product_name, p.product_img, p.price, cp.quantity ")
                .append(" FROM cart_product cp ")
                .append(" JOIN product p ON cp.product_id = p.product_id ")
                .append(" WHERE cp.cart_product_id = ? ");
                
            pstmt = con.prepareStatement(selectCart.toString());
            pstmt.setString(1, cartProductId);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                item = new CartVO();
                item.setCart_product_id(rs.getInt("cart_product_id"));
                item.setUser_id(rs.getString("user_id"));
                item.setProduct_id(rs.getInt("product_id"));
                item.setProduct_name(rs.getString("product_name"));
                item.setProduct_img(rs.getString("product_img"));
                item.setPrice(rs.getInt("price"));
                item.setQuantity(rs.getInt("quantity"));
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return item;
    }
    
    public CartVO selectUserInfo(String user_id) throws SQLException {
        CartVO userInfo = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            
            StringBuilder selectUser = new StringBuilder();
            selectUser
                .append(" SELECT name, phone ")
                .append(" FROM users ")
                .append(" WHERE user_id = ? ");
                
            pstmt = con.prepareStatement(selectUser.toString());
            pstmt.setString(1, user_id);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                userInfo = new CartVO();
                userInfo.setName(rs.getString("name"));
                String phone = rs.getString("phone");
                // 전화번호를 분리하여 저장 (예: 01012345678)
                userInfo.setPhone1(phone.substring(0, 3));
                userInfo.setPhone2(phone.substring(3, 7));
                userInfo.setPhone3(phone.substring(7));
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return userInfo;
    }
    
    
}


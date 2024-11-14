package kr.co.truetrue.user.card;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.truetrue.dao.DbConnection;

public class CardDAO {
private static CardDAO cardDAO;
    
    private CardDAO() {}
    
    public static CardDAO getInstance() {
        if(cardDAO == null) {
            cardDAO = new CardDAO();
        }
        return cardDAO;
    }
    
    // 가장 최근 카드 정보 조회
    public CardVO getLatestCardInfo(String userId) throws SQLException {
        CardVO cardVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = DbConnection.getInstance().getConn();
            StringBuilder selectCard = new StringBuilder();
            selectCard
                .append(" SELECT DISTINCT c.* ")  // DISTINCT 추가
                .append(" FROM card_info c ")
                .append(" JOIN orders o ON c.order_id = o.order_id ")
                .append(" JOIN cart_product cp ON o.cart_product_id = cp.cart_product_id ")
                .append(" WHERE cp.user_id = ? ")
                .append(" AND o.payment_date = ( ")
                .append("     SELECT MAX(payment_date) ")
                .append("     FROM orders o2 ")
                .append("     JOIN cart_product cp2 ON o2.cart_product_id = cp2.cart_product_id ")
                .append("     WHERE cp2.user_id = ? ")
                .append(" ) ")
                .append(" AND ROWNUM = 1 ");  // 중복 방지를 위해 ROWNUM 추가
            
            pstmt = con.prepareStatement(selectCard.toString());
            pstmt.setString(1, userId);
            pstmt.setString(2, userId);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                cardVO = new CardVO();
                cardVO.setCard_id(rs.getInt("card_id")); 
                cardVO.setCard_num1(rs.getString("card_num1"));
                cardVO.setCard_num2(rs.getString("card_num2"));
                cardVO.setCard_num3(rs.getString("card_num3"));
                cardVO.setCard_num4(rs.getString("card_num4"));
                cardVO.setYear(rs.getString("year"));
                cardVO.setMonth(rs.getInt("month"));
                cardVO.setCard_type(rs.getString("card_type"));
                cardVO.setInstallment_type(rs.getInt("installment_type"));
                
            }
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, con);
        }
        
        return cardVO;
    }
    
    // 카드 정보 저장
    public void insertCardInfo(CardVO cardVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = DbConnection.getInstance().getConn();
            StringBuilder insertCard = new StringBuilder();
            insertCard
                .append(" INSERT INTO card_info ")
                .append(" (card_id, order_id, card_num1, card_num2, card_num3, card_num4, ")
                .append("  year, month, card_type, installment_type) ")
                .append(" VALUES (seq_card_id.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            
            pstmt = con.prepareStatement(insertCard.toString());
            pstmt.setInt(1, cardVO.getOrder_id());
            pstmt.setString(2, cardVO.getCard_num1());
            pstmt.setString(3, cardVO.getCard_num2());
            pstmt.setString(4, cardVO.getCard_num3());
            pstmt.setString(5, cardVO.getCard_num4());
            pstmt.setString(6, cardVO.getYear());
            pstmt.setInt(7, cardVO.getMonth());
            pstmt.setString(8, cardVO.getCard_type());
            pstmt.setInt(9, cardVO.getInstallment_type());
            
            pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }
    }
    
    public void updateCardInfo(CardVO cardVO) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = DbConnection.getInstance().getConn();
            StringBuilder updateCard = new StringBuilder();
            updateCard
                .append(" UPDATE card_info SET ")
                .append("     card_num1 = ?, ")
                .append("     card_num2 = ?, ")
                .append("     card_num3 = ?, ")
                .append("     card_num4 = ?, ")
                .append("     year = ?, ")
                .append("     month = ?, ")
                .append("     card_type = ?, ")
                .append("     installment_type = ? ")
                .append(" WHERE card_id = ? ");
            
            pstmt = con.prepareStatement(updateCard.toString());
            pstmt.setString(1, cardVO.getCard_num1());
            pstmt.setString(2, cardVO.getCard_num2());
            pstmt.setString(3, cardVO.getCard_num3());
            pstmt.setString(4, cardVO.getCard_num4());
            pstmt.setString(5, cardVO.getYear());
            pstmt.setInt(6, cardVO.getMonth());
            pstmt.setString(7, cardVO.getCard_type());
            pstmt.setInt(8, cardVO.getInstallment_type());
            pstmt.setInt(9, cardVO.getCard_id());
            pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }
    }
    
    public CardVO getCardInfoByOrderId(int orderId) throws SQLException {
        CardVO cardVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = DbConnection.getInstance().getConn();
            StringBuilder selectCard = new StringBuilder();
            selectCard
                .append(" SELECT card_id, order_id, card_num1, card_num2, ")
                .append("        card_num3, card_num4, year, month, ")
                .append("        card_type, installment_type ")
                .append(" FROM card_info ")
                .append(" WHERE order_id = ? ");
                
            pstmt = con.prepareStatement(selectCard.toString());
            pstmt.setInt(1, orderId);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                cardVO = new CardVO();
                cardVO.setCard_id(rs.getInt("card_id"));
                cardVO.setOrder_id(rs.getInt("order_id"));
                cardVO.setCard_num1(rs.getString("card_num1"));
                cardVO.setCard_num2(rs.getString("card_num2"));
                cardVO.setCard_num3(rs.getString("card_num3"));
                cardVO.setCard_num4(rs.getString("card_num4"));
                cardVO.setYear(rs.getString("year"));
                cardVO.setMonth(rs.getInt("month"));
                cardVO.setCard_type(rs.getString("card_type"));
                cardVO.setInstallment_type(rs.getInt("installment_type"));
            }
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, con);
        }
        
        return cardVO;
    }
}

<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.user.cart.CartDAO" %>

<%
/* 장바구니 상품 수량 업데이트하는 프로세스 */

// 장바구니 상품 ID와 변경할 수량을 파라미터로 받음
int cart_product_id = Integer.parseInt(request.getParameter("cart_product_id"));
int quantity = Integer.parseInt(request.getParameter("quantity"));

JSONObject jsonObj = new JSONObject();

try {
    CartDAO cDAO = CartDAO.getInstance();
    // 수량 업데이트 실행
    int rowCnt = cDAO.updateQuantity(cart_product_id, quantity);
    
    // 업데이트 성공 여부에 따른 상태 설정
    jsonObj.put("status", rowCnt > 0 ? "success" : "fail");
} catch(Exception e) {
    jsonObj.put("status", "error");
    jsonObj.put("message", e.getMessage());
    e.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>
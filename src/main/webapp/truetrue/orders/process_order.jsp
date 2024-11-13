<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.admin.order.OrderDAO" %>
<%@ page import="kr.co.truetrue.admin.order.OrderVO" %>
<%@ page import="kr.co.truetrue.user.cart.CartDAO" %>
<%@ page import="java.util.Arrays" %>

<%
/* 주문 처리를 담당하는 프로세스 */

// 파라미터 받기
String[] cartProductIds = request.getParameter("cartProductIds").split(",");
String receiverName = request.getParameter("receiverName");
String receiverPhone = request.getParameter("receiverPhone").replaceAll("-", "");
String zipCode = request.getParameter("zipCode");
String address = request.getParameter("address");
String addressDetail = request.getParameter("addressDetail");
String requests = request.getParameter("requests");
String totalAmount = request.getParameter("totalAmount");
String cardType = request.getParameter("cardType");

JSONObject jsonResponse = new JSONObject();

try {
    OrderDAO orderDAO = OrderDAO.getInstance();
    CartDAO cartDAO = CartDAO.getInstance();
    
    // 새로운 주문 ID 생성
    int orderId = orderDAO.getNextOrderId(); 
    
    // 장바구니의 각 상품에 대해 주문 생성
    for(String cartProductId : cartProductIds) {
        OrderVO orderVO = new OrderVO();
        
        // 주문 정보 설정
        orderVO.setOrder_id(orderId); 
        orderVO.setCart_product_id(Integer.parseInt(cartProductId));
        orderVO.setTotal_price(Integer.parseInt(totalAmount));
        orderVO.setRecipient(receiverName);
        orderVO.setRecipient_phone(receiverPhone);
        orderVO.setZip_code(zipCode);
        orderVO.setAddress(address);
        orderVO.setAddress_detail(addressDetail);
        orderVO.setRequest(requests);
        //  배송 정보 설정
        orderVO.setDelivery_status("P");// 결제 완료 상태
        // 주문 등록
        orderDAO.insertOrder(orderVO);
    }
    
    // 장바구니 상태 업데이트
    cartDAO.updateOrderStatus(cartProductIds);
    jsonResponse.put("status", "success");
    jsonResponse.put("order_id", orderId);  
    
} catch(Exception e) {
    jsonResponse.put("status", "error");
    jsonResponse.put("message", e.getMessage());
    e.printStackTrace();
}

out.print(jsonResponse.toJSONString());
%>
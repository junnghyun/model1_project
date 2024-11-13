<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.admin.order.OrderDAO" %>
<%@ page import="kr.co.truetrue.admin.order.OrderVO" %>
<%@ page import="java.util.List" %>

<%
/* 사용자의 마지막 주문 정보를 JSON형태로 반환 */
String userId = request.getParameter("user_id");
JSONObject jsonObj = new JSONObject();

try {
    OrderDAO oDAO = OrderDAO.getInstance();
    
    // 사용자의 마지막 주문 정보 조회
    // order_id로 그룹화된 주문 중 가장 최근 것을 가져옴
    OrderVO lastOrder = oDAO.selectLastOrderGroup(userId);  // 메서드 이름 변경
    
    if(lastOrder != null) {
        jsonObj.put("status", "success");
        jsonObj.put("receiverName", lastOrder.getRecipient());
        
        // 전화번호 분리
        String phone = lastOrder.getRecipient_phone();
        if(phone != null && phone.length() >= 11) {
            jsonObj.put("phone1", phone.substring(0, 3));
            jsonObj.put("phone2", phone.substring(3, 7));
            jsonObj.put("phone3", phone.substring(7));
        }
        
        // 주소 정보
        jsonObj.put("zipcode", lastOrder.getZip_code());
        jsonObj.put("address", lastOrder.getAddress());
        jsonObj.put("addr2", lastOrder.getAddress_detail());
        jsonObj.put("request", lastOrder.getRequest());
        
        // order_id도 함께 반환 (필요한 경우)
        jsonObj.put("order_id", lastOrder.getOrder_id());

    } else {
        jsonObj.put("status", "fail");
        jsonObj.put("message", "이전 주문 정보가 없습니다.");
    }
} catch(Exception e) {
    jsonObj.put("status", "error");
    jsonObj.put("message", e.getMessage());
    e.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>
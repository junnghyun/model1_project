<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="netscape.javascript.JSObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.admin.order.OrderDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%

String deliveryStatus = request.getParameter("delivery_status");
String orderId = request.getParameter("order_id");

JSONObject jsonObj = new JSONObject();

try {
    OrderVO oVO = new OrderVO();
    oVO.setDelivery_status(deliveryStatus);
    oVO.setOrder_id(Integer.parseInt(orderId));
    
    OrderDAO oDAO = OrderDAO.getInstance();
    oDAO.updateStatus(oVO);
    
    jsonObj.put("rowCnt", 1);
    
} catch(Exception e) {
    jsonObj.put("rowCnt", 0);
    e.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>
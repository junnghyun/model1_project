<%@ page contentType="application/json; charset=UTF-8" %>
<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.admin.order.OrderDAO"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>

<%
//페이징 처리
int pageScale = 10;
String pageStr = request.getParameter("page");
int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;

OrderDAO oDAO = OrderDAO.getInstance();
int totalCount = oDAO.selectCompletedOrderCount();
int totalPage = (int)Math.ceil((double)totalCount/pageScale);

int startNum = (currentPage-1) * pageScale + 1;
int endNum = startNum + pageScale - 1;
if(endNum > totalCount) endNum = totalCount;

List<OrderVO> completedOrders = oDAO.selectCompletedOrder(startNum, endNum);

//결과를 JSON으로 변환
JSONObject result = new JSONObject();
JSONArray data = new JSONArray();

for(OrderVO oVO : completedOrders) {
JSONObject obj = new JSONObject();
obj.put("order_id", oVO.getOrder_id());
obj.put("user_id", oVO.getUser_id());
obj.put("payment_date", oVO.getPayment_date());
obj.put("total_price", oVO.getTotal_price());
obj.put("address", oVO.getAddress());
obj.put("delivery_status", oVO.getDelivery_status());
obj.put("product_info", oVO.getProduct_info());
data.add(obj);
}

result.put("data", data);
result.put("totalPage", totalPage);
result.put("currentPage", currentPage);
result.put("totalCount", totalCount);
result.put("startNum", startNum);
result.put("endNum", endNum);

out.print(result.toJSONString());
%>
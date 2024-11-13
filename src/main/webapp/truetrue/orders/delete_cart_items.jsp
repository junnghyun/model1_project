<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.user.cart.CartDAO" %>
<%
/* 장바구니 상품 제거 */
String itemsStr = request.getParameter("items");
String[] itemIds = itemsStr.split(",");

JSONObject jsonObj = new JSONObject();

try {
    CartDAO cDAO = CartDAO.getInstance();
    int rowCnt = cDAO.deleteCartItems(itemIds);
    jsonObj.put("status", "success");
    jsonObj.put("deletedCount", rowCnt);
} catch(Exception e) {
    jsonObj.put("status", "error");
    jsonObj.put("message", e.getMessage());
    e.printStackTrace();
}

out.print(jsonObj.toJSONString());
%>
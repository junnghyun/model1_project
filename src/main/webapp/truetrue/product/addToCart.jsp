<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.truetrue.user.prd.UserPrdDAO" %>
<%@ page import="kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO" %>

<%
    String userId = request.getParameter("userId");
    int productId = Integer.parseInt(request.getParameter("productId"));
    
   
    userId="user1";
    
    System.out.println("User ID: " + userId);
    System.out.println("Product ID: " + productId);
    UserPrdDAO userPrdDAO = UserPrdDAO.getInstance();
    JSONObject jsonResponse = new JSONObject();
    try {
        // DAO 메서드를 호출하여 장바구니에 상품을 추가+

        userPrdDAO.addProductToCart(productId,userId);
        jsonResponse.put("success", true);  // 성공
    } catch (Exception e) {
        e.printStackTrace();
        jsonResponse.put("success", false);  // 실패
    }
    
    // JSON 형태로 응답
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(jsonResponse.toString());
    out.flush();
%>

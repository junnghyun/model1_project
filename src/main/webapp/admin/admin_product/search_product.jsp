<%@page import="kr.co.truetrue.admin.prd.AdminPrdDAO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.truetrue.admin.prd.AdminPrdVO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="application/json; charset=UTF-8"%>

<%
    String productName = request.getParameter("productName");
    AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();
    List<AdminPrdVO> filteredProducts = adminPrdDAO.searchProductsByName(productName);

    // JSON 응답 생성
    JSONArray productList = new JSONArray();
    for (AdminPrdVO product : filteredProducts) {
        JSONObject productJson = new JSONObject();
        productJson.put("product_id", product.getProduct_id());
        productJson.put("category", product.getCategory_id() == '1' ? "빵" : "케이크");
        productJson.put("product_name", product.getProduct_name());
        productJson.put("input_date", product.getInput_date().toString());  // Java Date 객체를 문자열로 변환
        productJson.put("price", product.getPrice());
        productJson.put("delete_flag", product.getDelete_flag() == 'N' ? "삭제됨" : "판매중");
        productList.add(productJson);
    }

    // JSON 형태로 응답
    JSONObject responseJson = new JSONObject();
    responseJson.put("products", productList);
    
    System.out.println(responseJson.toString());
    
    response.getWriter().write(responseJson.toString());
%>

<%@page import="kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO"%>
<%@page import="kr.co.truetrue.admin.prd.AdminPrdDAO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.truetrue.admin.prd.AdminPrdVO"%>
<%@page import="kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="application/json; charset=UTF-8"%>

<%
    AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();
    List<AdminPrdVO> allProducts = adminPrdDAO.selectAllProducts();  // 모든 제품 가져오기

    // JSON 응답 생성 
    JSONArray productList = new JSONArray();
    for (AdminPrdVO product : allProducts) {
        JSONObject productJson = new JSONObject();
        productJson.put("product_id", product.getProduct_id());
        productJson.put("category", product.getCategory_id() == '1' ? "빵" : "케이크");
        productJson.put("product_name", product.getProduct_name());
        productJson.put("input_date", product.getInput_date().toString());
        productJson.put("price", product.getPrice());
        productJson.put("delete_flag", product.getDelete_flag() == 'N' ? "삭제됨" : "판매중");
        
        // 알레르기 정보 처리
        JSONArray allergyIngredients = new JSONArray();
        for (AllergyIngredientVO ingredient : product.getAllergyIngredients()) {
            JSONObject ingredientJson = new JSONObject();
            ingredientJson.put("ingredient_name", ingredient.getIngredientName());
            allergyIngredients.add(ingredientJson);
        }
        productJson.put("allergy_ingredients", allergyIngredients);
        
        productList.add(productJson);
    }

    // JSON 형태로 응답
    JSONObject responseJson = new JSONObject();
    responseJson.put("products", productList);
    
    response.getWriter().write(responseJson.toString());
%>

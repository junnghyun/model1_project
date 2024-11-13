<%@page import="kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.truetrue.admin.prd.AdminPrdDAO,kr.co.truetrue.admin.prd.AdminPrdVO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();
    AdminPrdVO product = adminPrdDAO.selectProductById(productId);

    // 제품의 기본 정보를 JSON 객체로 생성
    JSONObject productJson = new JSONObject();
    productJson.put("product_id", product.getProduct_id());
    productJson.put("product_name", product.getProduct_name());
    productJson.put("detail", product.getDetail());
    productJson.put("total_weight", product.getTotal_weight());
    productJson.put("calories", product.getCalories());
    productJson.put("sugar", product.getSugar());
    productJson.put("protein", product.getProtein());
    productJson.put("saturated_fat", product.getSaturated_fat());
    productJson.put("sodium", product.getSodium());
    productJson.put("price", product.getPrice());
    productJson.put("category_id", String.valueOf(product.getCategory_id()));
    productJson.put("product_type", product.getProduct_type());

    // 알레르기 정보를 JSON 배열로 변환하여 추가
    JSONArray allergyArray = new JSONArray();
    List<AllergyIngredientVO> allergyIngredients = product.getAllergyIngredients();
    if (allergyIngredients != null) {
        for (AllergyIngredientVO allergy : allergyIngredients) {
            JSONObject allergyJson = new JSONObject();
            allergyJson.put("ingredient_id", allergy.getIngredientId());
            allergyJson.put("ingredient_name", allergy.getIngredientName());
            allergyArray.add(allergyJson);
        }
    }
    productJson.put("allergy_ingredients", allergyArray);

    // JSON 응답 전송
    out.print(productJson.toJSONString());
%>

<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="" %>
<%@ page import="java.util.ArrayList,kr.co.truetrue.admin.prd.AdminPrdDAO,kr.co.truetrue.admin.prd.AdminPrdVO,kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO, org.json.simple.JSONObject, org.json.simple.JSONArray, java.io.BufferedReader" %>
<%
    // JSON 데이터 읽기
    BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
	StringBuilder jsonBuilder = new StringBuilder();
	String line;
	while ((line = reader.readLine()) != null) {
	    jsonBuilder.append(line);
	}

    // JSON 파싱
    JSONObject json=(JSONObject)new JSONParser().parse(jsonBuilder.toString());

    // JSON 객체에서 데이터 추출
	int productId = Integer.parseInt((String) json.get("product_id"));  // String에서 int로 변환
	String productName = (String) json.get("product_name");
	String detail = (String) json.get("detail");
	int totalWeight = Integer.parseInt((String) json.get("total_weight"));  // String에서 int로 변환
	int calories = Integer.parseInt((String) json.get("calories"));  // String에서 int로 변환
	int sugar = Integer.parseInt((String) json.get("sugar"));  // String에서 int로 변환
	int protein = Integer.parseInt((String) json.get("protein"));  // String에서 int로 변환
	int saturatedFat = Integer.parseInt((String) json.get("saturated_fat"));  // String에서 int로 변환
	int sodium = Integer.parseInt((String) json.get("sodium"));  // String에서 int로 변환
	int price = Integer.parseInt((String) json.get("price"));  // String에서 int로 변환
	char categoryId = ((String) json.get("category_id")).charAt(0);  // char로 변환
	String productType = (String) json.get("product_type");

    
    // 알레르기 정보 배열 처리
    JSONArray allergyArray = (JSONArray) json.get("allergy_info");
    List<AllergyIngredientVO> allergyIngredients = new ArrayList<>();
    AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();  // DAO 인스턴스 생성

    for (Object ingredient : allergyArray) {
        org.json.simple.JSONObject allergyJson = (org.json.simple.JSONObject) ingredient;
        String ingredientName = (String) allergyJson.get("ingredient_name");

        // AllergyIngredientVO 생성
        AllergyIngredientVO allergyIngredientVO = new AllergyIngredientVO();
        allergyIngredientVO.setIngredientName(ingredientName);
        
        // DAO의 getIngredientIdByName() 호출하여 ingredient_id 가져오기
        int ingredientId = adminPrdDAO.getIngredientIdByName(ingredientName);
        allergyIngredientVO.setIngredientId(ingredientId);

        allergyIngredients.add(allergyIngredientVO);
    }

    // DAO를 통해 데이터베이스 업데이트 수행
    AdminPrdVO product = new AdminPrdVO();
    product.setProduct_id(productId);
    product.setProduct_name(productName);
    product.setDetail(detail);
    product.setTotal_weight(totalWeight);
    product.setCalories(calories);
    product.setSugar(sugar);
    product.setProtein(protein);
    product.setSaturated_fat(saturatedFat);
    product.setSodium(sodium);
    product.setPrice(price);
    product.setCategory_id(categoryId);
    product.setProduct_type(productType);
    product.setAllergyIngredients(allergyIngredients);

    int updateResult = adminPrdDAO.updateProduct(product);

    // 결과 반환
    response.setContentType("application/json");
    JSONObject result = new JSONObject();
    result.put("success", updateResult);
    result.put("message", updateResult!=0 ? "업데이트 성공" : "업데이트 실패");
    out.print(result.toString());
%>

<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="org.json.simple.parser.JSONParser, org.json.simple.JSONArray" %>
<%@ page import="kr.co.truetrue.admin.prd.AdminPrdDAO, kr.co.truetrue.admin.prd.AdminPrdVO, kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%
    // 1. 업로드 디렉토리 및 파일 크기 설정
    // 업로드될 경로를 설정합니다.
    String uploadDirPath = "C:/Users/user/git/model1_project/src/main/webapp/truetrue/common/images/bread";
    File saveDir = new File(uploadDirPath);
    
    // 만약 경로가 존재하지 않으면, 디렉토리를 생성합니다.
    if (!saveDir.exists()) {
        saveDir.mkdirs();
    }

    // 파일 크기 제한: 10MB
    int fileSize = 1024 * 1024 * 10;

    // 2. MultipartRequest 생성하여 파일 업로드 처리
    MultipartRequest mr = new MultipartRequest(request, saveDir.getAbsolutePath(), fileSize, "UTF-8", new DefaultFileRenamePolicy());

    // 3. 업로드된 파일명 가져오기
    String fileSystemName = mr.getFilesystemName("product_image"); // 'product_image'는 form의 파일 입력 필드 이름

    // 4. JSON 데이터 처리
    JSONObject json = (JSONObject) new JSONParser().parse(mr.getParameter("data")); // JSON 데이터는 formData로 보내진 `jsonData`에서 가져옴

    // 제품 정보 추출
    int productId = Integer.parseInt((String) json.get("product_id"));
    String productName = (String) json.get("product_name");
    String detail = (String) json.get("detail");
    int totalWeight = Integer.parseInt((String) json.get("total_weight"));
    int calories = Integer.parseInt((String) json.get("calories"));
    int sugar = Integer.parseInt((String) json.get("sugar"));
    int protein = Integer.parseInt((String) json.get("protein"));
    int saturatedFat = Integer.parseInt((String) json.get("saturated_fat"));
    int sodium = Integer.parseInt((String) json.get("sodium"));
    int price = Integer.parseInt((String) json.get("price"));
    char categoryId = ((String) json.get("category_id")).charAt(0);
    String productType = (String) json.get("product_type");

    // 알레르기 정보 처리
    JSONArray allergyArray = (JSONArray) json.get("allergy_info");
    List<AllergyIngredientVO> allergyIngredients = new ArrayList<>();
    AdminPrdDAO adminPrdDAO = AdminPrdDAO.getInstance();

    for (Object ingredient : allergyArray) {
        JSONObject allergyJson = (JSONObject) ingredient;
        String ingredientName = (String) allergyJson.get("ingredient_name");
        
        int ingredientId = adminPrdDAO.getIngredientIdByName(ingredientName);
        AllergyIngredientVO allergyIngredientVO = new AllergyIngredientVO();
        allergyIngredientVO.setIngredientId(ingredientId);
        allergyIngredientVO.setIngredientName(ingredientName);
        
        allergyIngredients.add(allergyIngredientVO);
    }

    // 제품 객체 생성 후 DB 업데이트 수행
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
    
    // 업로드된 이미지 파일 경로 설정
    if (fileSystemName != null) {
        // 저장된 이미지 파일 경로를 지정
        product.setProduct_img(fileSystemName); // 웹 경로 설정
    }

    // DB 업데이트
    int updateResult = adminPrdDAO.updateProduct(product);

    // JSON 응답 생성
    JSONObject result = new JSONObject();
    result.put("success", updateResult != 0);
    result.put("message", updateResult != 0 ? "업데이트 성공" : "업데이트 실패");
    out.print(result.toJSONString());
%>

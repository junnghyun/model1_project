package kr.co.truetrue.admin.prd;

import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.dao.DbConnection;  // DbConnection 사용
import kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO;

public class AdminPrdDAO {

private static AdminPrdDAO aDAO;
	
	private AdminPrdDAO() {
		
	}
	
	public static AdminPrdDAO getInstance() {
		if(aDAO==null) {
			aDAO=new AdminPrdDAO();
		}//end if
		return aDAO;
	}//getInstance
	
    // 1. 전체 제품 수 조회
    public int getTotalProductCount() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // DbConnection 객체 생성
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();  // 커넥션 연결
            String sql = "SELECT COUNT(*) FROM product";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);  // 연결 종료
        }
        
        return count;
    }

    // 2. 특정 카테고리의 제품 수 조회 (빵 또는 케이크)
    public int getCategoryProductCount(char categoryId) throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            String sql = "SELECT COUNT(*) FROM product WHERE category_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, String.valueOf(categoryId));
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return count;
    }

    // 3. 제품명으로 제품 검색
    public List<AdminPrdVO> searchProductsByName(String productName) throws SQLException {
        List<AdminPrdVO> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            String sql = """
                SELECT product_id, category_id, product_name, price, input_date, delete_flag
				from product
				WHERE product_name
				LIKE ?
            	""";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + productName + "%");
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                AdminPrdVO product = new AdminPrdVO();
                product.setProduct_id(rs.getInt("product_id"));
                product.setCategory_id(rs.getString("category_id").charAt(0));
                product.setProduct_name(rs.getString("product_name"));
                product.setPrice(rs.getInt("price"));
                product.setInput_date(rs.getDate("input_date"));
                product.setDelete_flag(rs.getString("delete_flag").charAt(0));
                
                productList.add(product);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        
        return productList;
    }

    public int insertProduct(AdminPrdVO product) throws SQLException {
        int insertCnt = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        PreparedStatement insertPstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();

            // 제품 기본 정보 삽입
            String sql = """
                INSERT INTO product(product_id,category_id, product_name, product_type, detail, total_weight, calories, 
                    sugar, protein, saturated_fat, sodium, price, product_img)
                VALUES (seq_product_id.NEXTVAL,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            pstmt = con.prepareStatement(sql);

            pstmt.setCharacterStream(1, new StringReader(String.valueOf(product.getCategory_id())));
            pstmt.setString(2, product.getProduct_name());
            pstmt.setString(3, product.getProduct_type());
            pstmt.setString(4, product.getDetail());
            pstmt.setInt(5, product.getTotal_weight());
            pstmt.setInt(6, product.getCalories());
            pstmt.setInt(7, product.getSugar());
            pstmt.setInt(8, product.getProtein());
            pstmt.setInt(9, product.getSaturated_fat());
            pstmt.setInt(10, product.getSodium());
            pstmt.setInt(11, product.getPrice());
            pstmt.setString(12, product.getProduct_img());

            // 제품 정보 삽입 쿼리 실행
            insertCnt = pstmt.executeUpdate();

            // seq_product_id.CURRVAL를 통해 최근 생성된 product_id를 가져옴
            String getIdSql = "SELECT seq_product_id.CURRVAL FROM dual";
            try (Statement stmt = con.createStatement();
                 ResultSet rsId = stmt.executeQuery(getIdSql)) {
                if (rsId.next()) {
                    int generatedProductId = rsId.getInt(1);
                    product.setProduct_id(generatedProductId);  // 생성된 product_id 설정
                }
            }

            // 새로운 알레르기 정보 추가
            String insertAllergySql = "INSERT INTO allergy (product_id, ingredient_id) VALUES (?, ?)";
            insertPstmt = con.prepareStatement(insertAllergySql);

            for (AllergyIngredientVO allergyIngredient : product.getAllergyIngredients()) {
                int ingredientId = allergyIngredient.getIngredientId();
                if (ingredientId > 0) {
                    insertPstmt.setInt(1, product.getProduct_id());  // 새로 생성된 product_id 사용
                    insertPstmt.setInt(2, ingredientId);
                    insertPstmt.addBatch();
                }
            }

            // 배치 실행
            insertPstmt.executeBatch();

        } finally {
            dbCon.dbClose(null, pstmt, con);
            dbCon.dbClose(null, insertPstmt, null);
            if (rs != null) rs.close(); // ResultSet을 닫아줍니다.
        }

        return insertCnt;
    }



    
    // 5. 제품 정보 수정
    public int updateProduct(AdminPrdVO product) throws SQLException {
    	int updateCnt=0;
    	
    	Connection con = null;
        PreparedStatement pstmt = null;
        PreparedStatement deletePstmt = null;
        PreparedStatement insertPstmt = null;
        
        DbConnection dbCon = DbConnection.getInstance();
        
        try {
            con = dbCon.getConn();
            
            // 제품 기본 정보 업데이트
            String sql = """
                UPDATE product
                SET category_id = ?, product_name = ?, product_type = ?, detail = ?, total_weight = ?, calories = ?, 
                    sugar = ?, protein = ?, saturated_fat = ?, sodium = ?, price = ?, product_img = ?
                WHERE product_id = ?
            """;
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, String.valueOf(product.getCategory_id()));
            pstmt.setString(2, product.getProduct_name());
            pstmt.setString(3, product.getProduct_type());  // 제품 타입 추가
            pstmt.setString(4, product.getDetail());
            pstmt.setInt(5, product.getTotal_weight());
            pstmt.setInt(6, product.getCalories());
            pstmt.setInt(7, product.getSugar());
            pstmt.setInt(8, product.getProtein());
            pstmt.setInt(9, product.getSaturated_fat());
            pstmt.setInt(10, product.getSodium());
            pstmt.setInt(11, product.getPrice());
            pstmt.setString(12, product.getProduct_img());
            pstmt.setInt(13, product.getProduct_id());
            
            updateCnt=pstmt.executeUpdate();
            
            // 기존 알레르기 정보 삭제 (기존 알레르기 정보 삭제 후 새로운 정보 추가)
            String deleteAllergySql = "DELETE FROM allergy WHERE product_id = ?";
            deletePstmt = con.prepareStatement(deleteAllergySql);
            deletePstmt.setInt(1, product.getProduct_id());
            deletePstmt.executeUpdate();
            
            // 새로운 알레르기 정보 추가
            String insertAllergySql = "INSERT INTO allergy (product_id, ingredient_id) VALUES (?, ?)";
            insertPstmt = con.prepareStatement(insertAllergySql);
            
            for (AllergyIngredientVO allergyIngredient : product.getAllergyIngredients()) {
                // AllergyIngredientVO에서 ingredient_id를 가져옵니다
                int ingredientId = allergyIngredient.getIngredientId();  // ingredient_id를 AllergyIngredientVO에서 가져옴
                System.out.println(ingredientId);
                if (ingredientId > 0) {
                    insertPstmt.setInt(1, product.getProduct_id());
                    insertPstmt.setInt(2, ingredientId);
                    insertPstmt.addBatch();  // 배치 처리
                }
            }
            
            // 배치 실행
            insertPstmt.executeBatch();
            
        } finally {
            dbCon.dbClose(null, pstmt, con);
            dbCon.dbClose(null, deletePstmt, null);
            dbCon.dbClose(null, insertPstmt, null);
        }
        return updateCnt;
    }
    
 // ingredient_name을 통해 ingredient_id를 가져오는 메서드
    public int getIngredientIdByName(String ingredientName) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int ingredientId = -1;

        DbConnection dbCon = DbConnection.getInstance();
        
        String sql = "SELECT ingredient_id FROM ingredient WHERE ingredient_name = ?";
        
        try {
            con = dbCon.getConn();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, ingredientName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                ingredientId = rs.getInt("ingredient_id");
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }
        return ingredientId;
    }

   

    // 6. 제품 삭제
    public boolean updateProductDeleteFlag(int productId) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean result = false;  // 기본값은 false (실패)

        DbConnection dbCon = DbConnection.getInstance();

        // 업데이트 쿼리문
        String sql = "UPDATE product SET delete_flag = 'N' WHERE product_id = ?";

        try {
            // 데이터베이스 연결
            con = dbCon.getConn();
            
            // PreparedStatement 준비
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);  // productId를 쿼리에 바인딩

            // 쿼리 실행
            int rowsAffected = pstmt.executeUpdate();

            // 만약 업데이트된 행이 1개 이상이면 성공
            if (rowsAffected > 0) {
                result = true;
            }
        } finally {
            // 자원 해제
            dbCon.dbClose(null, pstmt, con);
        }

        return result;  // 성공이면 true, 실패면 false
    }
    
 // 7. 모든 제품 정보를 조회하는 메서드
    public List<AdminPrdVO> selectAllProducts() throws SQLException {
        List<AdminPrdVO> products = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // DbConnection 객체 생성
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            String sql = """
                SELECT p.product_id, c.category_id, p.product_name, i.ingredient_name, 
                       p.input_date, p.price, p.delete_flag
                FROM product p
                LEFT JOIN category c ON p.category_id = c.category_id
                LEFT JOIN allergy a ON p.product_id = a.product_id
                LEFT JOIN ingredient i ON a.ingredient_id = i.ingredient_id
                ORDER BY p.product_id
            """;
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // 이전 제품 ID와 비교하기 위한 변수
            int lastProductId = -1;
            AdminPrdVO product = null;

            while (rs.next()) {
                int productId = rs.getInt("product_id");

                // 새로운 제품인 경우
                if (productId != lastProductId) {
                    // 이전 product 객체가 null이 아닐 경우 리스트에 추가
                    if (product != null) {
                        products.add(product);
                    }

                    // 새로운 제품 객체 생성 및 기본 정보 설정
                    product = new AdminPrdVO();
                    product.setProduct_id(productId);
                    product.setProduct_name(rs.getString("product_name"));
                    product.setCategory_id(rs.getString("category_id").charAt(0));
                    product.setInput_date(rs.getDate("input_date"));
                    product.setPrice(rs.getInt("price"));
                    product.setDelete_flag(rs.getString("delete_flag").charAt(0));
                    product.setAllergyIngredients(new ArrayList<>());
                    lastProductId = productId;
                }

                // 알레르기 정보가 있는 경우 리스트에 추가
                String ingredientName = rs.getString("ingredient_name");
                if (ingredientName != null) {
                    AllergyIngredientVO ingredient = new AllergyIngredientVO();
                    ingredient.setIngredientName(ingredientName);
                    product.getAllergyIngredients().add(ingredient);
                }
            }

            // 마지막 제품 객체 추가
            if (product != null) {
                products.add(product);
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);  // 자원 해제
        }

        return products;
    }
    
    // 8. 제품 아이디로 제품 정보를 조회하는 메서드
    public AdminPrdVO selectProductById(int productId) throws SQLException {
    	AdminPrdVO productDetail = null;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    // 1. JNDI 사용 객체 생성
	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        // 2. DBCP에서 Connection 얻기
	        con = dbCon.getConn();

	        // 3. 쿼리문 작성 (product, allergy, ingredient 테이블 조인)
	        String query = """
	            select p.product_id, p.category_id, p.product_name, p.product_type, 
	                   p.detail, p.product_img, p.total_weight, p.calories, p.sugar, p.protein, 
	                   p.saturated_fat, p.sodium, p.input_date, p.price, 
	                   p.delete_flag, 
	                   i.ingredient_id, i.ingredient_name
	            from product p
	            left join allergy a on p.product_id = a.product_id
	            left join ingredient i on a.ingredient_id = i.ingredient_id
	            where p.product_id = ?
	            """;

	        // 4. PreparedStatement 객체 얻기
	        pstmt = con.prepareStatement(query);

	        // 5. 바인드 변수 설정
	        pstmt.setInt(1, productId);

	        // 6. 쿼리문 실행 및 결과 얻기
	        rs = pstmt.executeQuery();

	        // 7. 결과 처리
	        List<AllergyIngredientVO> allergyIngredients = new ArrayList<>();
	        while (rs.next()) {
	            // 첫 번째 반복일 때, product 정보를 AdminPrdVO 객체에 설정
	            if (productDetail == null) {
	                productDetail = new AdminPrdVO();
	                productDetail.setProduct_id(rs.getInt("product_id"));
	                productDetail.setCategory_id(rs.getString("category_id").charAt(0));
	                productDetail.setProduct_name(rs.getString("product_name"));
	                productDetail.setProduct_type(rs.getString("product_type"));
	                productDetail.setDetail(rs.getString("detail"));
	                productDetail.setProduct_img(rs.getString("product_img"));
	                productDetail.setTotal_weight(rs.getInt("total_weight"));
	                productDetail.setCalories(rs.getInt("calories"));
	                productDetail.setSugar(rs.getInt("sugar"));
	                productDetail.setProtein(rs.getInt("protein"));
	                productDetail.setSaturated_fat(rs.getInt("saturated_fat"));
	                productDetail.setSodium(rs.getInt("sodium"));
	                productDetail.setInput_date(rs.getDate("input_date"));
	                productDetail.setPrice(rs.getInt("price"));
	                productDetail.setDelete_flag(rs.getString("delete_flag").charAt(0));
	            }

	            // 알레르기 성분 정보를 리스트에 추가
	            int ingredientId = rs.getInt("ingredient_id");
	            String ingredientName = rs.getString("ingredient_name");
	            if (ingredientName != null) {
	                allergyIngredients.add( new AllergyIngredientVO(ingredientId,ingredientName));
	            }
	        }

	        // UserPrdVO 객체에 알레르기 정보를 설정
	        if (productDetail != null) {
	            productDetail.setAllergyIngredients(allergyIngredients);
	        }
	    } finally {
	        // 8. 연결 끊기
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return productDetail;
	}  // selectProductById


    
}

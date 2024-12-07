package kr.co.truetrue.user.prd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.truetrue.dao.DbConnection;
import kr.co.truetrue.prd.algyingrdnt.AllergyIngredientVO;

public class UserPrdDAO {
	private static UserPrdDAO uDAO;
	
	private UserPrdDAO() {
		
	}
	
	public static UserPrdDAO getInstance() {
		if(uDAO==null) {
			uDAO=new UserPrdDAO();
		}//end if
		return uDAO;
	}//getInstance
	
	public List<UserPrdVO> searchProductsByName(String productName) throws SQLException {
        List<UserPrdVO> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // DB 연결 객체 가져오기
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();

            // SQL 쿼리: 제품 이름에 검색어가 포함된 제품 검색
            String sql = "SELECT p.product_id, p.category_id, p.product_name, p.product_type, p.detail, " +
                         "p.price, p.product_img, p.input_date " +
                         "FROM product p " +
                         "WHERE LOWER(p.product_name) LIKE LOWER(?)";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + productName + "%");  // 부분 검색을 위해 와일드카드 사용

            rs = pstmt.executeQuery();

            // 결과 처리
            while (rs.next()) {
                UserPrdVO product = new UserPrdVO();
                product.setProduct_id(rs.getInt("product_id"));
                product.setCategory_id(rs.getString("category_id").charAt(0));
                product.setProduct_name(rs.getString("product_name"));
                product.setProduct_type(rs.getString("product_type"));
                product.setDetail(rs.getString("detail"));
                product.setPrice(rs.getInt("price"));
                product.setProduct_img(rs.getString("product_img"));
                product.setInput_date(rs.getDate("input_date"));

                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return productList;
    }
	
	public UserPrdVO selectPrdDetail(int productId) throws SQLException {
	    UserPrdVO productDetail = null;
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
	            // 첫 번째 반복일 때, product 정보를 UserPrdVO 객체에 설정
	            if (productDetail == null) {
	                productDetail = new UserPrdVO();
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
	}  // selectPrdDetail
	
	public List<UserPrdVO> selectLatestProductsByCategory(char categoryId) throws SQLException {
	    List<UserPrdVO> latestProducts = new ArrayList<>();
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();

	        // 주어진 category_id에 해당하는 가장 최근의 5개 제품을 조회하는 쿼리
	        String query = """
	            SELECT * FROM product 
	            WHERE category_id = ? 
	            AND delete_flag = 'Y'  -- 판매중인 제품만 표시
	            ORDER BY input_date DESC 
	            FETCH FIRST 5 ROWS ONLY
	        """;

	        pstmt = con.prepareStatement(query);

	        // categoryId를 바인드 변수로 설정
	        pstmt.setString(1, String.valueOf(categoryId));

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            UserPrdVO product = new UserPrdVO();
	            product.setProduct_id(rs.getInt("product_id"));
	            product.setCategory_id(rs.getString("category_id").charAt(0));
	            product.setProduct_name(rs.getString("product_name"));
	            product.setProduct_type(rs.getString("product_type"));
	            product.setProduct_img(rs.getString("product_img"));
	            product.setDetail(rs.getString("detail"));
	            product.setTotal_weight(rs.getInt("total_weight"));
	            product.setCalories(rs.getInt("calories"));
	            product.setSugar(rs.getInt("sugar"));
	            product.setProtein(rs.getInt("protein"));
	            product.setSaturated_fat(rs.getInt("saturated_fat"));
	            product.setSodium(rs.getInt("sodium"));
	            product.setInput_date(rs.getDate("input_date"));
	            product.setPrice(rs.getInt("price"));
	            product.setDelete_flag(rs.getString("delete_flag").charAt(0));

	            latestProducts.add(product);
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return latestProducts;
	}
	
	public List<UserPrdVO> selectLatestProductsByCategoryAndType(char categoryId, String productType) throws SQLException {
	    List<UserPrdVO> latestProducts = new ArrayList<>();
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();

	        // 주어진 category_id와 product_type에 해당하는 가장 최근의 5개 제품을 조회하는 쿼리
	        String query = """
	            SELECT * FROM product 
	            WHERE category_id = ? 
	            AND product_type = ? 
	            AND delete_flag = 'Y'  -- 판매중인 제품만 표시
	            ORDER BY input_date DESC 
	            FETCH FIRST 5 ROWS ONLY
	        """;

	        pstmt = con.prepareStatement(query);

	        // categoryId와 productType을 바인드 변수로 설정
	        pstmt.setString(1, String.valueOf(categoryId));
	        pstmt.setString(2, productType);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            UserPrdVO product = new UserPrdVO();
	            product.setProduct_id(rs.getInt("product_id"));
	            product.setCategory_id(rs.getString("category_id").charAt(0));
	            product.setProduct_name(rs.getString("product_name"));
	            product.setProduct_type(rs.getString("product_type"));
	            product.setProduct_img(rs.getString("product_img"));
	            product.setDetail(rs.getString("detail"));
	            product.setTotal_weight(rs.getInt("total_weight"));
	            product.setCalories(rs.getInt("calories"));
	            product.setSugar(rs.getInt("sugar"));
	            product.setProtein(rs.getInt("protein"));
	            product.setSaturated_fat(rs.getInt("saturated_fat"));
	            product.setSodium(rs.getInt("sodium"));
	            product.setInput_date(rs.getDate("input_date"));
	            product.setPrice(rs.getInt("price"));
	            product.setDelete_flag(rs.getString("delete_flag").charAt(0));

	            latestProducts.add(product);
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return latestProducts;
	}  // selectLatestProductsByCategoryAndType

	
	public List<UserPrdVO> selectProductsByCategory(char categoryId, String productType) throws SQLException {
	    List<UserPrdVO> productList = new ArrayList<>();

	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();

	        // 기본적인 쿼리 구조, 조건이 있을 경우 추가
	        StringBuilder query = new StringBuilder("SELECT * FROM product WHERE category_id = ? AND delete_flag = 'Y'");

	        // productType이 주어졌을 경우 추가 조건을 붙여줍니다.
	        if (productType != null && !productType.isEmpty()) {
	            query.append(" AND product_type = ?");
	        }

	        pstmt = con.prepareStatement(query.toString());

	        // categoryId 바인드
	        pstmt.setString(1, String.valueOf(categoryId));

	        // productType이 있을 경우 바인드
	        if (productType != null && !productType.isEmpty()) {
	            pstmt.setString(2, productType);
	        }

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            UserPrdVO product = new UserPrdVO();
	            product.setProduct_id(rs.getInt("product_id"));
	            product.setCategory_id(rs.getString("category_id").charAt(0));
	            product.setProduct_name(rs.getString("product_name"));
	            product.setProduct_type(rs.getString("product_type"));
	            product.setProduct_img(rs.getString("product_img"));
	            product.setDetail(rs.getString("detail"));
	            product.setTotal_weight(rs.getInt("total_weight"));
	            product.setCalories(rs.getInt("calories"));
	            product.setSugar(rs.getInt("sugar"));
	            product.setProtein(rs.getInt("protein"));
	            product.setSaturated_fat(rs.getInt("saturated_fat"));
	            product.setSodium(rs.getInt("sodium"));
	            product.setInput_date(rs.getDate("input_date"));
	            product.setPrice(rs.getInt("price"));
	            product.setDelete_flag(rs.getString("delete_flag").charAt(0));

	            productList.add(product);
	        }
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return productList;
	}
	
	
	public void addProductToCart(int productId, String userId) throws SQLException {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn();

	        // 1. 사용자 ID가 유효한지 확인
	        String checkUserQuery = "SELECT user_id FROM users WHERE user_id = ?";
	        pstmt = con.prepareStatement(checkUserQuery);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();

	        if (!rs.next()) {
	            throw new SQLException("유효한 사용자 ID가 없습니다.");
	        }

//	        // 2. 카트 ID가 유효한지 확인
//	        String checkCartQuery = "SELECT cart_id FROM cart WHERE user_id = ?";
//	        pstmt = con.prepareStatement(checkCartQuery);
//	        pstmt.setString(1, userId);
//	        rs = pstmt.executeQuery();
//
//	        if (!rs.next()) {
//	            throw new SQLException("사용자의 카트가 존재하지 않습니다.");
//	        }
//
//	        int cartId = rs.getInt("cart_id");

	        // 3. 제품이 유효한지 확인
	        String checkProductQuery = "SELECT product_id FROM product WHERE product_id = ?";
	        pstmt = con.prepareStatement(checkProductQuery);
	        pstmt.setInt(1, productId);
	        rs = pstmt.executeQuery();

	        if (!rs.next()) {
	            throw new SQLException("유효한 제품 ID가 없습니다.");
	        }

	        // 4. 카트에 제품 추가 (수량을 1로 고정)
	        String addProductQuery = "INSERT INTO cart_product (cart_product_id, cart_id, user_id, product_id, quantity, order_flag) "
	                                + "VALUES (seq_cart_product_id.NEXTVAL, ?, ?, ?, 1, 'B')";
	        pstmt = con.prepareStatement(addProductQuery);
	        String numericPart = userId.replaceAll("[^\\d]", ""); // "숫자"만 남김

	        // 숫자 부분을 정수로 변환하여 pstmt에 설정
	        pstmt.setInt(1, Integer.parseInt(numericPart));
	        pstmt.setString(2, userId);
	        pstmt.setInt(3, productId);

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new SQLException("카트에 제품 추가 실패", e);
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }
	}

}//class

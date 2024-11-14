<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.prd.UserPrdVO"%>
<%@page import="kr.co.truetrue.user.prd.UserPrdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="headerAndFooter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%  

// 매개변수 받아오기
String userId = (String) session.getAttribute("userId");
String productNum = request.getParameter("productId");
String categoryId = request.getParameter("categoryId");
String pathFlag = "";

if (productNum == null) {
    productNum = "1";  // 기본값 설정
}
// DAO 인스턴스 생성 및 제품 목록 조회
UserPrdDAO userPrdDAO = UserPrdDAO.getInstance();    
int productId = Integer.parseInt(productNum);

//제품 상세 정보 조회
UserPrdVO product = null;
try {
    // 제품 상세 정보 가져오기
    product = userPrdDAO.selectPrdDetail(productId); // selectPrdDetail 메서드 호출
    	pathFlag="bread";	//이미지 경로 기본값 bread
    if(product.getCategory_id()=='2'){ // 케이크 일때 이미지 경로 cake 
    	pathFlag="cake";
    }
} catch (SQLException e) {
    e.printStackTrace();
}

//product 객체를 request에 저장
request.setAttribute("product", product);
%>
<!DOCTYPE html>
<html>

<meta charset="UTF-8">

<title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
<link rel="stylesheet" type="text/css" href="../common/css/brand.css" />
<script type="text/javascript" src="../common/js/jquery-1.8.0.min.js"></script>	
	<div>
	<jsp:include page="../common/jsp/header.jsp"/>
	</div>
<!-- container -->
<div class="container">
	<div id="content">
		<!-- //path -->
		<div class="cnt_wrap product b_fff">
			<!-- 제품상세정보 -->
			<div class="product_detail box_type1">
				<ul>
					<li>
						<div class="left_area">
							<ul>
								<li class="item_wrap">
									<span class="img">
										<img src="../common/images/<%=pathFlag %>/<%= product.getProduct_img() %>" onerror='this.src="/static/images/common/img_none.png"' alt="<%= product.getProduct_name() %>" width="350" height="350" />
									</span>
									<div class="p_desc1">* 상기 이미지는 실제 제품과 다소 차이가 있을 수 있습니다.</div>
									
									<div class="p_desc2">
										<ul>
											<li class="tit">제품설명</li>
											<li><%= product.getDetail() %></li>
										</ul>
									</div>
								</li>
							</ul>
						</div>
						<div class="right_area" style="margin:80px;">
							<div class="info">
								<span class="name"><%= product.getProduct_name() %></span>
								<span class="txt_shape"><%= product.getPrice() %>원</span>

							</div>
							<div class="table_nutrition">
								<table summary="1회 제공량(108g) 당 열량, 당류, 단백질, 포화지방, 나트륨 정보를 제공합니다.">
									<caption>영양성분</caption>
									<thead>
										<tr>
											<th scope="row" rowspan="4">영양성분</th>
										
											<td>총중량(g)  <%= product.getTotal_weight() %></td>
										
										</tr>
										
										<tr>
											<td>총제공중량(회) 1</td>
										</tr>
										
										<tr>
											<td>1회 제공량(개) 1</td>
										</tr>
										
										<tr>
											<td>중량(g)  <%= product.getTotal_weight() %></td>
										</tr>
										
									</thead>
									<tbody>
										
										<tr>
											<th scope="row" class="first">열량(kcal)</th>
											<td class="first">690</td>
										</tr>
										
										<tr>
											<th scope="row">당류(g/%)</th><!-- 2023-07-05 -->
											<td><%= product.getSugar() %>g / <%= (int) ((product.getSugar() / 100.0) * 100) %>%</td>
										</tr>
										
										<tr>
											<th scope="row">단백질(g/%)</th>
											<td><%= product.getProtein() %>g / <%= (int) ((product.getProtein() / 55.0) * 100) %>%</td>
										</tr>
										
										<tr>
											<th scope="row">포화지방(g/%)</th>
											<td><%= product.getSaturated_fat() %>g / <%= (int) ((product.getSaturated_fat() / 15.0) * 100) %>%</td>
										</tr>
										
										<tr>
											<th scope="row" class="last">나트륨(mg/%)</th>
											<td><%= product.getSodium() %>mg / <%= (int) ((product.getSodium() / 2000.0) * 100) %>%</td>
										</tr>
										

										<!-- 2023-07-05 추가 S //-->
										<tr>
											<td colspan="2">* %영양소기준치 : 1일 영양성분 기준치에 대한 비율</td>
										</tr>
										<!-- 2023-07-05 E //-->

										
										<tr class="is-allergy">
											<th scope="row" class="last">알레르기 정보</th>
											<td class="last">
												<c:forEach var="allergy" items="${product.allergyIngredients}" varStatus="status">
                                                    <span>${allergy.ingredientName}</span>
                                                    <c:if test="${!status.last}">
												        , 
												    </c:if>
                                                </c:forEach>
                                                함유
											</td>
										</tr>
										
									</tbody>
								</table>
							</div>
							<!-- 201607 start -->
							<div class="btn-area">
								<a href="javascript:history.back()" class="btn large st8">목록</a>
								<a href="javascript:putCart(${product.product_id},'<%=userId %>');" class="btn large st8">장바구니 담기</a>
							</div>
						
							
							<!-- //201607 end -->
						</div>
					</li>
				</ul>
			</div>
			<!-- //제품상세정보 -->
		
		</div>
	</div>
</div>
<script type="text/javascript">
function putCart(productId,userId){
	$.ajax({
        url: 'addToCart.jsp',  // JSP 경로
        type: 'POST',
        data: {
            productId: productId,
            userId: userId
        },
        success: function(response) {
			
            if (response.success) {
                alert("장바구니에 상품이 담겼습니다.");
            } else {
                alert("장바구니 추가에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function() {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}
</script>
	<div>
	<jsp:include page="../common/jsp/footer.jsp"/>
	</div>
	
</body>
</html>
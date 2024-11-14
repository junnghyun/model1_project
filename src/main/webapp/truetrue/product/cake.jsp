<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.prd.UserPrdDAO"%>
<%@page import="kr.co.truetrue.user.prd.UserPrdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="headerAndFooter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<%
// 매개변수 받아오기
String productType = request.getParameter("productType");
char categoryId = '2'; // 케이크 카테고리 ID (예시로 '2'을 사용)

// DAO 인스턴스 생성 및 제품 목록 조회
UserPrdDAO userPrdDAO = UserPrdDAO.getInstance();
List<UserPrdVO> productList = new ArrayList<>();
List<UserPrdVO> productLatestList = new ArrayList<>(); // 카테고리 내 최신 5개 제품 목록
List<UserPrdVO> productTypeList = new ArrayList<>(); // 제품 타입에 해당하는 빵 목록
List<UserPrdVO> productTypeLatestList = new ArrayList<>(); // 제품 타입별 최신 5개 빵 제품 목록

try {
    // 1. 케이크 카테고리의 전체 제품에 대한 조회
    productList = userPrdDAO.selectProductsByCategory(categoryId, null);

    // 2. 케이크 카테고리의 전체 제품에 대한 최신 5개 제품 조회
    productLatestList = userPrdDAO.selectLatestProductsByCategory(categoryId);

    // 3. 제품 타입에 따른 케이크 조회
    if (productType != null && !productType.isEmpty()) {
        productTypeList = userPrdDAO.selectProductsByCategory(categoryId, productType);
    } else {
        // 제품 타입이 없을 경우, 전체 제품 리스트는 사용
        productTypeList = productList;
    }

    // 4. 제품 타입에 따른 최신 5개 케이크 제품 조회
    if (productType != null && !productType.isEmpty()) {
        productTypeLatestList = userPrdDAO.selectLatestProductsByCategoryAndType(categoryId, productType);
    } else {
        // 제품 타입이 없을 경우, 최신 5개 제품 리스트 사용
        productTypeLatestList = productLatestList;
    }

    // 요청 속성에 리스트 설정
    request.setAttribute("productList", productList); // 전체 제품
    request.setAttribute("productLatestList", productLatestList); // 카테고리 내 최신 5개 제품
    request.setAttribute("productTypeList", productTypeList); // 제품 타입에 해당하는 빵
    request.setAttribute("productTypeLatestList", productTypeLatestList); // 제품 타입별 최신 5개 빵 제품
   

    // 출력된 리스트 확인 (디버그용)
    System.out.println("케이크 카테고리 전체 제품 목록: " + productList.size());
    System.out.println("케이크 카테고리 최신 5개 제품: " + productLatestList.size());
    System.out.println("제품 타입별 케이크 목록: " + productTypeList.size());
    System.out.println("제품 타입별 최신 5개 케이크 제품: " + productTypeLatestList.size());
    System.out.println("파라미터: " + productType);

} catch (SQLException e) {
    e.printStackTrace();
    // 오류 발생 시 빈 리스트 반환
    productList = new ArrayList<>();
    productLatestList = new ArrayList<>();
    productTypeList = new ArrayList<>();
    productTypeLatestList = new ArrayList<>();
}
%>
<!DOCTYPE html>
<html>

<meta charset="UTF-8">

<title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
<link rel="stylesheet" type="text/css" href="../common/css/brand.css" />
<script type="text/javascript" src="../common/js/jquery-1.8.0.min.js"></script>	
	<div>
	<jsp:include page="../common/jsp/header.jsp"/>
	<div class="page_top">
		<div class="path"></div>
		<h2 class="page_title"><span class="tit_cake">케이크</span></h2>
	</div>
	</div>
	<!-- container -->
<div class="container">
	<div id="content">
		<div class="cnt_wrap product" id="skip_cnt">
			<div class="top_area">
				<!-- 홈페이지 플로팅 -->

				<!-- sort -->
				<div class="sort">
					<span class="lb_bread">Cake</span>
					<ul>
			            <li><a href="cake.jsp?productType=" class='<%= (productType == null || productType.isEmpty())? "on" : "" %>' title='선택됨'><span>전체</span></a></li>
			            <li><a href="cake.jsp?productType=생크림케이크" class='<%= "생크림케이크".equals(productType) ? "on" : "" %>'><span>생크림케이크</span></a></li>
			            <li><a href="cake.jsp?productType=캐릭터케이크" class='<%= "캐릭터케이크".equals(productType) ? "on" : "" %>'><span>캐릭터케이크</span></a></li>
			            <li><a href="cake.jsp?productType=조각케이크" class='<%= "조각케이크".equals(productType) ? "on" : "" %>'><span>조각케이크</span></a></li>
					</ul>
				</div>
				<!-- //sort -->

				<!-- 20160808 배너링크 수정 -->
				<div class="img_mobile_gift">
				

					<a href="/shop/shopping/goodsList.asp?cate=13&ordType=B" target="_blank" title="새창 열림"><img src="../common/images/shopping_basket.png" alt="장바구니" /></a>
				</div>
				<!-- //20160808 배너링크 수정 -->

				<!-- 추천제품 -->
				<!-- <div class="recomm product_list2"> -->

				<div class="recomm product_list2" style="overflow:visible;"><!-- 2015-06-11 스타일추가 -->

					<span class="lb_recomm"><img src="../common/images/lb_recomm.png" alt="신규제품"></span>
					    <ul class="left_area">
        <!-- left_area에 하나의 제품 표시 -->
        <c:if test="${not empty productTypeLatestList}">
            <li class="item_wrap">
                <a href="#">
                    <span class="img">
                        <img src="../common/images/cake/${productTypeLatestList[0].product_img}" alt="${productTypeLatestList[0].product_name}" />
                        <span class="lb_best3">Best</span> <!-- 필요에 따라 Best, New 등을 설정할 수 있습니다. -->
                    </span>
                    <span class="info">
                        <span class="name">${productTypeLatestList[0].product_name}</span>
                        <span class="txt_shape">${productTypeLatestList[0].price}원</span>
                    </span>
                </a>
                <!-- Over -->
                <span class="over">
                    <span class="desc">
                        <a href="javascript:viewDetail('${productTypeLatestList[0].product_id}');">${productTypeLatestList[0].detail}</a>
                    </span>
                    <span class="btn_more2">
                        <a href="javascript:viewDetail('${productTypeLatestList[0].product_id}');" class="btn st1" title="${productTypeLatestList[0].product_name}">MORE</a>
                    </span>
                </span>
                <!-- //Over -->
            </li>
        </c:if>
    </ul>
<ul class="right_area">
        <!-- right_area에 4개의 제품 표시 -->
        <c:forEach var="prd" items="${productTypeLatestList}" begin="1" end="4">
            <li class="item_wrap">
                <a href="#">
                    <span class="img">
                        <img src="../common/images/cake/${prd.product_img}" onerror='this.src="/static/images/common/img_none.png"' alt="${prd.product_name}" width="160" height="158" />
                        <span class="lb_best2">Best</span> <!-- 필요에 따라 Best, New 등을 설정할 수 있습니다. -->
                    </span>
                    <span class="info">
                        <span class="name">${prd.product_name}</span>
                        <span class="txt_shape">${prd.price}원</span>
                    </span>
                </a>
                <!-- Over -->
                <span class="over">
                    <span class="desc">
                        <a href="javascript:viewDetail('${prd.product_id}');">${prd.detail}</a>
                    </span>
                    <span class="btn_more2">
                        <a href="javascript:viewDetail('${prd.product_id}');" class="btn st1" title="${prd.product_name}">MORE</a>
                    </span>
                </span>
                <!-- //Over -->
            </li>
        </c:forEach>
    </ul>
				</div>
				<!-- //추천제품 -->
			</div>
			
			<!-- product_list -->
			<div class="product_list2">
				<ul id="product_list">

			<c:forEach var="product" items="${productTypeList}">
			            <li class="item_wrap" id="p${product.product_id}">
			                <a href="#o${product.product_id}">
			                    <span class="info">
			                        <span class="name">${product.product_name}</span>
			                        <span class="txt_shape">${product.price}원</span>
			                    </span>
			                    <span class="img">
			                        <img src="../common/images/cake/${product.product_img}" alt="${product.product_name}" width="160" height="160" />
			                    </span>
			                </a>
			                <!-- 상세정보 -->
			                <span class="over" id="o${product.product_id}">
			                    <span class="info">
			                        <span class="name">${product.product_name}</span>
			                        <span class="txt_shape">${product.price}원</span>
			                    </span>
			                    <span class="desc">
			                        <a href="javascript:viewDetail(${product.product_id},<%= categoryId%>);">${product.detail}</a>
			                    </span>
			                </span>
			            </li>
			        </c:forEach>
				</ul>
			</div>
			<!-- //product_list -->
		</div>
	</div>
</div>
<!-- //container -->

<script type="text/javascript">

function viewDetail(productId,categoryId){
	location.href = "prd_detail.jsp?productId="+productId+"&categoryId="+categoryId;
}
</script>

	<div>
	<jsp:include page="../common/jsp/footer.jsp"/>
	</div>
	
</body>
</html>
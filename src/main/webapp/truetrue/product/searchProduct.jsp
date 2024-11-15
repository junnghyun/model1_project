<%@page import="kr.co.truetrue.user.prd.UserPrdVO"%>
<%@page import="kr.co.truetrue.user.prd.UserPrdDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="searchProduct"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // 검색어 파라미터 받아오기
    String prodName = request.getParameter("prod_name");

    // 검색어가 비어있으면 모든 제품을 표시하거나, 검색어가 필요하다는 메시지 출력
    List<UserPrdVO> productList = null;
    if (prodName != null && !prodName.isEmpty()) {
        UserPrdDAO userPrdDAO = UserPrdDAO.getInstance();
        productList = userPrdDAO.searchProductsByName(prodName);
        request.setAttribute("productList", productList);
        
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
    <link rel="stylesheet" type="text/css" href="../common/css/brand.css" />
    <script type="text/javascript" src="../common/js/jquery-1.8.0.min.js"></script>    
</head>
<body>
    <div>
        <jsp:include page="../common/jsp/header.jsp"/>
        <div class="page_top">
            <div class="path"></div>
            <h2 class="page_title"><span class="tit_srch_result">검색결과</span></h2>
        </div>
        <!-- container -->
        <div class="container">
            <div id="content">
                <div class="cnt_wrap product" id="skip_cnt">
                    <div class="srch_result">
                        <ul>
                            <li>
                                "<%=prodName %>"에 대한 검색 결과 총 <%= (productList != null ? productList.size() : 0) %>건 입니다.
                            </li>
                        </ul>
                    </div>
                    <!-- product_list -->
                    <div class="product_list2">
                        <ul id="product_list">
                            <c:choose>
                                <c:when test="${not empty productList}">
                                    <c:forEach var="product" items="${productList}">
                                        <li class="item_wrap">
                                            <a href="javascript:viewDetail('${product.product_id}');">
                                                <span class="info">
                                                    <span class="name">${product.product_name}</span>
                                                    <span class="txt_shape">${product.price}원</span>
                                                </span>
                                                <span class="img">
                                                    <img src="${pageContext.request.contextPath}/truetrue/common/images/bread/${product.product_img}" 
                                                         onerror='this.src="/static/images/common/img_none.png"' 
                                                         alt="${product.product_name}" width="160" height="160" />
                                                    <c:if test="${product.input_date != null}">
                                                    </c:if>
                                                </span>
                                            </a>
                                            <!-- Over -->
                                            <span class="over">
                                                <span class="info">
                                                    <span class="name">${product.product_name}</span>
                                                    <span class="txt_shape">${product.product_type}</span>
                                                </span>
                                                <span class="desc">
                                                    <a href="javascript:viewDetail('${product.product_id}');">
                                                        ${product.detail}
                                                    </a>
                                                </span>
                                                <span class="btn_more2">
                                                    <a href="javascript:viewDetail('${product.product_id}');" class="btn st1">MORE</a>
                                                </span>
                                            </span>
                                            <!-- //Over -->
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>검색 결과 없습니다.</p>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <!-- //product_list -->
                </div>
            </div>
        </div>
        
        <!-- //container -->
        <jsp:include page="../common/jsp/footer.jsp"/>
    </div>
    <script type="text/javascript">
    function viewDetail(productId){
    	location.href = "prd_detail.jsp?productId="+productId;
    }
</script>
</body>
</html>

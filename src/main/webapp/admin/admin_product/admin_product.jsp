<%@page import="kr.co.truetrue.admin.prd.AdminPrdVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.truetrue.admin.prd.AdminPrdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/session_chk.jsp" %>
<%
	AdminPrdDAO adminPrdDAO=AdminPrdDAO.getInstance();
	List<AdminPrdVO> productList = adminPrdDAO.selectAllProducts();

	int totalCount=adminPrdDAO.getTotalProductCount();
	int breadCount=adminPrdDAO.getCategoryProductCount('1');
	int cakeCount=adminPrdDAO.getCategoryProductCount('2');
	
	
%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>관리자 제품관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css?after">
<link rel="stylesheet" type="text/css" href="css/admin_product.css?after">
<script src="js/admin_product.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>제품관리</h1>
<div class="product-summary">
	<div class="total-products">
    	<span>총 제품 수:</span>
        <strong id="total-count"><%=totalCount %></strong>
    </div>
    <div class="total-stock">
        <span>빵:</span>
        <strong id="total-stock"><%=breadCount %></strong>
    </div>
    <div class="total-categories">
        <span>케이크:</span>
        <strong id="total-categories"><%=cakeCount %></strong>
    </div>
</div>
<div class="order-management">
<div class="product-filter">
    <input type="text" placeholder="제품명 검색" class="filter-input" id="product-name">
    <button class="filter-btn" onclick="searchProducts()">검색</button>
    <button class="reset-btn" onclick="resetFilters()">초기화</button>
    <button class="add-product-btn" onclick="openAddProductModal()">제품 정보 추가</button>
</div>
				
<table class="product-table">
    <thead>
        <tr>
            <th style="width: 150px;">제품 ID</th>
            <th style="width: 150px;">카테고리명</th>
            <th style="width: 200px;">제품명</th>
            <th style="width: 120px;">입력일</th>
            <th style="width: 100px;">가격</th>
            <th style="width: 90px;">제품 상태</th>
            <th style="width: 150px;">
            	<div>
				    <span>관리</span>
				</div>
            </th>
        </tr>
    </thead>
    <tbody>
   		 <% 
            for (AdminPrdVO product : productList) { 
         %>
           <tr>
                <td><%= product.getProduct_id() %></td>
                <td><%= product.getCategory_id()=='1'?"빵" : "케이크" %></td>
                <td><%= product.getProduct_name() %></td>
                <td><%= product.getInput_date() %></td>
                <td><%= product.getPrice() %>원</td>
                <td><%= product.getDelete_flag()=='N' ? "삭제됨" : "판매중" %></td>
            	<td>
              		<button class="action-btn" onclick="openEditProductModal(<%=product.getProduct_id()%>)">편집</button>
              		<button class="action-btn delete-btn" onclick="deleteProduct(<%=product.getProduct_id()%>)">삭제</button>
          		</td>
       	   </tr>
        <% 
            } 
        %>
    </tbody>
</table>
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>1/1</span>
    <button class="next-page">▶</button>
</div>
</div>
 
<div id="editProductModal" style="display: none;">
    <jsp:include page="product_edit_modal.jsp" />
</div>
<div id="addProductModal" style="display: none;">
    <jsp:include page="product_add_modal.jsp" />
</div>
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>
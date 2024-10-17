<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>제품관리</h1>
<div class="product-summary">
	<div class="total-products">
    	<span>총 제품 수:</span>
        <strong id="total-count">null</strong>
    </div>
    <div class="total-stock">
        <span>빵:</span>
        <strong id="total-stock">null</strong>
    </div>
    <div class="total-categories">
        <span>케이크:</span>
        <strong id="total-categories">null</strong>
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
            <th>제품 ID</th>
            <th>카테고리명</th>
            <th>제품명</th>
            <th>알레르기정보</th>
            <th>입력일</th>
            <th>가격</th>
            <th>
            	<div class="pagination">
				    <button class="prev-page">◀</button>
				    <span>null / null</span>
				    <button class="next-page">▶</button>
				</div>
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <button class="action-btn" onclick="openEditProductModal('PROD001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteProduct('PROD001')">삭제</button>
            </td>
        </tr>
        <!-- 추가 제품 항목은 여기 추가 -->
    </tbody>
</table>
			
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>null / null</span>
    <button class="next-page">▶</button>
</div>
</div>

<div id="editProductModal" style="display: none;">
    <jsp:include page="product_edit_modal.jsp" />
</div>
<div id="addProductModal" style="display: none;">
    <jsp:include page="product_add_modal.jsp" />
</div>
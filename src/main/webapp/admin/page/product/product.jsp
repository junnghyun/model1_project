<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>제품관리</h1>
<div class="product-summary">
	<div class="total-products">
    	<span>총 제품 수:</span>
        <strong id="total-count">10</strong>
    </div>
    <div class="total-stock">
        <span>총 재고 수:</span>
        <strong id="total-stock">8</strong>
    </div>
    <div class="total-categories">
        <span>카테고리 수:</span>
        <strong id="total-categories">2</strong>
    </div>
</div>
			
<div class="product-filter">
    <input type="text" placeholder="제품명 검색" class="filter-input" id="product-name">
    <button class="filter-btn" onclick="searchProducts()">검색</button>
    <button class="reset-btn" onclick="resetFilters()">초기화</button>
</div>
			
<table class="product-table">
    <thead>
        <tr>
            <th>제품 ID</th>
            <th>카테고리번호</th>
            <th>제품명</th>
            <th>설명</th>
            <th>총중량</th>
            <th>열량</th>
            <th>당류</th>
            <th>단백질</th>
            <th>나트륨</th>
            <th>알레르기정보</th>
            <th>입력일</th>
            <th>가격</th>
            <th>제품이미지</th>
            <th>액션</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>PROD001</td>
            <td>고성능 노트북</td>
            <td>전자기기</td>
            <td>1,500,000원</td>
            <td>5</td>
            <td>삼성전자</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <button class="action-btn" onclick="editProduct('PROD001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteProduct('PROD001')">삭제</button>
            </td>
        </tr>
        <!-- 추가 제품 항목은 여기 추가 -->
    </tbody>
</table>
			
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>1 / 10</span>
    <button class="next-page">▶</button>
</div>
			    
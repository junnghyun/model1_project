<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
<link rel="stylesheet" type="text/css" href="css/admin_orders.css">
<script src="js/admin_orders.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>주문관리</h1>
<div class="order-management">
    <div class="order-header">
    	<div class="order-button">
	        <button class="new-order-btn">신규 주문 내역</button>
	        <button class="previous-order-btn">이전 주문 내역</button>
        </div>
        <div class="date-range">
            <label for="date-range">거래기간:</label>
            <input type="date" id="start-date">
            <span>~</span>
            <input type="date" id="end-date">
            
            <input type="text" placeholder="상품명 검색" class="search-bar">
        	<button class="search-btn">검색</button>
        </div>
    </div>
    
    <table class="order-table">
        <thead> 
            <tr>
                <th>주문 ID</th>
                <th>고객 ID</th>
                <th>결제일</th>
                <th>결제금액</th>
                <th>주문주소</th>
                <th>주문상태</th>
                <th style="width: 230px;">
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
        		<button class="action-btn" id="start_btn" onclick="editProduct('PROD001')">배송 시작</button>
        		<button class="action-btn" onclick="editProduct('PROD001')">배송 완료</button>
                <button class="action-btn delete-btn" onclick="deleteProduct()">취소</button>
        	</td>
        </tr>
        </tbody>
    </table>
    <div class="pagination">
        <button class="prev-page">◀</button>
        <span>null / null</span>
        <button class="next-page">▶</button>
    </div>
</div>
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>
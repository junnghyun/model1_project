<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <th>요구사항</th>
                <th>총주문금액</th>
                <th>주문우편번호</th>
                <th>주문주소</th>
                <th>주문상세주소</th>
                <th>주문상태</th>
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
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td>
        		<button class="action-btn" onclick="editProduct('PROD001')">완료</button>
                <button class="action-btn delete-btn" onclick="deleteProduct('PROD001')">취소</button>
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
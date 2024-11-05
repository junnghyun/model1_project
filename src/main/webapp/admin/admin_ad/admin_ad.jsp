<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_광고관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css?after">
<link rel="stylesheet" type="text/css" href="css/admin_ad.css?after">
<script src="js/admin_ad.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>광고관리</h1>
<div class="ad-summary">
    <div class="ad-active">
        <span>활성광고 : </span>
        <span class="ad-count">null</span> <!-- 활성 광고 수 -->
    </div>
    <div class="total-impressions">
        <span>총 수익 : </span>
        <span class="total-amount">null</span> <!-- 총 수익 -->
    </div>
    <div class="total-clicks">
        <span>활성광고 클릭 수 : </span>
        <span class="total-clicks-count">null</span> <!-- 총 클릭 수 -->
    </div>
</div>
<div class="order-management">
<div class="ad-filter">
    <input type="text" placeholder="광고 검색" class="search-bar">
    <button class="search-btn">검색</button>
    <div class="add-ad-btn">
	    <button class="csv-download-btn">Excel로 다운로드</button>
	    <button class="ad-btn" onclick="openAddAdModal()">광고 추가</button>
    </div> 
</div>
			
<table class="ad-table">
    <thead>
        <tr>
            <th>광고번호</th>
            <th style="width: 150px;">광고 기간</th>
            <th style="width: 180px;">광고주 이름</th>
            <th>광고주 연락처</th>
            <th>광고비용</th>
            <th>클릭 수</th>
            <th style="width: 150px;">입력일</th>
            <th style="width: 100px;">광고상태</th>
            <th style="width: 150px;">
            	<div class="pagination">
				    <button class="prev-page">◀</button>
				    <span>null / null</span>
				    <button class="next-page">▶</button>
				</div>
            </th>
        </tr>
    </thead>
    <tbody>
        <!-- 추가 광고 항목은 여기 추가 -->
        <tr>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        	<td>
        		<button class="edit-btn" onclick="openEditAdModal('PROD001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteProduct()">종료</button>
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
<div id="editAdModal" style="display: none;">
    <jsp:include page="ad_edit_modal.jsp" />
</div>
<div id="adModal" style="display: none;">
    <jsp:include page="ad_modal.jsp" />
</div>
</body>
</html>
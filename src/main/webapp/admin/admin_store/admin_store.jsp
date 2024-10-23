<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 매장관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css?after">
<link rel="stylesheet" type="text/css" href="css/admin_store.css">
<script src="js/admin_store.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>매장관리</h1>
<div class="store-summary">
    <span>매장 수: <strong id="store-count">null</strong></span>	<!-- 매장 수 -->
</div>
<div class="order-management">
<div class="store-filter">
    <input type="text" placeholder="매장명 검색" class="filter-input" id="store-name">
    <button class="filter-btn" onclick="searchStores()">검색</button>
    <button class="reset-btn" onclick="resetFilters()">초기화</button>
    <div class="add-store-btn">
	    <button class="csv-download-btn">Excel로 다운로드</button>
	    <button class="store-btn" onclick="openStoreAddModal()">매장 정보 추가</button>
    </div>
</div>
			
<table class="store-table">
    <thead>
        <tr>
            <th style="width: 250px;">매장명</th>
            <th style="width: 250px;">매장연락처</th>
            <th style="max-width: 250px;">주소</th>
            <th style="width: 100px;">매장상태</th>
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
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <button class="action-btn" onclick="openStoreEditModal('STORE001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteStore()">삭제</button>
            </td>
        </tr>
        <!-- 추가 매장 항목은 여기 추가 -->
    </tbody>
</table>
			
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>null / null</span>
    <button class="next-page">▶</button>
</div> 
</div>
<jsp:include page="store_edit_modal.jsp" />
<jsp:include page="store_add_modal.jsp" />
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>
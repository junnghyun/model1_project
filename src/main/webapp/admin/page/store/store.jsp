<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>매장관리</h1>
<div class="store-summary">
    <span>매장 수: <strong id="store-count">1</strong></span>
</div>
			
<div class="store-filter">
    <input type="text" placeholder="매장명 검색" class="filter-input" id="store-name">
    <button class="filter-btn" onclick="searchStores()">검색</button>
    <button class="reset-btn" onclick="resetFilters()">초기화</button>
    <button class="csv-download-btn">Excel로 다운로드</button>
</div>
			
<table class="store-table">
    <thead>
        <tr>
            <th>주소</th>
            <th>매장명</th>
            <th>매장연락처</th>
            <th>영업시간</th>
            <th>네이버평점</th>
            <th>위도</th>
            <th>경도</th>
            <th>액션</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>STORE001</td>
            <td>강남 매장</td>
            <td>서울시 강남구</td>
            <td>010-1234-5678</td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <button class="action-btn" onclick="editStore('STORE001')">편집</button>
                <button class="action-btn delete-btn" onclick="deleteStore('STORE001')">삭제</button>
            </td>
        </tr>
        <!-- 추가 매장 항목은 여기 추가 -->
    </tbody>
</table>
			
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>1 / 1</span>
    <button class="next-page">▶</button>
</div>
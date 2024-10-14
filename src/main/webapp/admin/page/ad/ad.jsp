<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>광고관리</h1>
<div class="ad-summary">
    <div class="ad-active">
        <span>활성광고</span>
        <span class="ad-count">1</span> <!-- 활성 광고 수 -->
    </div>
    <div class="total-impressions">
        <span>총 수익</span>
        <span class="total-amount">5,200</span> <!-- 총 수익 -->
    </div>
    <div class="total-clicks">
        <span>총 클릭 수</span>
        <span class="total-clicks-count">1,040</span> <!-- 총 클릭 수 -->
    </div>
</div>
<div class="ad-tit">	
<div class="ad-filter">
    <input type="text" placeholder="광고 검색" class="search-bar">
    <button class="search-btn">검색</button>
    <button class="csv-download-btn">Excel로 다운로드</button>
</div>
			
<table class="ad-table">
    <thead>
        <tr>
            <th><input type="checkbox" id="select-all"></th>
            <th>광고번호</th>
            <th>광고기간</th>
            <th>광고 시작일</th>
            <th>광고 종료일</th>
            <th>광고주 이름</th>
            <th>광고 내용</th>
            <th>광고주 연락처</th>
            <th>광고이미지</th>
            <th>광고비용</th>
            <th>클릭 수</th>
            <th>입력일</th>
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
        	<td></td>
        	<td></td>
        	<td></td>
        	<td></td>
        </tr>
    </tbody>
</table>
			
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>1 / 10</span>
    <button class="next-page">▶</button>
</div>
</div>
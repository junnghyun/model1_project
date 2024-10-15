<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>회원관리</h1>
<div class="member-summary">
    <span>회원 수: <strong id="member-count">null</strong></span>
</div>

<div class="order-management">	
<div class="product-filter">
    <input type="text" placeholder="회원 ID or 이름 검색" class="filter-input" id="product-name">
    <button class="filter-btn" onclick="searchProducts()">검색</button>
    <button class="reset-btn" onclick="resetFilters()">초기화</button>
    
</div>
    
<table class="member-table">
    <thead>
        <tr>
            <th>회원 ID</th>
            <th>이름</th>
            <th>비밀번호</th>
            <th>생년월일</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>우편번호</th>
            <th>주소</th>
            <th>상세주소</th>
            <th>회원상태</th>
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
                <button class="action-btn" onclick="viewMember('user01')">회원 정보 확인 및 수정</button>
                <button class="action-btn delete-btn" onclick="deleteMember('user01')">삭제</button>
            </td>
        </tr>
        <!-- 추가 회원 항목은 여기 추가 -->
    </tbody>
</table>
			    
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>null / null</span>
    <button class="next-page">▶</button>
</div>	
</div>
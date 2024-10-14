<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>회원관리</h1>
<div class="member-summary">
    <span>회원 수: <strong id="member-count">10</strong></span>
</div>
			    
<table class="member-table">
    <thead>
        <tr>
            <th>회원 ID</th>
            <th>이름</th>
            <th>비밀번호</th>
            <th>생년월일</th>
            <th>회원연락처</th>
            <th>이메일</th>
            <th>회원우편번호</th>
            <th>회원주소</th>
            <th>회원상세주소</th>
            <th>액션</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>user01</td>
            <td>홍길동</td>
            <td>hong@example.com</td>
            <td>010-1234-5678</td>
            <td>서울시 강남구</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <button class="action-btn" onclick="viewMember('user01')">회원 정보 확인</button>
                <button class="action-btn delete-btn" onclick="deleteMember('user01')">삭제</button>
            </td>
        </tr>
        <!-- 추가 회원 항목은 여기 추가 -->
    </tbody>
</table>
			    
<div class="pagination">
    <button class="prev-page">◀</button>
    <span>1 / 10</span>
    <button class="next-page">▶</button>
</div>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 회원관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css?after">
<link rel="stylesheet" type="text/css" href="css/admin_member.css">
<script src="js/admin_member.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>회원관리</h1>

<%--
    MemberDAO memberDAO = new MemberDAO();
    int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
    String searchTerm = request.getParameter("search") != null ? request.getParameter("search") : "";
    int membersPerPage = 20;
    
    List<Member> members = memberDAO.getMembers(currentPage, membersPerPage, searchTerm);
    int totalMembers = memberDAO.getTotalMembersCount(searchTerm);
    int totalPages = (int) Math.ceil((double) totalMembers / membersPerPage);
--%>

<div class="member-summary">
    <span>회원 수: <strong id="member-count"><%--= totalMembers --%></strong></span>
</div>

<div class="order-management">	
<div class="product-filter">
    <form action="" method="GET">
        <input type="text" name="search" placeholder="회원 ID or 이름 검색" value="<%--= searchTerm --%>" class="filter-input">
        <button type="submit" class="filter-btn">검색</button>
        <a href="?page=1" class="reset-btn">초기화</a>
    </form>
</div>
    
<table class="member-table">
    <thead>
        <tr>
            <th style="width: 110px;">회원 ID</th>
            <th style="width: 70px;">이름</th>
            <th style="width: 100px;">생년월일</th>
            <th style="width: 120px;">전화번호</th>
            <th style="width: 170px;">이메일</th>
            <th>주소</th>
            <th style="width: 80px;">회원상태</th>
            <th style="width: 200px;">
            	<div class="pagination">
		            <a href="?page=<%--= Math.max(1, currentPage - 1) --%>&search=<%--= searchTerm --%>" class="prev-page" <%--= currentPage == 1 ? "disabled" : "" --%>>◀</a>
		            <span><%--= currentPage --%></span> / <span><%--= totalPages --%></span>
		            <a href="?page=<%--= Math.min(totalPages, currentPage + 1) --%>&search=<%--= searchTerm --%>" class="next-page" <%--= currentPage == totalPages ? "disabled" : "" --%>>▶</a>
		        </div>
            </th>
        </tr>
    </thead>
    <tbody id="memberTableBody"> 
    	<%-- for (Member member : members) { --%>
             <tr>
                 <td><%--= member.getId() --%></td>
                 <td><%--= member.getName() --%></td>
                 <td><%--= member.getBirthDate() --%></td>
                 <td><%--= member.getPhone() --%></td>
                 <td><%--= member.getEmail() --%></td>
                 <td><%--= member.getAddress() --%></td>
                 <td><%--= member.getStatus() --%></td>
                 <td>
                     <button class="action-btn" onclick="openMemberModal('<%--= member.getId() --%>')">회원 정보 확인</button>
                     <button class="action-btn delete-btn" onclick="deleteMember('<%--= member.getId() --%>')">삭제</button>
                 </td>
             </tr>
         <%-- } --%>
    </tbody>
</table>
			    
<div class="pagination">
    <a href="?page=<%--= Math.max(1, currentPage - 1) --%>&search=<%--= searchTerm --%>" class="prev-page" <%--= currentPage == 1 ? "disabled" : "" --%>>◀</a>
    <span><%--= currentPage --%></span> / <span><%--= totalPages --%></span>
    <a href="?page=<%--= Math.min(totalPages, currentPage + 1) --%>&search=<%--= searchTerm --%>" class="next-page" <%--= currentPage == totalPages ? "disabled" : "" --%>>▶</a>
</div>
</div>
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>
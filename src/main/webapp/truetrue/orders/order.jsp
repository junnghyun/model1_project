<%@page import="kr.co.truetrue.member.LoginVO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="매장 안내 "%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="kr.co.truetrue.dao.DbConnection" %>
<%@ page import="java.util.*, java.text.*, kr.co.truetrue.order.OrderDAO, kr.co.truetrue.order.OrderVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>매장 검색</title>
    <style>
    <style>

/* 전체 컨테이너 스타일 */
.container {
	padding: 50px 0;
}


/* 페이지 상단 안내 섹션 */
.page_top {
	position: relative;
	background-color: #e1e8d1;
	padding: 10px;
	margin-bottom: 20px;
	border-radius: 5px;
}

.page_title {
	font-size: 20px;
	color: #0d4633;
}

.path {
	position: absolute;
	top: 34px;
	right: 0;
	padding: 14px 0 10px 0;
	text-align: right;
}

.path a {
	color: #0d4633;
	text-decoration: none;
}

.path a:first-child {
	padding-left: 0;
	background: none;
}

.path a:last-child {
	text-decoration: none;
}

/* 매장 검색 섹션 */
.store_search {
	position: relative;
	height: 80px;
	padding: 20px;
	background-color: #dadfcb;
	color: #fff;
	font-size: 14px;
	text-align: center;
	width: 100%;
	box-sizing: border-box;
}

.store_search input[type="date"] {
	padding: 10px;
	font-size: 14px;
	color: #555;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-right: 10px;
}

.store_search label {
	font-weight: bold;
	margin-right: 10px;
	color: gray;
}

.store_search select, .store_search input {
	padding: 10px;
	margin-right: 10px;
	font-size: 14px;
	color: gray;
}

.store_search button {
	padding: 10px 20px;
	background-color: #2E5A27;
	color: white;
	border: none;
	cursor: pointer;
}

.store_search button[type="reset"] {
	background-color: #2E5A27;
	color: white;
	background-position: left center;
	cursor: pointer;
}

/* 매장 결과 영역 */
.store_result_area {
	display: block;
	justify-content: space-between;
	width: 100%;
	padding: 20px;
	background-color: white;
	min-height: 600px; /* content와 동일한 최소 높이 */
	box-sizing: border-box;
	border: 1px solid #E1DDDD;
}

.store_list {
	flex: 1;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	height: 100%; /* 부모 요소에 맞춰 높이 조정 */
	overflow-y: auto;
	box-shadow: 10px 10px 20px black;
}

.store_map {
	flex: 1;
	margin-left: 10px;
	padding: 20px;
	background-images: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
		url("/jsp_prj/day1011/images/brandstore.jpg");
	background-repeat: no repeat;
	background-position: center;
	color: white;
	border: 1px solid #ddd;
	height: 100%; /* 부모 요소에 맞춰 높이 조정 */
}

.store_map strong {
	color: white;
	font-weight: bold;
}

/* 테이블 스타일 */
.store_list table {
	width: 100%;
	border-collapse: collapse;
}

.store_list table th {
	padding: 10px;
	border: 1px solid #ddd;
	font-size: 16px;
	text-align: center;
	color: gray;
}

.store_list table tbody td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: center;
	color: gray;
}

/* 페이징 */
.paging {
	text-align: center;
	margin-top: 20px;
}

.paging span {
	margin: 0 5px;
	font-size: 16px;
}

.paging a {
	text-decoration: none;
	color: #2E5A27;
}

.paging a:hover {
	text-decoration: underline;
}

.store_list .tab-area {
	position: relative;
	margin-bottom: 20px;
}

.store_list .tab-area ul {
	list-style: none;
	padding: 0;
}

.store_list .tab-area ul li a {
	display: block;
	padding: 10px;
	background-color: #2E5A27;
	color: white;
	border: 1px solid #2E5A27;
	text-align: center;
	text-decoration: none;
}

/* 초기화 및 검색 버튼 */
.store_search button {
	background-color: #2E5A27;
	color: #F0F0F0;
}

.store_search button[type="submit"] {
	background-color: #2E5A27;
		color: #FFFFFF;
	pointer: cursor;
}

/* 버튼 위치 스타일 수정 */
#button {
	position: absolute;
	left: 20px;
	top: 15px;
	z-index: 120; /* 버튼이 다른 요소 위에 위치하도록 z-index 추가 */
}

#button input {
	padding: 10px;
	font-size: 14px;
}

#button input::placeholder {
	color: #666;
}
/* 상단 메뉴 스타일 수정 */
.top-menu {
	position: absolute;
	right: 20px;
	top: 15px;
	z-index: 120; /* top-menu가 다른 요소 위에 위치하도록 z-index 추가 */
}

.top-menu ul {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.top-menu ul li {
	margin-left: 15px;
}

.top-menu ul li a {
	text-decoration: none;
	color: white;
	font-size: 14px;
	padding: 10px;
	background-color: #2E5A27;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.top-menu ul li a:hover {
	background-color: #174e38;
}

#btn_more {
	background-position: right-bottom;
}

.order_breakdown {
	width: 100%;
	margin-top: 20px;
}

.order_breakdown table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

.order_breakdown table th, .order_breakdown table td {
	border: 1px solid #ddd;
	padding: 10px;
}

.order_breakdown table th {
	background-color: #ECEFE4;
	font-weight: bold;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="../common/jsp/header.jsp"/>
<!-- 페이지 컨텐츠 -->
<div class="container">
<div id="content">
<!-- 조회기간 검색 부분 -->
<div class="store_search">
<form action="order.jsp" method="get">
<label for="start_date">조회기간</label>
<input type="date" id="start_date" name="start_date">
<label for="end_date">~</label>
<input type="date" id="end_date" name="end_date">
<input type="text" id="keyword" name="keyword" placeholder="주문하신 상품을 검색해주세요.">
<button type="submit" id="submit">검색</button>
</form>
</div>
<div class="store_result_area" style="height: 800px">
 <%
// 사용자 ID는 세션에서 가져오는 예시 (로그인 상태를 가정)
/* String userId = (String)session.getAttribute("userData"); */
LoginVO lVO = (LoginVO) session.getAttribute("userData");
String userId = null;
userId = lVO.getUserId();

// 폼에서 전달된 검색 조건 가져오기
String startDateStr = request.getParameter("start_date");
String endDateStr = request.getParameter("end_date");
String productName = request.getParameter("keyword");
    
System.out.println(userId);

if (userId != null && startDateStr != null && endDateStr != null) {
	try {
	// 날짜 형식을 Date 객체로 변환
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date startDate = new Date(sdf.parse(startDateStr).getTime());
	Date endDate = new Date(sdf.parse(endDateStr).getTime());
	
	// OrderDAO 인스턴스 생성 및 데이터 검색
	OrderDAO orderDAO = OrderDAO.getInstance();
	List<OrderVO> orderList = orderDAO.getOrdersByUserAndDateRange(userId, startDate, endDate);
	
	// 제품명 필터링 적용
	if (productName != null && !productName.trim().isEmpty()) {
	    orderList.removeIf(order -> !order.getProductNames().contains(productName));
	}//end if
	System.out.println("Order List Size: " + orderList.size());//디버깅
	if (!orderList.isEmpty()) {
%>
<!-- 주문 목록 테이블 -->

<div class="order_breakdown">
<table>
<thead>
	<tr>
		<th>주문번호</th>
	    <th>상품명</th>
	    <th>주문일</th>
	    <th>결제금액</th>
	    <th>배송완료일</th>
	    <th>상태</th>
	</tr>
</thead>
<tbody>
<%
	for (OrderVO order : orderList) {
%>
	<tr class="order_row">
	    <td><%= order.getOrderId() %></td>
		<td><%= order.getProductNames() %></td>
		<td><%= order.getOrderDate() %></td>
		<td><%= String.format("%d원", (int) order.getTotalAmount()) %></td>
		<td><%= (order.getDeliveryCompleteDate() != null) ? order.getDeliveryCompleteDate() : "" %></td>
		<td><%= order.getDeliveryStatus() %></td>
	</tr>
<%
}//end for
%>
</tbody>
</table>
<%
} else {
%>
	<p>검색 결과가 없습니다.</p>
<%
	    }
	} catch (Exception e) {
	    e.printStackTrace();
    	%><p>검색 중 오류가 발생했습니다.</p><%
    	}
	}
%>
</div>
</div>
</div>
</div>
<jsp:include page="../common/jsp/footer.jsp"/>
</body>
</html>
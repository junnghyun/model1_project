<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
<link rel="stylesheet" type="text/css" href="css/admin_dashboard.css?after">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="js/admin_dashboard.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>대시보드</h1>
<div class="dashboard-grid">
<div class="dashboard-item" id="box1">
	<h2>매출 분석</h2>
    <div class="chart-container">
        <canvas id="salesChart"></canvas>
    </div>
</div>
<div class="dashboard-item" id="box2">
	<h2>매출 요약</h2>
	<div class="chart-container">
	<div class="money-container">
		<div class="monthly-sales">
        <div>
            <h3>이번 달</h3>
            <ul id="month">
                <li id="monthMoney">매출: 1,500,000 원</li>
            </ul>
        </div>
        <div>
            <h3>저번 달</h3>
            <ul id="month">
                <li id="monthMoney">매출: 1,200,000 원</li>
            </ul>
        </div>
    	</div>
    </div>
    </div>
</div>
<div class="dashboard-item" id="box3">
	<h2>인기 제품</h2> 
    <div class="chart-container">
        <canvas id="ordersChart"></canvas>
    </div>
    
</div>
<div class="dashboard-item" id="box4">
    <h2>누적 사용자</h2>
    <div class="chart-container">
    	<canvas id="peopleChart"></canvas>
    </div>
</div>
</div>
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>
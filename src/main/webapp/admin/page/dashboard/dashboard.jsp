<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>대시보드</h1>
<div class="dashboard-grid">
<div class="dashboard-item" id="box1">
	<h2>매출 요약</h2>
	<div class="chart-container">
    </div>
	
</div>
<div class="dashboard-item" id="box2">
    <h2>사용자 모니터링</h2>
    <p>현재 사용자 수: 0명</p>
</div>
<div class="dashboard-item" id="box3">
    <h2>매출 분석</h2>
    <div class="chart-container">
        <canvas id="salesChart"></canvas>
    </div>
</div>
<div class="dashboard-item" id="box4">
    <h2>인기 제품</h2>
    <div class="chart-container">
        <canvas id="ordersChart"></canvas>
    </div>
</div>
</div>
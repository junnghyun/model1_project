<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="kr.co.truetrue.admin.dashboard.DashboardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/session_chk.jsp" %>
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
    <%
    // 방문자 데이터 가져오기
    List<Integer> weeklyVisitors = null;
    try {
        DashboardDAO dao = DashboardDAO.getInstance();
        weeklyVisitors = dao.getWeeklyVisitors();
        // 데이터 확인을 위한 출력
        System.out.println("Weekly Visitors Data: " + weeklyVisitors);
    } catch(Exception e) {
        e.printStackTrace();
        System.out.println("Error getting weekly visitors: " + e.getMessage());
    }
    
 // 주문 데이터 가져오기
    List<OrderVO> orderProducts = null;
    try {
        DashboardDAO dao = DashboardDAO.getInstance();
        orderProducts = dao.getTopOrderProducts();
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    // JavaScript 배열로 변환할 데이터 준비
    StringBuilder labels = new StringBuilder("[");
    StringBuilder data = new StringBuilder("[");
    
    if(orderProducts != null) {
        for(int i = 0; i < orderProducts.size(); i++) {
            OrderVO product = orderProducts.get(i);
            labels.append("'").append(product.getProduct_name()).append("'");
            data.append(product.getQuantity());
            
            if(i < orderProducts.size() - 1) {
                labels.append(",");
                data.append(",");
            }
        }
        labels.append("]");
        data.append("]");
    }
%>
    <div class="common_admin">
        <h1>대시보드</h1>
        <div class="dashboard-grid">
            <!-- 매출 분석 차트 -->
            <div class="dashboard-item" id="box1">
                <h2>매출 분석</h2>
                <div class="chart-container">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>

            <!-- 매출 요약 -->
            <div class="dashboard-item" id="box2">
			    <h2>매출 요약</h2>
			    <div class="chart-container">
			        <div class="money-container">
			            <div class="monthly-sales">
			                <div>
			                    <h3>이번 달</h3>
			                    <ul id="currentMonth">
			                        <li id="monthMoney">매출: 0 원</li>
			                    </ul>
			                </div>
			                <div>
			                    <h3>저번 달</h3>
			                    <ul id="previousMonth">
			                        <li id="prevMonthMoney">매출: 0 원</li>
			                    </ul>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>


            <!-- 인기 제품 차트 -->
            <div class="dashboard-item" id="box3">
                <h2>인기 제품</h2> 
                <div class="chart-container">
                    <canvas id="ordersChart"></canvas>
                </div>
            </div>

            <!-- 누적 사용자 차트 -->
            <div class="dashboard-item" id="box4">
                <h2>누적 사용자</h2>
                <div class="chart-container">
                    <canvas id="peopleChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script src="../common/js/admin.js"></script>
    <script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // 데이터 확인을 위한 콘솔 출력
    const weeklyVisitorData = <%= weeklyVisitors != null ? weeklyVisitors : "[]" %>;
    console.log('Weekly Visitor Data:', weeklyVisitorData);

    // 사용자 수 차트
    const peopleCtx = document.getElementById('peopleChart').getContext('2d');
    new Chart(peopleCtx, {
        type: 'bar',
        data: {
            labels: ['월', '화', '수', '목', '금', '토', '일'],
            datasets: [{
                label: '일일 방문자 수',
                data: weeklyVisitorData,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgb(54, 162, 235)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        precision: 0  // 정수로만 표시
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        }
    });
     // 주문 차트
        const ordersCtx = document.getElementById('ordersChart').getContext('2d');
        new Chart(ordersCtx, {
            type: 'bar',
            data: {
                labels: <%= labels.toString() %>,
                datasets: [{
                    label: '주문수',
                    data: <%= data.toString() %>,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgb(54, 162, 235)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            precision: 0
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                }
            }
        
    });
});
</script>
</body>
</html>

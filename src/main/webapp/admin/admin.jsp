<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="css/orders.css">
    <link rel="stylesheet" type="text/css" href="css/member.css">
    <link rel="stylesheet" type="text/css" href="css/product.css">
    <link rel="stylesheet" type="text/css" href="css/store.css">
    <link rel="stylesheet" type="text/css" href="css/ad.css">
    
    <!-- Chart.js CDN 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/dashboard.js" defer></script>
    <script src="js/member.js" defer></script>
    <script src="js/product.js" defer></script>
    <script src="js/store.js" defer></script>
    <script src="js/ad.js" defer></script>
</head>
<body> 
    <div class="container">
        <div class="sidebar" id="sidebar">
            <span class="toggle-btn" id="toggle-btn" onclick="toggleSidebar()">&times;</span>
            <div class="sidebar-content">
                <h2>관리자 메뉴</h2>
                <div class="admin-text">
                <ul>
                    <li><a href="#" onclick="showSection('dashboard')">대시보드</a></li>
                    <li><a href="#" onclick="showSection('orders')">주문관리</a></li>
                    <li><a href="#" onclick="showSection('member')">회원관리</a></li>
                    <li><a href="#" onclick="showSection('product')">제품관리</a></li>
                    <li><a href="#" onclick="showSection('store')">매장관리</a></li>
                    <li><a href="#" onclick="showSection('ad')">광고관리</a></li>
                </ul>
                </div>
                <button class="logout-btn" onclick="logout()">로그아웃</button>
            </div>
        </div>
        
        <div class="main-content">
            <div id="dashboard" class="section">
            	<jsp:include page="page/dashboard/dashboard.jsp" />
            </div>
            
            <div id="orders" class="section" style="display:none;">
                <jsp:include page="page/orders/orders.jsp" />
            </div>
            
            <div id="member" class="section" style="display:none;">
                <jsp:include page="page/member/member.jsp" />
            </div>
            
            <div id="product" class="section" style="display:none;">
                <jsp:include page="page/product/product.jsp" />
            </div>
            
            <div id="store" class="section" style="display:none;">
                <jsp:include page="page/store/store.jsp" />
            </div>
            
            <div id="ad" class="section" style="display:none;">
                <jsp:include page="page/ad/ad.jsp" />
            </div>
        </div>
    </div>

    <script>
        function showSection(sectionId) {
            document.querySelectorAll('.section').forEach(section => {
                section.style.display = 'none';
            });
            document.getElementById(sectionId).style.display = 'block';
        }

        function toggleSidebar() {
        	const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('toggle-btn');
            
            // 사이드바를 토글
            sidebar.classList.toggle('hidden');
            
            // 사이드바가 숨겨진 경우 ≡를 보여줌
            if (sidebar.classList.contains('hidden')) {
                toggleBtn.innerHTML = '&#9776;'; // 햄버거 메뉴
            } else {
                toggleBtn.innerHTML = '&times;'; // X 버튼
            }
        }

    </script>
</body>
</html>
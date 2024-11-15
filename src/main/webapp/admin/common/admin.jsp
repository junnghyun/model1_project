<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <header class="header fixed">
        <div class="user-info">
        	<form action="<%= request.getContextPath() %>/model1_project/admin/logout" method="post">
		        <button type="submit" class="logout-btn">로그아웃</button>
		    </form>
            <span>admin 관리자님</span>
        </div>
    </header>
        <div class="sidebar" id="sidebar">
            <span class="toggle-btn" id="toggle-btn" onclick="toggleSidebar()">&times;</span>
            <div class="sidebar-content fixed">
                <h2>관리자 메뉴</h2>
                <div class="admin-text">
                <ul>
                    <li><a href="../admin_dashboard/admin_dashboard.jsp">대시보드</a></li>
                    <li><a href="../admin_orders/admin_orders.jsp">주문관리</a></li>
                    <li><a href="../admin_member/admin_member.jsp">회원관리</a></li>
                    <li><a href="../admin_product/admin_product.jsp">제품관리</a></li>
                    <li><a href="../admin_store/admin_store.jsp">매장관리</a></li>
                    <li><a href="../admin_ad/admin_ad.jsp">광고관리</a></li>
                </ul>
                </div>
            </div>
        </div>
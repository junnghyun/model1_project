<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.admin.order.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/session_chk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.pagination {
    margin-top: 20px;
    text-align: center;
}

.pagination a {
    display: inline-block;
    padding: 5px 10px;
    margin: 0 2px;
    border: 1px solid #ddd;
    color: #333;
    text-decoration: none;
}

.pagination a.active {
    background-color: #007bff;
    color: white;
    border-color: #007bff;
}

.pagination a:hover:not(.active) {
    background-color: #ddd;
}

.prev-page, .next-page {
    font-weight: bold;
}
h1{cursor: pointer}
</style>
<meta charset="UTF-8">
<title>관리자 주문관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
<link rel="stylesheet" type="text/css" href="css/admin_orders.css">
<!-- JQuery CD작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/admin_orders.js" defer></script>
<script type="text/javascript">
$(function(){
    // 신규 주문 내역 버튼 클릭 이벤트
	$("#newOrderBtn").click(function() {
        loadNewOrders(1);
    });
    // 완료된 주문 내역 버튼 클릭 이벤트
    $("#completeOrderBtn").click(function() {
        loadCompletedOrders(1);
    });
    // 주문관리 제목 클릭 시 페이지 새로고침
    $("h1").click(function() {
        window.location.href = "admin_orders.jsp";
    });
    
    // 검색 버튼 클릭 시 주문 검색 처리
    $("#searchBtn").on('click', function(e){
        e.preventDefault();
        
        var startDate = $("#start-date").val();
        var endDate = $("#end-date").val();
        var userId = $("#userId").val();
        
        // 유효성 검사
        if(!startDate || !endDate) {
            alert("거래기간을 선택해주세요.");
            return;
        }
        
        // 날짜 비교
        if(new Date(startDate) > new Date(endDate)) {
            alert("시작일이 종료일보다 늦을 수 없습니다.");
            return;
        }

        searchOrders(startDate, endDate, userId, 1);
    });
	
    if(typeof currentPage !== 'undefined' && typeof totalPage !== 'undefined' && totalPage > 0) {
        updatePagination(currentPage, totalPage, function(page) {
            window.location.href = "admin_orders.jsp?currentPage=" + page;
        });
    }
	
});

//주문 검색 실행 함수 - AJAX를 통해 검색 결과를 가져와 테이블 업데이트
function searchOrders(startDate, endDate, userId, page) {
    $.ajax({
        url: "search_order_process.jsp",
        type: "get",
        data: {
            startDate: startDate,
            endDate: endDate,
            userId: userId,
            page: page
        },
        dataType: "json",
        success: function(result) {
            var tbody = $(".order-table tbody");
            
            if(!result.data || result.data.length === 0) {
                tbody.html("<tr><td colspan='7' style='text-align:center'>검색 결과가 없습니다.</td></tr>");
                $("#pagination-container").empty();
                return;
            }
            
            var html = "";
            result.data.forEach(function(order) {
                html += "<tr>";
                html += "<td>" + order.order_id + "</td>";
                html += "<td>" + order.user_id + "</td>";
                html += "<td>" + order.payment_date + "</td>";
                html += "<td>" + order.total_price + "</td>";
                html += "<td>" + order.address + "</td>";
                html += "<td>" + order.delivery_status + "</td>";
                html += "<td>";
                html += "<button class='start-btn' onclick=\"updateSt('S', '" + order.order_id + "')\">배송 시작</button>";
                html += "<button class='complete-btn' onclick=\"updateSt('C', '" + order.order_id + "')\">배송 완료</button>";
                html += "<button class='cancel-btn' onclick=\"updateSt('X', '" + order.order_id + "')\">취소</button>";
                html += "</td>";
                html += "</tr>";
            });
            
            tbody.html(html);
            
            // 페이지네이션 업데이트
            updatePagination(result.currentPage, result.totalPage, function(pageNum) {
                searchOrders(startDate, endDate, userId, pageNum);
            });
        },
        error: function(xhr) {
            console.log("Error status: " + xhr.status);
            alert("검색 중 문제가 발생했습니다.");
        }
    });
}

//신규 주문 목록을 가져오는 함수
function loadNewOrders(page) {
    console.log("loadNewOrders called with page:", page);
    $.ajax({
        url: "new_order_process.jsp",
        type: "get",
        data: { page: page },
        dataType: "json",
        success: function(result) {
            console.log("New orders loaded:", result);
            updateOrderTable(result.data);
            updatePagination(result.currentPage, result.totalPage, 'loadNewOrders');
        },
        error: function(xhr) {
            console.log("Error loading new orders:", xhr.status, xhr.statusText);
            alert("신규 주문 내역을 불러오는 중 문제가 발생했습니다.");
        }
    });
}

//완료된 주문 목록을 가져오는 함수
function loadCompletedOrders(page) {
    console.log("loadCompletedOrders called with page:", page);
    $.ajax({
        url: "completed_order_process.jsp",
        type: "get",
        data: { page: page },
        dataType: "json",
        success: function(result) {
            console.log("Completed orders loaded:", result);
            updateOrderTable(result.data);
            updatePagination(result.currentPage, result.totalPage, 'loadCompletedOrders');
        },
        error: function(xhr) {
            console.log("Error loading completed orders:", xhr.status, xhr.statusText);
            alert("이전 주문 내역을 불러오는 중 문제가 발생했습니다.");
        }
    });
}

//주문 테이블 HTML 업데이트 함수
function updateOrderTable(data) {
    var tbody = "";
    $(data).each(function(idx, order) {
        tbody += "<tr>";
        tbody += "<td>" + order.order_id + "</td>";
        tbody += "<td>" + order.user_id + "</td>";
        tbody += "<td>" + order.payment_date + "</td>";
        tbody += "<td>" + order.total_price + "</td>";
        tbody += "<td>" + order.address + "</td>";
        tbody += "<td>" + order.delivery_status + "</td>";
        tbody += "<td>";
        tbody += "<button class='start-btn' onclick=\"updateSt('S', '" + order.order_id + "')\">배송 시작</button>";
        tbody += "<button class='complete-btn' onclick=\"updateSt('C', '" + order.order_id + "')\">배송 완료</button>";
        tbody += "<button class='cancel-btn' onclick=\"updateSt('X', '" + order.order_id + "')\">취소</button>";
        tbody += "</td>";
        tbody += "</tr>";
    });
    $(".order-table tbody").html(tbody);
}

//페이지네이션 UI 업데이트 함수
function updatePagination(currentPage, totalPage, callback) {
    var pagination = "";
    
    // 이전 페이지 버튼
    if(currentPage > 1) {
        pagination += "<a href='javascript:void(0)' onclick='javascript:window.location.href=\"admin_orders.jsp?currentPage=" + (currentPage-1) + "\"' class='prev-page'>◀</a>";
    }
    
    // 페이지 번호 버튼
    for(var i = 1; i <= totalPage; i++) {
        if(i === currentPage) {
            pagination += "<a href='javascript:void(0)' class='active'>" + i + "</a>";
        } else {
            pagination += "<a href='javascript:void(0)' onclick='javascript:window.location.href=\"admin_orders.jsp?currentPage=" + i + "\"'>" + i + "</a>";
        }
    }
    
    // 다음 페이지 버튼
    if(currentPage < totalPage) {
        pagination += "<a href='javascript:void(0)' onclick='javascript:window.location.href=\"admin_orders.jsp?currentPage=" + (currentPage+1) + "\"' class='next-page'>▶</a>";
    }
    
    $("#pagination-container").html(pagination);
}

//주문 상태 업데이트 처리 함수 - 확인 메시지 표시 및 유효성 검사
function updateStatus(status, orderId, deliveryStatus) {
    var confirmMessage;
    switch (status) {
        case 'S':
            confirmMessage = "배송 시작 하시겠습니까?";
            break;
        case 'C':
            confirmMessage = "배송 완료 하시겠습니까?";
            break;
        case 'X':
            confirmMessage = "배송 취소 하시겠습니까?";
            break;
        default:
            return;
    }

    // 배송 완료 상태인 경우 변경 불가
    if (deliveryStatus === '배송완료' && status !== 'X') {
        alert("배송 완료된 주문은 상태를 변경할 수 없습니다.");
        return;
    }

    if (!confirm(confirmMessage)) {
        return;
    }

    updateOrderStatus(status, orderId);
}

//AJAX를 통해 실제 주문 상태를 업데이트하는 함수
function updateOrderStatus(status, orderId) {
    var param = { delivery_status: status, order_id: orderId };
    $.ajax({
        url: "update_order_process.jsp",
        type: "get",
        data: param,
        dataType: "json",
        error: function (xhr) {
            console.log(xhr.status + " / " + xhr.statusText);
            alert("작업 중 문제가 발생했습니다.");
        },
        success: function (jsonObj) {
            var msg = "배송정보가 변경되지 않았습니다.";
            if (jsonObj.rowCnt > 0) {
                msg = "배송 정보가 변경되었습니다.";
            }
            alert(msg);
            // 상태 변경 후 메인 페이지로 이동
            window.location.href = "admin_orders.jsp";
        }
    });
}

//검색 결과에 대한 페이지네이션 UI 업데이트 함수
function updateSearchPagination(currentPage, totalPage, startDate, endDate, userId) {
    var pagination = "";
    
    if(currentPage > 1) {
        pagination += "<a href='javascript:void(0)' onclick='searchOrders(\"" + startDate + "\", \"" + endDate + "\", \"" + userId + "\", " + (currentPage-1) + ")' class='prev-page'>◀</a>";
    }
    
    for(var i = 1; i <= totalPage; i++) {
        if(i === currentPage) {
            pagination += "<a href='javascript:void(0)' class='active'>" + i + "</a>";
        } else {
            pagination += "<a href='javascript:void(0)' onclick='searchOrders(\"" + startDate + "\", \"" + endDate + "\", \"" + userId + "\", " + i + ")'>" + i + "</a>";
        }
    }
    
    if(currentPage < totalPage) {
        pagination += "<a href='javascript:void(0)' onclick='searchOrders(\"" + startDate + "\", \"" + endDate + "\", \"" + userId + "\", " + (currentPage+1) + ")' class='next-page'>▶</a>";
    }
    
    $("#pagination-container").html(pagination);
}

</script>

</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>주문관리</h1>

<%
//페이징 처리
int pageScale = 10; // 한 페이지에 보여줄 게시물 수
int totalCount = 0; // 전체 게시물 수
OrderDAO oDAO = OrderDAO.getInstance();

try {
    totalCount = oDAO.selectTotalCount();
} catch(SQLException se) {
    se.printStackTrace();
}

// 총 페이지 수
int totalPage = (int)Math.ceil((double)totalCount/pageScale);

//현재 페이지 번호
String paramPage = request.getParameter("currentPage");
int currentPage = 1;

if(paramPage != null){
 try {
     currentPage = Integer.parseInt(paramPage);
     if(currentPage < 1) currentPage = 1;
     if(currentPage > totalPage) currentPage = totalPage;
 } catch(NumberFormatException nfe) {
     currentPage = 1;
 }
}
// 시작번호와 끝번호 계산
int startNum = (currentPage-1) * pageScale + 1;
int endNum = startNum + pageScale - 1;

// 끝번호가 총 레코드 수보다 크다면 총 레코드 수로 설정
if(endNum > totalCount){
    endNum = totalCount;
}


// 데이터 조회
List<OrderVO> listBoard = null;
try {
    listBoard = oDAO.selectAllOrder(startNum, endNum);
} catch(SQLException se) {
    se.printStackTrace();
}

// JSP에서 사용할 수 있도록 속성 설정
request.setAttribute("totalCount", totalCount);  // pageContext -> request로 변경
request.setAttribute("pageScale", pageScale);
request.setAttribute("totalPage", totalPage);
request.setAttribute("currentPage", currentPage);
request.setAttribute("startNum", startNum);
request.setAttribute("endNum", endNum);
request.setAttribute("listBoard", listBoard);
%>
<script type="text/javascript">
    // 페이지네이션 정보를 전역 변수로 설정
    var currentPage = <%= currentPage %>;
    var totalPage = <%= totalPage %>;
</script>
<div class="order-management">
    <div class="order-header">
    	<div class="order-button">
	        <button class="new-order-btn" id="newOrderBtn">신규 주문 내역</button>
	        <button class="previous-order-btn" id="completeOrderBtn">이전 주문 내역</button>
        </div>
        <div class="date-range">
            <label for="date-range">거래기간:</label>
            <input type="date" id="start-date">
            <span>~</span>
            <input type="date" id="end-date">
            
            <input type="text" placeholder="고객ID 검색" id="userId" class="search-bar">
        	<button class="search-btn" id="searchBtn">검색</button>
        </div>
    </div>
    
    <table class="order-table">
    <thead> 
        <tr>
            <th>주문 ID</th>
            <th>고객 ID</th>
            <th>결제일</th>
            <th>결제금액</th>
            <th>주문주소</th>
            <th>주문상태</th>
            <th style="width: 230px;">주문 상태 변경</th>
        </tr>
    </thead>
      <tbody >
        <c:forEach var="oVO" items="${listBoard }" varStatus="i">
            <tr>
        	<td><c:out value="${oVO.order_id }"/></td>
        	<td><c:out value="${oVO.user_id }"/></td>
        	<td><c:out value="${oVO.payment_date }"/></td>
        	<td><c:out value="${oVO.total_price }"/></td>
        	<td><c:out value="${oVO.address }"/></td>
        	<td><c:out value="${oVO.delivery_status }"/></td>
        	<td>
	        	<button class="start-btn" onclick="updateStatus('S', '${oVO.order_id}', '${oVO.delivery_status}')" value="${i.index}">배송 시작</button>
				<button class="complete-btn" onclick="updateStatus('C', '${oVO.order_id}', '${oVO.delivery_status}')" value="${i.index}">배송 완료</button>
				<button class="cancel-btn" onclick="updateStatus('X', '${oVO.order_id}', '${oVO.delivery_status}')" value="${i.index}">취소</button>
			</td>
        	</tr>
        </c:forEach>
        </tbody>
	</table>
    <div id="pagination-container" class="pagination"></div>
</div>
</div>
</body>
</html>
<%@page import="kr.co.truetrue.user.card.CardVO"%>
<%@page import="kr.co.truetrue.user.card.CardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.truetrue.admin.order.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
%>
<%@page import="kr.co.truetrue.user.card.CardVO"%> 
<%@page import="kr.co.truetrue.user.card.CardDAO"%> 
<%@page import="java.sql.SQLException"%> 
<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>

<style>
/* 기존 스타일 유지하면서 수정 */
body {
   margin: 0;
   padding: 0;
   display: flex;
   flex-direction: column;
   min-height: 100vh;
   font-family: Arial, sans-serif;
   line-height: 1.6;
   color: #333;
}

.header-container {
   width: 100%;
   position: relative; 
   z-index: 1000;
   margin-bottom: 120px;
}

.main-content {
   flex: 1;
   display: flex;
   flex-direction: column;
   align-items: center;
   width: 70%; /* 장바구니 이미지와 동일한 너비로 수정 */
   margin: 0 auto;
   padding: 20px;
   position: relative;
}

/* 글자 크기 조정 */
.section-title {
   border-bottom: 3px solid #333;
   padding-bottom: 5px;
   width: 100%;
   font-size: 24px; /* 제목 글자 크기 증가 */
   margin-bottom: 20px;
   font-weight: bold;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 20px; /* 패딩 증가 */
    text-align: center;
    font-size: 18px;
}

/* 상품정보 열을 더 넓게 설정 */
th:first-child, td:first-child {
    width: 50%; /* 첫 번째 열(상품정보)의 너비를 50%로 설정 */
}

/* 수량과 주문금액 열의 너비 조정 */
th:nth-child(2), td:nth-child(2),
th:nth-child(3), td:nth-child(3) {
    width: 25%; /* 나머지 열들의 너비를 25%씩 설정 */
}

.product-info {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    text-align: left;
    padding: 10px; /* 내부 여백 추가 */
}

.product-image {
    width: 100px;
    height: 100px;
    object-fit: cover;
    margin-right: 30px; /* 이미지와 텍스트 사이 간격 증가 */
}

.product-info span {
    font-size: 18px;
    flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
}

/* 배송지 정보와 결제 정보 글자 크기 */
.info-box p {
   font-size: 18px; /* 정보 글자 크기 */
   margin: 15px 0;
}

.payment-amount {
   color: skyblue;
   font-weight: bold;
   font-size: 18px; /* 금액 글자 크기 */
}

/* 이미지 크기 조정 */
.product-image {
   width: 100px; /* 상품 이미지 크기 증가 */
   height: 100px;
   object-fit: cover;
   margin-right: 15px;
}


.info-section {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    width: 100%;
}

.info-box {
    width: 48%;
}

.confirm-btn {
    display: block;
    width: 200px;
    margin: 20px auto;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    text-align: center;
    text-decoration: none;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.section-title {
    /* border-bottom: 3px solid #333; */
    padding-bottom: 5px;
    width: 100%;
}

.payment-amount {
    color: skyblue;
    font-weight: bold;
}

.underline {
    /* border-bottom: 1px solid rgba(0, 0, 0, 0.1); */
    padding-bottom: 2px;
}

}
</style>
</head>
<%
    // 파라미터 받기
    String[] productNames = request.getParameter("productNames").split("\\|");
    String[] productQuantities = request.getParameter("productQuantities").split("\\|");
    String[] productPrices = request.getParameter("productPrices").split("\\|");
    String totalAmount = request.getParameter("totalAmount");
    String cardType = request.getParameter("cardType");
    String receiverName = request.getParameter("receiverName");
    String receiverPhone = request.getParameter("receiverPhone");
    String address = request.getParameter("address");
    String orderId = request.getParameter("order_id");

    // OrderDAO를 통해 주문 정보 조회
    OrderDAO orderDAO = OrderDAO.getInstance();
    List<OrderVO> orderDetails = null;
    try {
        orderDetails = orderDAO.selectOrderDetailsByOrderId(Integer.parseInt(orderId));
    } catch(SQLException e) {
        e.printStackTrace();
    }

    // 상품 총 금액 계산 (배송비 제외)
    int productPrice = 0;
    for(int i = 0; i < productPrices.length; i++) {
        productPrice += Integer.parseInt(productPrices[i]);
    }
    
    // 총 결제 금액 (상품 금액 + 배송비)
    int total = Integer.parseInt(totalAmount);

    // 카드 정보 조회
    CardDAO cardDAO = CardDAO.getInstance();
    CardVO cardInfo = null;
    try {
        cardInfo = cardDAO.getCardInfoByOrderId(Integer.parseInt(orderId));
    } catch(SQLException e) {
        e.printStackTrace();
    }
%>
<body>
    <div class="header-container">
        <jsp:include page="../common/jsp/header.jsp"/>
    </div>

    <img src="../common/images/cart/장바구니3.png" alt="주문 단계" class="order-steps" style="width: 70%; margin: 30px auto 50px auto; display: block;">
    <div class="main-content">

        <h3 class="section-title">주문 상품</h3>
        <table>
            <thead>
                <tr>
                    <th>상품정보</th>
                    <th>수량</th>
                    <th>주문금액</th>
                </tr>
            </thead>
            <tbody>
                <% if(orderDetails != null) {
                    for(OrderVO order : orderDetails) { %>
                    <tr>
                        <td>
                            <div class="product-info">
                                <img src="../common/images/bread/<%= order.getProduct_img() %>" 
                                     alt="<%= order.getProduct_name() %>" 
                                     class="product-image">
                                <span class="underline"><%= order.getProduct_name() %></span>
                            </div>
                        </td>
                        <td><%= order.getQuantity() %>개</td>
						<td class="payment-amount">
						    <%= String.format("%,d", order.getPrice() * order.getQuantity()) %>원
						</td>                    
					</tr>
                <% }
                } %>
            </tbody>
        </table>

        <div class="info-section">
            <div class="info-box">
                <h3 class="section-title">배송지 정보</h3>
                <% if(orderDetails != null && !orderDetails.isEmpty()) { 
                    OrderVO firstOrder = orderDetails.get(0); %>
                    <p><strong>이름:</strong> <span class="underline">
                        <%= firstOrder.getRecipient() %>
                    </span></p>
                    <p><strong>휴대폰번호:</strong> <span class="underline">
                        <%= firstOrder.getRecipient_phone() %>
                    </span></p>
                    <p><strong>배송지 주소:</strong> <span class="underline">
                        <%= firstOrder.getZip_code() %> <%= firstOrder.getAddress() %> 
                        <%= firstOrder.getAddress_detail() %>
                    </span></p>
                <% } %>
            </div>
            <div class="info-box">
                <h3 class="section-title">결제 정보</h3>
                <p><strong>결제수단:</strong> <span class="underline">
                    <%= cardInfo != null ? cardInfo.getCard_type() : cardType %>
                </span></p>
                <p><strong>상품금액:</strong> <span class="payment-amount underline">
                    <%= String.format("%,d", productPrice) %>원
                </span></p>
                <p><strong>배송비:</strong> <span class="underline">5,000원</span></p>
                <p><strong>총 결제 금액:</strong> <span class="payment-amount underline">
                    <%= String.format("%,d", total) %>원
                </span></p>
            </div>
        </div>
        
        <button class="confirm-btn" onclick="location.href='../../index.jsp'">메인으로</button>
    </div>

    <div class="footer-container">
        <jsp:include page="../common/jsp/footer.jsp"/>
    </div>
</body>
</html>
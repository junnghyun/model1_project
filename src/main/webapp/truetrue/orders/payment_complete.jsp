<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 결제 완료</title>
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f0f0f0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .container {
        background-color: white;
        border-radius: 8px;
        padding: 30px;
        max-width: 400px;
        width: 100%;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .tabs {
        display: flex;
        border-bottom: 1px solid #ccc;
        margin-bottom: 20px;
    }
    .tab {
        padding: 10px 20px;
        cursor: pointer;
        opacity: 0.6;
    }
    .tab.active {
        border-bottom: 2px solid #4285f4;
        opacity: 1;
    }
    .tab:first-child {
        color: #999; 
    }
    .tab:last-child {
        color: #4285f4; 
        font-weight: bold;
    }
    h1 {
        color: #4285f4;
        margin-bottom: 20px;
        text-align: center;
    }
    .info-group {
        margin-bottom: 15px;
    }
    .info-group label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
    .info-group span {
        display: block;
    }
    .confirm-btn {
        background-color: #4285f4;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 20px;
        width: 100%;
    }
    .confirm-btn:hover {
        background-color: #3367d6;
    }
</style>
<%
//결제 관련 파라미터들을 받아옴
String productNames = request.getParameter("productNames");
String userId = (String)session.getAttribute("user_id");
String[] productIds = request.getParameter("productNames").split("\\|");
String[] quantities = request.getParameter("productQuantities").split("\\|");
String[] prices = request.getParameter("productPrices").split("\\|");
String totalAmount = request.getParameter("totalAmount");
String cardType = request.getParameter("cardType");
String receiverName = request.getParameter("receiverName");
String receiverPhone = request.getParameter("receiverPhone");
String address = request.getParameter("address");
String[] addresses = address.split(" ", 2);
String zipCode = addresses[0];
String fullAddress = addresses.length > 1 ? addresses[1] : "";
String requests = request.getParameter("requests"); 
String cartProductIds = request.getParameter("cart_product_ids");

//null이나 빈 문자열 체크
if(cartProductIds == null || cartProductIds.trim().isEmpty()) {
  cartProductIds = "0"; // 기본값 설정 또는 에러 처리
}
request.setAttribute("cartProductIds", cartProductIds);
request.setAttribute("requests", requests);
%>
<script type="text/javascript">
$(function(){
	$('#btnCon').click(function() {
	    // 카트 상품 ID 유효성 검사
	    var cartProductIds = "${cartProductIds}";
	    if(!cartProductIds || cartProductIds === "0") {
	        alert("주문 정보가 올바르지 않습니다.");
	        return;
	    }

	 // URL 파라미터와 주소 처리
	    var urlParams = new URLSearchParams(window.location.search);
	    var addressWithZip = "<%=address%>"; // zipCode + 주소가 포함된 전체 문자열

	    // zipCode 제외하고 실제 주소만 추출
	    var actualAddress = "<%=fullAddress%>"; // zipCode가 제외된 실제 주소

	    // 주소를 구까지와 나머지로 분리
	    var addressParts = actualAddress.split(/(?<=구)\s+/);
	    var mainAddress = addressParts[0] || ''; // 구까지의 주소
	    var detailAddress = addressParts[1] || ''; // 나머지 상세주소

	    
	    // AJAX로 주문 정보 저장 및 장바구니 상태 변경
	    $.ajax({
	        url: "process_order.jsp",
	        type: "POST",
	        dataType: "json",
	        data: {
	            cartProductIds: cartProductIds,
	            receiverName: "<%=receiverName%>",
	            receiverPhone: "<%=receiverPhone%>",
	            zipCode: "<%=zipCode%>",
	            address: mainAddress,
	            addressDetail: detailAddress,
	            requests: "<%=requests != null ? requests : ""%>",  // 요청사항
	            totalAmount: "<%=totalAmount%>",
	            cardType: "<%=cardType%>"
	        },
	        success: function(response) {
	            if(response.status === "success") {
	                // 기존 URL 파라미터에 order_id 추가
	                var currentSearch = window.location.search;
	                var urlParams = new URLSearchParams(currentSearch);
	                urlParams.append('order_id', response.order_id);  // process_order.jsp에서 반환한 order_id 추가
	                
	                window.opener.location.href = "order_complete.jsp?" + urlParams.toString();
	                window.close();
	            } else {
	                alert("주문 처리 중 오류가 발생했습니다: " + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("Error:", error);
	            console.error("Response:", xhr.responseText);
	            alert("서버 통신 중 오류가 발생했습니다.");
	        }
	    });
	});
});
</script>

</head>
<body>
    <div class="container">
        <div class="tabs">
            <div class="tab">카드정보입력</div>
            <div class="tab active">완료</div>
        </div>
        <h1>결제 완료</h1>
        <div class="info-group">
		    <label>카드 정보</label>
		    <span><%=cardType%></span>
		</div>
		<div class="info-group">
		    <label>상품명</label>
		    <span><%=request.getParameter("summaryProductName")%></span>
		</div>
		<div class="info-group">
		    <label>구매금액</label>
		    <span><fmt:formatNumber value="<%=totalAmount%>" pattern="#,###"/>
		    원</span>
		</div>
        <button class="confirm-btn" id="btnCon">확인</button>
    </div>
</body>
</html>
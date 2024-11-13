<%@page import="kr.co.truetrue.user.card.CardDAO"%>
<%@page import="kr.co.truetrue.user.card.CardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 결제</title>
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
    }
    .container {
        background-color: white;
        border-radius: 8px;
        padding: 30px;
        max-width: 500px;
        margin: 0 auto;
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
    }
    .tab.active {
        border-bottom: 2px solid #4285f4;
        color: #4285f4;
    }
    .info-list {
        list-style-type: none;
        padding: 0;
        margin-bottom: 20px;
    }
    .info-list li {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        border-bottom: 1px solid #eee;
        padding-bottom: 5px;
    }
    .info-list li:last-child {
        border-bottom: none;
    }
    .info-list .label {
        font-weight: bold;
        color: #555;
    }
    .card-number {
        display: flex;
        gap: 10px;
    }
    .card-number input {
        flex: 1;
        width: 60px;
    }
    .expiry {
        display: flex;
        gap: 10px;
    }
    .expiry select {
        flex: 1;
    }
    .buttons {
        display: flex;
        justify-content: center; /* 중앙 정렬 */
        gap: 10px; /* 버튼 사이의 간격 */
        margin-top: 20px;
    }
    button {
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .confirm {
        background-color: #4285f4;
        color: white;
    }
    .cancel {
        background-color: #f1f3f4;
        color: #202124;
    }
</style>
<%
//세션과 파라미터에서 필요한 정보 추출
String userId = (String)session.getAttribute("user_id");
String productNames = request.getParameter("productNames");
String totalAmount = request.getParameter("totalAmount");
String cardType = request.getParameter("cardType");
String installment = request.getParameter("installment");
String cartProductIds = request.getParameter("cart_product_ids");
String requests = request.getParameter("requests");

// 숫자 포맷팅을 위해 totalAmount를 Integer로 변환
int total = 0;
try {
    total = Integer.parseInt(totalAmount);
} catch(NumberFormatException e) {
    total = 0;
}

//저장된 카드 정보 조회
CardVO savedCard = null;
if(userId != null) {
    CardDAO cardDAO = CardDAO.getInstance();
    savedCard = cardDAO.getLatestCardInfo(userId);
    request.setAttribute("savedCard", savedCard);
}

//cartProductIds를 request에 설정
request.setAttribute("cartProductIds", cartProductIds);
request.setAttribute("requests", requests);
%>
<script type="text/javascript">
$(function(){
	// 저장된 카드 정보가 있다면 자동 입력
    <% if(savedCard != null) { %>
        $("#cardNum1").val("<%=savedCard.getCard_num1()%>");
        $("#cardNum2").val("<%=savedCard.getCard_num2()%>");
        $("#cardNum3").val("<%=savedCard.getCard_num3()%>");
        $("#cardNum4").val("<%=savedCard.getCard_num4()%>");
        $("#cardExpMonth").val(<%=savedCard.getMonth()%>);
        $("#cardExpYear").val("<%=savedCard.getYear()%>");
    <% } %>
    
	// 카드번호 입력 자동 포커스 이동
	$('#cardNumber input').on('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
        if (this.value.length == 4) {
            $(this).next('input').focus();
        }
    });
	
    // 카드 정보 저장 및 결제 처리
    $('#cardNumber input').on('keydown', function(e) {
        if (e.keyCode == 8 && this.value.length == 0) {
            $(this).prev('input').focus();
        }
    });
	
    $('#cancel').click(function() {
        window.close();  // 팝업 창 닫기
    });
    
 	// 확인 버튼 클릭 시 카드 정보 저장
    $('#confirm').click(function() {
        // 카드번호 검증
        var cardNumbers = [];
        var isValid = true;
        $('#cardNumber input').each(function() {
            if(this.value.length != 4) {
                isValid = false;
                return false;
            }
            cardNumbers.push(this.value);
        });

        if(!isValid) {
            alert("카드번호를 올바르게 입력해주세요.");
            return;
        }
		
        
        // 카드 정보 저장 AJAX 호출
        $.ajax({
		    url: "save_card_info.jsp",
		    type: "POST",
		    dataType: "json",
		    data: {
		        cartProductIds: "<%=cartProductIds%>",  // JSP 변수를 직접 사용
		        cardNum1: $("#cardNum1").val(),
		        cardNum2: $("#cardNum2").val(),
		        cardNum3: $("#cardNum3").val(),
		        cardNum4: $("#cardNum4").val(),
		        expMonth: $("#cardExpMonth").val(),
		        expYear: $("#cardExpYear").val(),
		        cardType: "<%=cardType%>",
		        installment: "<%=installment%>"
		    },
            success: function(response) {
                if(response.status === "success") {
                    // 부모 창의 URL에서 cart_product_ids 가져오기
                    var cartProductIds = window.opener.document.getElementById("cartProductIds").value;
                    
                    // 현재 URL의 파라미터 가져오기
                    var urlParams = new URLSearchParams(window.location.search);
                    // cart_product_ids 추가
                    urlParams.set('cart_product_ids', cartProductIds);
                    
                    // 결제 완료 페이지로 이동
                    location.href = "payment_complete.jsp?" + urlParams.toString();
                } else {
                    alert("카드 정보 저장에 실패했습니다: " + response.message);
                }
            },
            error: function(xhr, status, error) {
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
            <div class="tab active">카드정보입력</div>
            <div class="tab">완료</div>
        </div>
	        <ul class="info-list">
	    <li>
	        <span class="label">사용 쇼핑몰</span>
	        <span>뚜루뚜루</span>
	    </li>
	    <li>
		    <span class="label">상품명</span>
		    <span><%=request.getParameter("summaryProductName")%></span>
		</li>
		<li>
		    <span class="label">구매금액</span>
		    <span><%=String.format("%,d", total)%>원</span>
		</li>
            <li>
                <span class="label">카드번호</span>
                <div class="card-number" id="cardNumber">
				    <input type="text" id="cardNum1" maxlength="4">
				    <input type="text" id="cardNum2" maxlength="4">
				    <input type="text" id="cardNum3" maxlength="4">
				    <input type="text" id="cardNum4" maxlength="4">
				</div>
            </li>
            <li>
                <span class="label">카드 유효기간</span>
                <div class="expiry">
   					<select id="cardExpMonth">
                        <% for(int i=1; i<13; i++) { %>
                            <option><%= i %></option>
                        <% } %>
                    </select>
                     <select id="cardExpYear">
                        <% 
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        int year = cal.get(java.util.Calendar.YEAR);
                        for(int i=year; i<year+10; i++) { 
                        %>
                            <option><%= i %></option>
                        <% } %>
                    </select>
                </div>
            </li>
        </ul>
        <div class="buttons">
            <button class="confirm" id="confirm">확인</button>
            <button class="cancel" id="cancle">취소</button>
        </div>
    </div>
</body>
</html>
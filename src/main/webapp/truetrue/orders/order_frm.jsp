<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="주문서"%>
<%@page import="kr.co.truetrue.user.cart.CartVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.truetrue.user.cart.CartDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서</title>
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.221/html_prj/common/css/main_20240911.css" />
<!-- bootstrap CDN 시작-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Daum 우편번호 검색 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">
body {
	text-align: center;
}

.container {
	margin: 0 auto;
	width: 50%;
	border: 1px solid #ccc;
	padding: 20px;
}

h6 {
	font-size: 1.2em;
	font-weight: bold;
}

hr {
	border: 0;
	border-top: 1px solid #ccc;
	margin-top: 20px;
	margin-bottom: 20px;
}

table {
	width: 100%;
	margin: 10px 0;
}

td {
	height: 42px;
	padding: 5px;
}

.inputBox {
	width: 100%;
}

.btnMySubmit, .btnMyReset {
	width: 120px;
	height: 40px;
	font-size: 16px;
	margin: 5px;
}

.btnMySubmit {
	background-color: #184F3B;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
}

.order_steps_image {
	width: 50%;
	max-width: 1200px;
	height: auto;
	margin-bottom: 20px;
}

.td-left {
	text-align: left;
}
</style>
<%
CartDAO cDAO = CartDAO.getInstance();

//로그인한 사용자 정보 조회
String user_id = (String)session.getAttribute("user_id");
CartVO userInfo = null;
if(user_id != null) {
    userInfo = cDAO.selectUserInfo(user_id);  // 사용자 정보 조회 메서드 필요
    request.setAttribute("userInfo", userInfo);
} 
// 장바구니에서 전달받은 상품 정보 처리
String cartProductIdsStr = request.getParameter("cart_product_ids");
List<CartVO> orderItems = null;

if(cartProductIdsStr != null) {
    String[] cartProductIds = cartProductIdsStr.split(",");
    orderItems = new ArrayList<>();
    
    for(String cartProductId : cartProductIds) {
        CartVO cartItem = cDAO.selectCartItem(cartProductId);
        if(cartItem != null) {
            orderItems.add(cartItem);
        }
    }
    request.setAttribute("orderItems", orderItems);
    }
int totalAmount = 0;
if(orderItems != null) {
    for(CartVO item : orderItems) {
        totalAmount += (item.getPrice() * item.getQuantity());
    }
}
request.setAttribute("totalAmount", totalAmount);
request.setAttribute("cartProductIds", cartProductIdsStr);
%>
<script type="text/javascript">
const cartProductIds = "${cartProductIdsStr}";
	//전역 함수로 선언
	// 상품 정보 수집 함수
	function collectProductInfo() {
	    const productData = {
	        names: [],
	        quantities: [],
	        prices: [],
	        images: []
	    };
	
	    // order-item 클래스가 아닌 tbody의 모든 tr을 순회
	    $("#orderItemList tr").each(function() {
	        const itemId = $(this).attr("data-item-id");
	        if(!itemId) {
	        	return
	        }; // data-item-id가 없으면 건너뛰기
	
	        const name = $(this).find(".product-name").text().trim();
	        const quantity = $(this).find("#productQuantity_" + itemId).text().replace('개', '').trim();
	        const price = $(this).find("#productPrice_" + itemId).text().replace(/[^0-9]/g, '').trim();
	        const image = $(this).find("#productImg_" + itemId).attr("src").split('/').pop();
	
	        productData.names.push(name);
	        productData.quantities.push(quantity);
	        productData.prices.push(price);
	        productData.images.push(image);
	    });
	
	    return productData;
	}
	
	$(function() {
		//페이지 로드시 금액 계산
		 calculateTotalAmount();
		// 이전 배송 정보 자동 입력
		$("#use_previous_address").change(function() {
	        if ($(this).is(":checked")) {
	            $.ajax({
	                url: "get_last_order.jsp",
	                type: "POST",
	                data: { user_id: "${user_id}" },
	                dataType: "json",
	                success: function(response) {
	                    if (response.status === "success") {
	                        $("#receiver_name").val(response.receiverName);
	                        $("#r_phone1").val(response.phone1);
	                        $("#r_phone2").val(response.phone2);
	                        $("#r_phone3").val(response.phone3);
	                        $("#zipcode").val(response.zipcode);
	                        $("#addr1").val(response.address);
	                        $("#addr2").val(response.addr2);
	                        $("#requests").val(response.request);
	                    } else {
	                        alert("이전 주문 정보가 없습니다.");
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.log(xhr.responseText);
	                    alert("서버 오류가 발생했습니다.");
	                }
	            });
	        } else {
	            // 폼 초기화
	            $("#receiver_name").val("");
	            $("#r_phone1").val("010");
	            $("#r_phone2").val("");
	            $("#r_phone3").val("");
	            $("#zipcode").val("");
	            $("#addr1").val("");
	            $("#addr2").val("");
	            $("#requests").val("");
	        }
	    });

		
		// 결제하기 버튼 처리
	    $("#btnSubmit").click(function(){
	        // 필수 입력 확인
	        if($("#customer_name").val() == "") {
	            alert("주문자 이름을 입력하셔야 합니다.");
	            return;
	        }
	        if($("#phone2").val() == "" || $("#phone3").val() == "") {
	            alert("전화번호를 입력하셔야 합니다.");
	            return;
	        }
	        if($("#receiver_name").val() == "") {
	            alert("받으시는 분 이름을 입력하셔야 합니다.");
	            return;
	        }
	        if($("#r_phone2").val() == "" || $("#r_phone3").val() == "") {
	            alert("받으시는 분 전화번호를 입력하셔야 합니다.");
	            return;
	        }
	        if($("#addr1").val() == "") {
	            alert("배송지를 입력하셔야 합니다.");
	            return;
	        }
	        if(!$("input[name='payment_method']:checked").val()) {
	            alert("결제 수단을 선택하셔야 합니다.");
	            return;
	        }
	        if($("select[name='card_type']").val() == "카드를 선택해주세요") {
	            alert("카드 종류를 선택하셔야 합니다.");
	            return;
	        }

	        // 상품 정보 수집
	        const productData = collectProductInfo();
	        
	        // 대표 상품명 생성
	        const summaryProductName = productData.names.length > 1 
	            ? productData.names[0] + " 외 " + (productData.names.length - 1) + "개"
	            : productData.names[0];
			
	        // URL 파라미터 생성
	        const params = new URLSearchParams({
	            cardType: $("#cardType").val(),
	            installment: $("#installmentType").val(),
	            totalAmount: $("#finalPaymentAmount").text().replace(/[^0-9]/g, ''),
	            summaryProductName: summaryProductName,
	            productNames: productData.names.join('|'),
	            productQuantities: productData.quantities.join('|'),
	            productPrices: productData.prices.join('|'),
	            productImages: productData.images.join('|'),
	            receiverName: $("#receiver_name").val(),
	            receiverPhone: $("#r_phone1").val() + "-" + $("#r_phone2").val() + "-" + $("#r_phone3").val(),
	            address: $("#zipcode").val() + " " + $("#addr1").val() + " " + $("#addr2").val(),
	            cart_product_ids: "${cartProductIdsStr}",
	            requests: $("#requests").val() || ''
	        });
			
	        // 팝업 창 열기
	        const features = "width=600,height=800,scrollbars=yes";
	        window.open("payment_info.jsp?" + params.toString(), "PaymentWindow", features);
	    });
	});
	
	// 총 금액 계산
    function calculateTotalAmount() {
        const productTotal = parseInt($("#productTotalPrice").text().replace(/[^0-9]/g, '') || 0);
        const deliveryFee = parseInt($("#deliveryFee").text().replace(/[^0-9]/g, '') || 0);
        // 상품 금액과 배송비를 합산하여 최종 결제 금액 계산
        const finalAmount = productTotal + deliveryFee;
        
        // 금액 표시 업데이트
        $("#productTotalPrice").text(productTotal.toLocaleString());
        $("#deliveryFee").text(deliveryFee.toLocaleString());
        $("#finalPaymentAmount").text(finalAmount.toLocaleString());
    }

	// Daum 우편번호 찾기
	function searchZipcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소
				var extraRoadAddr = ''; // 참고 항목 변수

				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}

				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}

				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById("addr1").value = roadAddr;
				document.getElementById("addr2").focus();
			}
		}).open();
	}
	
</script>

</head>
<body>
	<form name="orderFrm" id="orderFrm" method="post"
		action="payment_info.jsp">
		<img src="../common/images/cart/장바구니2.png" alt="주문 단계" class="order_steps_image">
		<div class="container">
			<!-- 선택한 상품 목록 -->
			<h6>
			<img src="../common/images/cart/pen_logo.png">주문 상품 정보</h6>
			<hr>
			<table class="table" style="margin-top: 20px;">
				<thead>
        <tr>
            <th>상품정보</th>
            <th>수량</th>
            <th>주문금액</th>
        </tr>
		    </thead>
		    <tbody id="orderItemList">
			    <c:forEach var="item" items="${orderItems}" varStatus="status">
			        <tr data-item-id="${item.cart_product_id}">
			            <td>
			                <div class="product_info">
			                    <img id="productImg_${item.cart_product_id}" 
			                         src="../common/images/bread/${item.product_img}" 
			                         alt="${item.product_name}" 
			                         style="width: 50px;">
			                    <span id="productName_${item.cart_product_id}" class="product-name">
			                        ${item.product_name}
			                    </span>
			                </div>
			            </td>
			            <td id="productQuantity_${item.cart_product_id}">${item.quantity}개</td>
			            <td id="productPrice_${item.cart_product_id}">
			                <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" />원
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>
			</table>
			<table>
				<h6>
				<img src="../common/images/cart/pen_logo.png">주문고객 정보</h6>
				<tr>
					<td><span class="required">*</span>주문자 이름</td>
					<td class="td-left"><input type="text" name="customer_name"
						id="customer_name" value="${userInfo.name}" readonly
						class="inputBox"></td>
				</tr>
				<tr>
					<td><span class="required">*</span>핸드폰 번호</td>
					<td class="td-left"><select name="phone1" id="phone1"
						class="inputBox" style="width: 60px;" disabled>
							<option ${userInfo.phone1 == '010' ? 'selected' : ''}>010</option>
							<option ${userInfo.phone1 == '011' ? 'selected' : ''}>011</option>
					</select>- <input type="text" name="phone2" id="phone2" maxlength="4"
						value="${userInfo.phone2}" readonly class="inputBox"
						style="width: 80px">- <input type="text" name="phone3"
						id="phone3" maxlength="4" value="${userInfo.phone3}" readonly
						class="inputBox" style="width: 80px"> 
						<!-- 실제 값을 전송하기 위한 hidden 필드 -->
						<input type="hidden" name="phone1_hidden"
						value="${userInfo.phone1}"> 
						<input type="hidden"
						name="phone2_hidden" value="${userInfo.phone2}"> 
						<input type="hidden" name="phone3_hidden" value="${userInfo.phone3}">
						<input type="hidden" id="cartProductIds" value="${cartProductIds}">
					</td>
				</tr>
			</table>

			<span style="font-size: 20px; font-weight: bold;">
			<img src="../common/images/cart/pen_logo.png">배송지 정보</span>
			<input type="checkbox" name="use_previous_address"
				id="use_previous_address"> 이전 배송 정보 입력
			<table>
				<tr>
					<td><span class="required">*</span>받으시는 분</td>
					<td><input type="text" name="receiver_name" id="receiver_name"
						class="inputBox"></td>
				</tr>
				<tr>
					<td><span class="required">*</span>핸드폰 번호</td>
					<td class="td-left"><select name="r_phone1" id="r_phone1"
						class="inputBox" style="width: 60px;">
							<option>010</option>
							<option>011</option>
					</select>- <input type="text" name="r_phone2" id="r_phone2" maxlength="4"
						class="inputBox" style="width: 80px">- <input type="text"
						name="r_phone3" id="r_phone3" maxlength="4" class="inputBox"
						style="width: 80px"></td>
				</tr>
				<tr>
					<td><span class="required">*</span>우편번호</td>
					<td class="td-left"><input type="text" name="zipcode"
						id="zipcode" readonly="readonly" class="inputBox"
						style="width: 60px"> <input type="button" value="우편번호 검색"
						id="findZipcode" class="btnMy" style="width: 140px"
						onclick="searchZipcode();"></td>
				</tr>
				<tr>
					<td><span class="required">*</span>주소</td>
					<td><input type="text" name="addr1" id="addr1"
						readonly="readonly" class="inputBox"> <br> <input
						type="text" name="addr2" id="addr2" class="inputBox"></td>
				</tr>
				<tr>
					<td>요청사항</td>
					<td><input type="text" name="requests" id="requests"
						class="inputBox"></td>
				</tr>
			</table>

			<h6>결제 금액</h6>
			<table id="paymentTable" border="1" style="width: 100%; margin-top: 10px;">
			    <tr>
			        <td>상품 금액</td>
			        <td><span id="productTotalPrice"><fmt:formatNumber value="${totalAmount}" pattern="#,###" /></span>원</td>
			    </tr>
			    <tr>
			        <td>배송비</td>
			        <td><span id="deliveryFee">5,000</span>원</td>
			    </tr>
			    <tr>
			        <td><b>최종 결제 금액</b></td>
			        <td><b>
			            <span id="finalPaymentAmount">
			                <fmt:formatNumber value="${totalAmount + 5000}" pattern="#,###" />
			            </span>원
			        </b></td>
			    </tr>
			</table>

			<h6>결제 수단 선택</h6>
			<table id="paymentMethodTable" border="1" style="width: 100%; margin-top: 10px;">
				<tr>
					<td><input type="radio" name="payment_method"
						value="credit_card" checked="checked"> 신용카드</td>
					<!-- <td><input type="radio" name="payment_method" value="mobile_payment"> 휴대폰 결제</td>
                    <td><input type="radio" name="payment_method" value="toss"> Toss 결제</td> -->
				</tr>
			</table>

			<table id="cardInfoTable" border="1" style="width: 100%; margin-top: 10px;">
				<tr>
					<td>카드 종류</td>
					<td>
					<select name="card_type" id="cardType" class="inputBox">
					    <option selected>카드를 선택해주세요</option>
					    <option>하나은행</option>
					    <option>국민은행</option>
					    <option>농협은행</option>
					    <option>우리은행</option>
					    <option>카카오뱅크</option>
					</select>
					</td>
				</tr>
				<tr>
					<td>할부 종류</td>
					<td>
					<select name="installment" id="installmentType" class="inputBox">
							<option selected>일시불</option>
							<option>1개월</option>
							<option>2개월</option>
							<option>3개월</option>
							<option>4개월</option>
							<option>5개월</option>
							<option>6개월</option>
							<option>7개월</option>
							<option>8개월</option>
							<option>9개월</option>
							<option>10개월</option>
							<option>11개월</option>
							<option>12개월</option>
					</select></td>
				</tr>
			</table>

			<div align="center" style="margin-top: 30px">
				<input type="button" value="결제하기" id="btnSubmit" class="btnMySubmit">
				<input type="reset" value="취소하기" id="btnReset" class="btnMyReset">
			</div>
		</div>
	</form>

</body>
</html>

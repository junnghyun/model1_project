<!DOCTYPE html>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.cart.CartDAO"%>
<%@page import="kr.co.truetrue.user.cart.CartVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
<%@ include file="../common/jsp/session_chk.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>건강한 데일리 베이커리, 빵, 케이크, 샌드위치, 이벤트, 매장안내</title>
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- JQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        color: #333;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .cart_table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        margin-bottom: 20px;
    }
    .cart_table th, .cart_table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    .cart_table th {
        background-color: #e8e8e1;
    }
    .cart_table img {
        max-width: 80px;
        height: auto;
    }
    
    .quantity_control {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .quantity_control button {
        background-color: #f0f0f0;
        border: 1px solid #ddd;
        padding: 5px 10px;
        cursor: pointer;
    }
    .quantity_control input {
        width: 40px;
        text-align: center;
        margin: 0 5px;
        border: 1px solid #ddd;
    }
    
    .total_order {
        background-color: #fff;
        padding: 20px;
        margin-bottom: 20px;
        text-align: right;
        border: 1px solid #ddd;
    }
    .total_order strong {
        font-size: 18px;
        color: #1d4627;
    }
    
    .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }
    .buttons button {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border: none;
        margin-left: 10px;
    }
    .btn_brown {
        background-color: #8b6037;
        color: white;
    }
    .btn_white {
        background-color: white;
        border: 1px solid #8b6037;
        color: #8b6037;
    }
    .btn_green {
        background-color: #1d4627;
        color: white;
    }
    .order_steps_image {
        width: 100%;
        max-width: 1200px;
        height: auto;
        margin-bottom: 20px;
    }
    .product_info {
        display: flex;
        align-items: center;
        text-align: left;
    }
    .product_info img {
        max-width: 80px;
        height: auto;
        margin-right: 10px;
    }
    .product_info p {
        margin: 0;
    }
</style>
<script type="text/javascript">
$(function(){
    // 수량 증가/감소 버튼 클릭 시 수량 변경 및 DB 업데이트 처리
    $('.quantity-decrease, .quantity-increase').click(function() {
        var itemId = $(this).data('item-id');
        var quantityInput = document.getElementById('quantity_' + itemId);
        var quantity = parseInt(quantityInput.value);
        var trElement = this.parentElement.parentElement.parentElement;
        
        if ($(this).hasClass('quantity-increase')) {
            quantity++;
        } else if (quantity > 1) {
            quantity--;
        }
        
        // AJAX로 DB 업데이트
        $.ajax({
            url: 'update_quantity.jsp',
            type: 'POST',
            data: {
                cart_product_id: itemId,
                quantity: quantity
            },
            dataType: 'json',
            success: function(response) {
                if(response.status === 'success') {
                    quantityInput.value = quantity;
                    updateItemTotal(trElement);
                    calculateTotalPrice();
                } else {
                    alert('수량 변경에 실패했습니다.');
                }
            },
            error: function(xhr) {
                console.log(xhr.status + " / " + xhr.statusText);
                alert('수량 변경 중 오류가 발생했습니다.');
            }
        });
    });

    // 전체 선택/해제 체크박스 이벤트 처리
    document.getElementById('selectAllProducts').addEventListener('change', function() {
        var checkboxes = document.getElementsByClassName('item-checkbox');
        for(var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = this.checked;
        }
        calculateTotalPrice();
    });

    // 개별 상품 체크박스 변경 시 전체선택 상태 및 총액 업데이트
    $('.item-checkbox').change(function() {
        checkSelectAll();
        calculateTotalPrice();
    });

    // 선택된 상품들 장바구니에서 삭제 처리
    document.getElementById('deleteSelected').addEventListener('click', function() {
        if(confirm('선택한 상품을 장바구니에서 삭제하시겠습니까?')) {
            var selectedItems = [];
            var checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            
            if(checkedBoxes.length > 0) {
                checkedBoxes.forEach(function(checkbox) {
                    selectedItems.push(checkbox.value);
                });
                
                $.ajax({
                    url: 'delete_cart_items.jsp',
                    type: 'POST',
                    data: { items: selectedItems.join(',') },
                    success: function() {
                        location.reload();
                    }
                });
            } else {
                alert('상품이 없습니다.');
            }
        }
    });

    // 상품 목록 페이지로 이동
    document.getElementById('continueShopping').addEventListener('click', function() {
        location.href = 'product_list.jsp';
    });

    // 전체/선택 주문 처리 함수 - 선택된 상품들의 주문 정보 생성
    function handleOrder(isAll) {
        var items = [];
        var checkboxes = isAll ? 
            document.getElementsByClassName('item-checkbox') : 
            document.querySelectorAll('.item-checkbox:checked');
            
        for(var i = 0; i < checkboxes.length; i++) {
            var tr = checkboxes[i].parentElement.parentElement;
            items.push({
                id: checkboxes[i].value,
                quantity: tr.querySelector('.quantity-input').value
            });
        }
        
        if(items.length > 0) {
            processOrder(items);
        } else {
            alert('주문할 상품을 선택해주세요.');
        }
    }
    // 전체 상품 주문 버튼 클릭 이벤트
    document.getElementById('orderAll').addEventListener('click', function() {
        handleOrder(true);
    });
    // 선택 상품 주문 버튼 클릭 이벤트
    document.getElementById('orderSelected').addEventListener('click', function() {
        handleOrder(false);
    });

    // 초기 합계 계산
    calculateTotalPrice();
});

//개별 상품의 합계 금액 업데이트 함수
function updateItemTotal(trElement) {
    var price = parseInt(trElement.querySelector('.product-price').getAttribute('data-price'));
    var quantity = parseInt(trElement.querySelector('.quantity-input').value);
    var total = price * quantity;
    trElement.querySelector('.item-total').textContent = total.toLocaleString() + '원';
}

//선택된 상품들의 총 주문금액 계산 함수 (배송비 포함)
function calculateTotalPrice() {
    var subtotal = 0;
    var shipping = 5000;
    var checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
    
    checkedBoxes.forEach(function(checkbox) {
        var tr = checkbox.parentElement.parentElement;
        var price = parseInt(tr.querySelector('.product-price').getAttribute('data-price'));
        var quantity = parseInt(tr.querySelector('.quantity-input').value);
        subtotal += price * quantity;
    });

    document.getElementById('subtotal').textContent = subtotal.toLocaleString();
    document.getElementById('grandTotal').textContent = (subtotal + shipping).toLocaleString();
}

//전체선택 체크박스 상태 업데이트 함수
function checkSelectAll() {
    var totalCheckboxes = document.getElementsByClassName('item-checkbox').length;
    var checkedBoxes = document.querySelectorAll('.item-checkbox:checked').length;
    document.getElementById('selectAllProducts').checked = (totalCheckboxes === checkedBoxes);
}

//주문 처리를 위한 폼 생성 및 제출 함수
function processOrder(items) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = 'order_frm.jsp';

    // 선택된 상품의 cart_product_id들을 쉼표로 구분하여 전달
    var cartProductIds = [];
    for(var i = 0; i < items.length; i++) {
        cartProductIds.push(items[i].id);
    }
    
    var itemsInput = document.createElement('input');
    itemsInput.type = 'hidden';
    itemsInput.name = 'cart_product_ids';
    itemsInput.value = cartProductIds.join(',');  // 쉼표로 구분된 문자열로 변환
    form.appendChild(itemsInput);

    document.body.appendChild(form);
    form.submit();
}
</script>
<%
String user_id = (String)session.getAttribute("user_id");
if(user_id == null) {
    response.sendRedirect("login.jsp");
    return;
}
//user_id를 JavaScript에서 사용할 수 있도록 설정
request.setAttribute("user_id", user_id);

List<CartVO> cartItems = null;
try {
 CartDAO cDAO = CartDAO.getInstance();
 cartItems = cDAO.selectCartItems(user_id);
} catch(SQLException se) {
 se.printStackTrace();
}

request.setAttribute("cartItems", cartItems);
%>
</head>
<body>
	<div>
	<jsp:include page="../common/jsp/header.jsp"/>
	</div>
    <div class="container">
        <img src="../common/images/cart/장바구니1.png" alt="주문 단계" class="order_steps_image">
        <table class="cart_table" id="cartTable">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAllProducts" checked></th>
                    <th>상품정보</th>
                    <th>주문금액</th>
                    <th>수량</th>
                    <th>금액</th>
                    <th>배송비</th>
                </tr>
            </thead>
            <tbody id="cartTableBody">
            <c:choose>
			    <c:when test="${empty cartItems}">
			        <tr>
			            <td colspan="6" class="text-center">장바구니가 비어있습니다.</td>
			        </tr>
			    </c:when>
			    <c:otherwise>
                <c:forEach var="item" items="${cartItems}" varStatus="status">
                    <tr class="cart-item" id="item_${item.cart_product_id}">
                        <td><input type="checkbox" name="selectedItem" class="item-checkbox" checked 
                            value="${item.cart_product_id}"></td>
                        <td>
                            <div class="product_info">
								<img src="../common/images/bread/${item.product_img}" alt="${item.product_name}">
                                <p class="product-name">${item.product_name}</p>
                            </div>
                        </td>
                        <td class="product-price" data-price="${item.price}">
                            <fmt:formatNumber value="${item.price}" pattern="#,###"/>원
                        </td>
                        <td>
                            <div class="quantity_control">
                                <button class="quantity-decrease" data-item-id="${item.cart_product_id}">-</button>
                                <input type="text" class="quantity-input" id="quantity_${item.cart_product_id}" 
                                    value="${item.quantity}" readonly>
                                <button class="quantity-increase" data-item-id="${item.cart_product_id}">+</button>
                            </div>
                        </td>
                        <td class="item-total">
                            <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>원
                        </td>
                        <c:if test="${not empty cartItems and status.first}">
						    <td rowspan="${fn:length(cartItems)}">5,000원</td>
						</c:if>
                    </tr>
                </c:forEach>
                </c:otherwise>
			</c:choose>
            </tbody>
        </table>
        
        <div class="total_order" id="orderSummary">
            주문금액 합계 <span id="subtotal">0</span>원 + 
            배송비 <span id="shipping">5,000</span>원 = 
            총 주문금액 <strong><span id="grandTotal">0</span>원</strong>
        </div>
        
        <div class="buttons">
            <div>
                <button class="btn_brown" id="deleteSelected">선택삭제</button>
            </div>
            <div>
                <button class="btn_white" id="continueShopping">쇼핑계속하기</button>
                <button class="btn_green" id="orderAll">전체상품 주문</button>
                <button class="btn_green" id="orderSelected">선택상품 주문</button>
            </div>
        </div>
    </div>
    <div>
	<jsp:include page="../common/jsp/footer.jsp"/>
	</div>
</body>
</html>
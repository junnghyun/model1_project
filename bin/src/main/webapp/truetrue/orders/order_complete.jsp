<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<style>
    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        color: #333;
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }
    .order-steps {
        width: 100%;
        margin-bottom: 30px;
    }
    .order-complete {
        text-align: center;
        margin-bottom: 30px;
    }
    .order-complete img {
        width: 300px;
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
    .product-info {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        text-align: left;
    }
    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        margin-right: 10px;
    }
    .info-section {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
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
        border-bottom: 3px solid #333;
        padding-bottom: 5px;
    }
    .payment-amount {
        color: skyblue;
        font-weight: bold;
    }
    .underline {
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        padding-bottom: 2px;
    }
</style>
</head>
<body>
	<img src="common/img/장바구니3" alt="주문 단계" class="order-steps">
    <!-- <div class="order-complete">
        <img src="images/주문완료.png" alt="주문 완료 아이콘">
    </div> -->

    <h3 class="section-title">주문 상품</h3>
    <table>
        <thead>
            <tr>
                <th>상품명</th>
                <th>수량</th>
                <th>결제금액</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="product-info">
                        <img src="common/img/기분좋은소금버터식빵.jpg" alt="식빵" class="product-image">
                        <span class="underline">기분좋은소금버터식빵</span>
                    </div>
                </td>
                <td>1</td>
                <td class="payment-amount">9,900원</td>
            </tr>
            <tr>
                <td>
                    <div class="product-info">
                        <img src="common/img/초코생크림케이크.jpg" alt="케이크" class="product-image">
                        <span class="underline">초코생크림케이크</span>
                    </div>
                </td>
                <td>1</td>
                <td class="payment-amount">1,700원</td>
            </tr>
        </tbody>
    </table>

    <div class="info-section">
        <div class="info-box">
            <h3 class="section-title">배송지 정보</h3>
            <p><strong>이름:</strong> <span class="underline">홍길동</span></p>
            <p><strong>휴대폰번호:</strong> <span class="underline">010-1234-2345</span></p>
            <p><strong>배송지 주소:</strong> <span class="underline">(08504) 서울특별시 금천구 가산디지털1로 구디아카데미 1810</span></p>
        </div>
        <div class="info-box">
            <h3 class="section-title">결제 정보</h3>
            <p><strong>상품금액:</strong> <span class="payment-amount underline">11,600원</span></p>
            <p><strong>배송비:</strong> <span class="underline">5000원</span></p>
            <p><strong>총 결제 금액:</strong> <span class="payment-amount underline">16,600원</span></p>
        </div>
    </div>

    <button class="confirm-btn">확인</button>
</body>
</html>
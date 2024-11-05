<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="주문서"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서</title>
<link rel="stylesheet" type="text/css" href="../common/css/main_20240911.css"/>
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Daum 우편번호 검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
    h7 {
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
</style>

<script type="text/javascript">
$(function(){
    // '이전 배송 정보 입력' 체크박스가 선택되면 주문 고객 정보를 배송지 정보에 자동 입력
    $("#use_previous_address").change(function(){
        if ($(this).is(":checked")) {
            $("#receiver_name").val($("#customer_name").val());
            $("#r_phone1").val($("#phone1").val());
            $("#r_phone2").val($("#phone2").val());
            $("#r_phone3").val($("#phone3").val());
        } else {
            $("#receiver_name").val("");
            $("#r_phone1").val("");
            $("#r_phone2").val("");
            $("#r_phone3").val("");
        }
    });

    // 결제하기 버튼 클릭 시 주소 확인
    $("#btnSubmit").click(function(){
        if ($("#addr1").val() == "") {
            alert("배송지를 입력하셔야 합니다.");
            return false;
        }
        $("#orderFrm").submit();
    });
});

// Daum 우편번호 찾기
function searchZipcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소
            var extraRoadAddr = ''; // 참고 항목 변수

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
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

<div class="container">
    <form name="orderFrm" id="orderFrm" method="post" action="order_submit.jsp">
        <div align="center">
            <h7><img src="../common/images/pen_logo.png">주문고객 정보</h7>
            <hr>
            <table>
                <tr>
                    <td><span class="required">*</span>주문자 이름</td>
                    <td><input type="text" name="customer_name" id="customer_name" class="inputBox"></td>
                </tr>
                <tr>
                    <td><span class="required">*</span>핸드폰 번호</td>
                    <td>
                        <select name="phone1" id="phone1" class="inputBox" style="width: 60px;">
                            <option>010</option>
                            <option>011</option>
                        </select>
                        <input type="text" name="phone2" id="phone2" maxlength="4" class="inputBox" style="width: 80px"> -
                        <input type="text" name="phone3" id="phone3" maxlength="4" class="inputBox" style="width: 80px">
                    </td>
                </tr>
            </table>

            <h7><img src="../common/images/pen_logo.png">배송지 정보</h7>
            <hr>
            <input type="checkbox" name="use_previous_address" id="use_previous_address"> 이전 배송 정보 입력
            <table>
                <tr>
                    <td><span class="required">*</span>받으시는 분</td>
                    <td><input type="text" name="receiver_name" id="receiver_name" class="inputBox"></td>
                </tr>
                <tr>
                    <td><span class="required">*</span>핸드폰 번호</td>
                    <td>
                        <select name="r_phone1" id="r_phone1" class="inputBox" style="width: 60px;">
                            <option>010</option>
                            <option>011</option>
                        </select>
                        <input type="text" name="r_phone2" id="r_phone2" maxlength="4" class="inputBox" style="width: 80px"> -
                        <input type="text" name="r_phone3" id="r_phone3" maxlength="4" class="inputBox" style="width: 80px">
                    </td>
                </tr>
                <tr>
                    <td><span class="required">*</span>우편번호</td>
                    <td>
                        <input type="text" name="zipcode" id="zipcode" readonly="readonly" class="inputBox" style="width: 60px"> 
                        <input type="button" value="우편번호 검색" id="findZipcode" class="btnMy" style="width: 140px" onclick="searchZipcode();">
                    </td>
                </tr>
                <tr>
                    <td><span class="required">*</span>주소</td>
                    <td>
                        <input type="text" name="addr1" id="addr1" readonly="readonly" class="inputBox"> <br> 
                        <input type="text" name="addr2" id="addr2" class="inputBox">
                    </td>
                </tr>
                <tr>
                    <td>요청사항</td>
                    <td><input type="text" name="requests" id="requests" class="inputBox"></td>
                </tr>
            </table>

            <h7>결제 금액</h7>
            <table border="1" style="width: 100%; margin-top: 10px;">
                <tr>
                    <td>상품 금액</td>
                    <td>5000원</td>
                </tr>
                <tr>
                    <td>배송비</td>
                    <td>5000원</td>
                </tr>
                <tr>
                    <td><b>최종 결제 금액</b></td>
                    <td><b>10000원</b></td>
                </tr>
            </table>

            <h7>결제 수단 선택</h7>
            <table border="1" style="width: 100%; margin-top: 10px;">
                <tr>
                    <td><input type="radio" name="payment_method" value="credit_card"> 신용카드</td>
                    <td><input type="radio" name="payment_method" value="mobile_payment"> 휴대폰 결제</td>
                    <td><input type="radio" name="payment_method" value="toss"> Toss 결제</td>
                </tr>
            </table>

            <table border="1" style="width: 100%; margin-top: 10px;">
                <tr>
                    <td>카드 종류</td>
                    <td>
                        <select name="card_type" class="inputBox">
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
                        <select name="installment" class="inputBox">
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
                        </select>
                    </td>
                </tr>
            </table>

            <div align="center" style="margin-top: 30px">
                <input type="button" value="결제하기" id="btnSubmit" class="btnMySubmit"> 
                <input type="reset" value="취소하기" id="btnReset" class="btnMyReset">
            </div>
        </div>
    </form>
</div>

</body>
</html>

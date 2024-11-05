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
<script type="text/javascript">
$(function(){
    $('.card-number input').on('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
        if (this.value.length == 4) {
            $(this).next('input').focus();
        }
    });

    $('.card-number input').on('keydown', function(e) {
        if (e.keyCode == 8 && this.value.length == 0) {
            $(this).prev('input').focus();
        }
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
                <span>꽈배기</span>
            </li>
            <li>
                <span class="label">구매금액</span>
                <span>4,800원</span>
            </li>
            <li>
                <span class="label">카드번호</span>
                <div class="card-number">
                    <input type="text" maxlength="4" pattern="\d*" inputmode="numeric">
                    <input type="text" maxlength="4" pattern="\d*" inputmode="numeric">
                    <input type="text" maxlength="4" pattern="\d*" inputmode="numeric">
                    <input type="text" maxlength="4" pattern="\d*" inputmode="numeric">
                </div>
            </li>
            <li>
                <span class="label">카드 유효기간</span>
                <div class="expiry">
                    <select>
                        <% for(int i=1; i<13; i++) { %>
                            <option><%= i %></option>
                        <% } %>
                    </select>
                    <select>
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
            <button class="confirm">확인</button>
            <button class="cancel">취소</button>
        </div>
    </div>
</body>
</html>
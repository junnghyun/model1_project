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
<script type="text/javascript">
$(function(){
    $('.confirm-btn').click(function() {
        window.close();
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
            <span>**은행카드</span>
        </div>
        <div class="info-group">
            <label>상품명</label>
            <span>꽈배기</span>
        </div>
        <div class="info-group">
            <label>구매금액</label>
            <span>4,800 원</span>
        </div>
        <button class="confirm-btn">확인</button>
    </div>
</body>
</html>
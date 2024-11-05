<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="개인정보를 변경하기 전 비밀번호 인증 페이지"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title</title>
<link rel="shorcut icon"
href="../common/images/paka.jpg">
<link rel="stylesheet" type="text/css"
href="../common/CSS/main_20240911.css">
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.cont_header {
    padding-top: 75px;
    text-align: center;
    font-size: 14px;
    font-family: Arial, nbgr, '나눔바른고딕', '돋음';
    line-height: 24px;
}
.pw_wrap {
	margin:0px auto;
	width: 900px;
    padding: 50px;
    border-top: 1px solid #222;
    background-color: #f8f8f8;
}
.find_handy {
	width:500px;
	height:200px;
    margin-top: 40px;
    margin: 0px auto;
    text-align: center;
}
.em {
    color: #ee6900;
    font-weight: bold;
}
.btn.btn_accept {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 30px;
    width: 180px;
    margin-left: 5px;
}
.btn.btn_pw {
    background-color: #FFF;
    color: #000;
    height: 40px;
    cursor: pointer;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 30px;
    width: 180px;
    margin-right: 5px;
}
.cont_area {
    padding-top: 60px;
}
.pw{
	font-size: 21px;
	font-family: Arial, nbgr, '나눔바른고딕', '돋음';
	font-weight: bold;
}

</style>
<script type="text/javascript">
function validateForm() {
    var pass = document.getElementById("pass").value;
    if (pass === "") {
        alert("비밀번호를 입력해 주세요.");
        return false;
    }//end if
    return true;
}//validateForm

function validateAndSubmit() {
    if (validateForm()) {
        // 비밀번호가 입력되었을 경우에만 페이지 이동
        location.href = 'http://www.naver.com';
    }//end if
}//validateAndSubmit
</script>
</head>
<body>
<div class="cont_header">
	<h1>회원정보 수정</h1>
	<p>회원님의 소중한 정보를 안전하게 관리하세요.</p>
</div>
<div class="cont_area">
<div class="pw_wrap">
<div class="find_handy">
<form action="회원정보 수정" method="POST">
	<p class="pw">회원 정보를 수정하시려면 비밀번호를 입력해 주세요.</p><br>
	<input type="password" class="pass" id="pass" name="pass" placeholder="비밀번호를 입력해주세요." size=46>
	<div>
	<button type="button" class="btn btn_pw" id="btn_pw" onclick="location.href='http://192.168.10.223/Tourtour_prj/first_prj/mypage.jsp'">취소</button>
	<button type="button" class="btn btn_accept" id="btn_accept" onclick="validateAndSubmit()">확인</button>
	</div>
</form>
</div>
</div>
</div>
</body>
</html>
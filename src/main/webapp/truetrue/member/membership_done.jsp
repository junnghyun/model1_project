<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 완료 페이지"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="10;메인페이지 주소">
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
.membership_wrap {
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
.btn.btn_em {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    padding: 0 15px;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 30px;
    width: 375px;
}
.cont_area {
    padding-top: 60px;
}
.cong{
	font-size: 25px;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<div class="cont_header">
	<h1 class="h1_tit">회원가입 완료</h1>
</div>
<div class="cont_area">
<div class="membership_wrap">
<div class="find_handy">
<form action="메인페이지" method="POST">
	<p class="cong"><span class="em">회원가입</span>을 축하합니다.</p><br>
	<p class="desc">잠시후 메인페이지로 이동합니다. [바로가기]버튼을 클릭하시면 바로 이동됩니다.</p>
	<div class="btn_sec">
	<button type="button" class="btn btn_em" id="btnSearch" onclick="location.href='../../index.jsp'">바로가기</button>
	</div>
</form>
</div>
</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"
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
body {
    width: 100%;
    background-color: #f7f0da;
}
.page_title {
    margin-left: 50px;
}
.page_top {
    position: relative;
    top: 47px;
    right: 150px;
    margin: 0 auto;
    width: 1000px;
    color: #184F3B;
}
#content {
    position: relative;
    width: 1300px;
    margin: 0 auto;
}
.mypage {
    padding-bottom: 70px;
}
.box_wrap {
    padding: 50px;
    background: #fff;
    text-align: center;
    margin-top: 150px;
    height: 500px;
}
.tb {
    padding: 50px;
    border: 4px double #e8e6e2;
    margin: 70px auto;
}
.th {
    font-size: 40px;
    color: #563c27;
    padding: 20px;
    padding-bottom: 1px;
}
.th2 {
    font-size: 20px;
    color: #563c27;
    padding: 20px;
    padding-bottom: 30px;
}
.btn {
    margin: 15px 30px;
    width: 150px;
    color: #545454;
    border: 1px solid #dadada;
    background-color: #dadada;
    padding: 0 10px;
    height: 30px;
    font-size: 13px;
}
</style>
<script type="text/javascript">
$(function(){
   
} );//ready
</script>
</head>
<body>
<div class="page_top">
    <h2 class="page_title">개인정보관리</h2>
</div>
<div id="content">
	<div class="mypage">
		<div class="box_wrap">
		<table class="tb">
		<tr>
			<th colspan="4"><h3 class="th">개인정보 수정</h3></th>
		</tr>
		<tr>
			<th colspan="4"><p class="th2">회원 정보 및 비밀번호는 해당 사이트를 통해 수정 가능합니다.</p></th>
		</tr>
		<tr>
			<td><input type = "button" class="btn" value="개인정보 수정" onclick="location.href='edit_member_pw.jsp'"></td>
			<td><input type = "button" class="btn" value="비밀번호 수정" onclick="location.href='find_pw3.jsp'"></td>
			<td><input type = "button" class="btn" value="회원탈퇴" onclick="location.href=''"></td>
			<td><input type = "button" class="btn" value="주문내역" onclick="location.href=''"></td>
		</tr>
		</table>
		</div>
	</div>
</div>
</body>
</html>
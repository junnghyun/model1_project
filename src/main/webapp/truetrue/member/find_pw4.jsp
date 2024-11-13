<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="아이디 찾기 결과 페이지" %>
<%@ page import="kr.co.truetrue.member.MemberDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경결과</title>
<link rel="shortcut icon" href="http://192.168.10.223/jsp_prj/common/images/paka.jpg">
<link rel="stylesheet" type="text/css" href="http://192.168.10.223/jsp_prj/common/CSS/main_20240911.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.cont_header {
    padding-top: 75px;
    text-align: center;
    font-size: 14px;
    font-family: Arial, nbgr, '나눔바른고딕', '돋음';
    line-height: 24px;
}
.id_find_wrap {
    margin: 0 auto;
    width: 900px;
    padding: 50px;
    border-top: 1px solid #222;
    background-color: #f8f8f8;
}
.find_handy {
    width: 500px;
    height: 200px;
    margin: 0 auto;
    text-align: center;
}
.em {
    color: #ee6900;
    font-weight: bold;
    font-style: normal;
}
.btn.btn_em {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    padding: 0 15px;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 100px;
    width: 375px;
}
.cont_area {
    padding-top: 60px;
}
.desc {
	margin-top: 20px;
}
</style>
</head>
<body>
<div class="cont_header">
    <h1>비밀번호 변경</h1>
    <p>고객님의 소중한 정보를 보호하기 위하여 새로운 비밀번호로 변경 후 서비스를 이용해 주세요.</p>
</div>
<div class="cont_area">
<div class="id_find_wrap">
<div class="find_handy">
    <form action="../../index.jsp" method="GET">
    	<img src="../common/images/pwDone.png">
        <p class="desc"><em class="em">회원정보가 수정</em>되었습니다.</p>
        <button type="button" class="btn btn_em" id="btnSearch">메인페이지</button>
    </form>
</div>
</div>
</div>

<script type="text/javascript">
$('#btnSearch').on('click', function(){ 
    $('form').submit();
});
</script>
</body>
</html>

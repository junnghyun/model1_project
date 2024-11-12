<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 페이지에서 이미 등록된 회원이 이동할 수 있는 페이지"
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
.btn.btn_login {
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
.btn.btn_id {
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
.cong{
	font-size: 25px;
}

</style>
<script type="text/javascript">

</script>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String id = request.getParameter("user_id");

// 이름 마스킹
if (name != null && name.length() > 0) {
    if (name.length() <= 2) {
        name = name.replaceAll(".", "*");
    } else {
        StringBuilder maskedName = new StringBuilder();
        maskedName.append(name.charAt(0)); // 첫 글자
        for (int i = 1; i < name.length() - 1; i++) {
            maskedName.append("*"); // 두번째 글자 마스킹
        }//end for
        maskedName.append(name.charAt(name.length() - 1)); // 마지막 글자
        name = maskedName.toString();
    }//end else
}//end if

// 아이디 마스킹
if (id != null && id.length() > 2) {
    StringBuilder maskedId = new StringBuilder(id);
    maskedId.setCharAt(id.length() - 2, '*'); // 마스킹
    maskedId.setCharAt(id.length() - 1, '*'); // 마스킹
    id = maskedId.toString();
} else if (id != null && id.length() <= 2) {
    // 전체 아이디 마스킹
    id = id.replaceAll(".", "*");
}
%>
<div class="cont_header">
	<h1 class="h1_tit">회원가입 완료</h1>
</div>
<div class="cont_area">
<div class="membership_wrap">
<div class="find_handy">
<form action="login.jsp" method="POST">
	<p class="cong"><span class="em"><%=name %></span>님! 이미 회원으로 등록되어 있습니다.</p><br>
	<p class="desc">회원 아이디(<%=id%>)로 로그인 하시거나 아이디 찾기를 진행 해 주세요.</p>
	<div class="btn_sec">
	<button type="button" class="btn btn_id" id="btn_id" onclick="location.href='find_id.jsp'">아이디 찾기</button>
	<button type="button" class="btn btn_login" id="btn_login" onclick="location.href='login.jsp'">로그인</button>
	</div>
</form>
</div>
</div>
</div>
</body>
</html>
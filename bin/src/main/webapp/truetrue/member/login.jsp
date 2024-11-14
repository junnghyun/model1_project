<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 메인 페이지"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title</title>
<link rel="shorcut icon"
href="http://192.168.10.223/jsp_prj/common/images/paka.jpg">
<link rel="stylesheet" type="text/css"
href="http://192.168.10.223/jsp_prj/common/CSS/main_20240911.css">
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelsivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
#login {
    width: 700px;
    height: 500px;
    margin: 0 auto;
    padding: 39px 101px 0 103px;
    border: 1px solid #cbc8c4;
    background: #fff;
}
.tit_memberlogin {
    font-size: 20px;
    color: #000;
}
h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
    unicode-bidi: isolate;
}
.btn{
    display: inline-block;
    position: relative;
    left: 200px;
    bottom: 120px;
    width: 96px;
    height: 70px;
    font-size: 17px;
    font-weight: bold;
    background-color: #184F3B;
    color: #F0F0F0;
}
.help {
    overflow: hidden;
    margin-top: 20px;
    font-size: 13px;
}
.item {
    padding-bottom: 10px;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 쿠키값 없으면 공백.
    var userLoginId = getCookie("userLoginId");
    $("input[name='user_id']").val(userLoginId); 
    // ID가 있는경우 아이디 저장 체크박스 체크
    if($("input[name='user_id']").val() != ""){
    	$("#idsave").attr("checked", true);
    }//end if
    // 아이디 저장하기 체크박스 onchange
    $("#idsave").change(function(){
    	if($("#idsave").is(":checked")){  //checked true
        	var userLoginId = $("input[name='user_id']").val();
            setCookie("userLoginId", userLoginId, 30); // 30일 동안 쿠키 보관
         }else{ //checked false
         	deleteCookie("userLoginId");
        }//end if
    });
     // 아이디 저장하기가  눌린상태에서, ID를 입력한 경우
     $("input[name='user_id']").keyup(function(){
     	if($("#idsave").is(":checked")){  //checked true
            var userLoginId = $("input[name='user_id']").val();
            setCookie("userLoginId", userLoginId, 30); // 30일 동안 쿠키 보관
        }//end if
    });
});

$(function(){
	$("#loginBtn").click(function(){
		chkNull();
	});
});//ready

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}//setCookie
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}//delete Cookie
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }//end if
    return unescape(cookieValue);
}//getCookie

function chkNull(){
	if($("#user_id").val()==""){
		alert("아이디를 입력해주세요.");
		$("#user_id").focus();
		return;
	}//end if
	if($("#pass").val()==""){
		alert("비밀번호를 입력해주세요.");
		$("#pass").focus();
		return;
	}//end if
	$("#loginForm").submit();
}//chkNull


</script>
</head>
<body class=" reform">
<div class="page_top">
    <h2 class="page_title">로그인</h2>
</div>
<form action="loginProcess.jsp" id= "loginForm" name="loginForm" method="POST" class="login">
    <div id="login" class="login">
        <h2 class="tit_memberlogin">회원로그인</h2>
        <p>보다 많은 서비스를 위해 로그인 하시기 바랍니다.<br/>뚜르뚜르의 더 많은 혜택과 이벤트를 누리세요!</p>
        <fieldset>
        <hr>
        <div class="item">
           <input type="text" id="user_id" name="user_id" class="user_id" placeholder="아이디"/>
        </div>
        <div class="item">
            <input type="password" id="pass" name="pass" class="pass" placeholder="비밀번호" />
        </div>                        
        </fieldset>
        <div class="help">
            <input type="checkbox" id="idsave" /><label for="idsave">아이디 저장</label>
            <span><a href="find_id.jsp">아이디 찾기</a></span>
            <span><a href="find_pw.jsp">비밀번호 찾기</a></span>
        </div>
<span class="btn_login"><button type=button class="btn" id="loginBtn" name="loginBtn">로그인</button></span>
<span class="btn_membership"><input type="button" class="btn" value="회원가입" onclick="location.href='membership.jsp'"/></span>
    </div>
</form>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입을 하기 전 등록회원 여부를 판단"
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
    margin-bottom: 100px;
}
.em {
    color: #ee6900;
    font-weight: normal;
}
.btn.btn_em {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 10px;
    width: 375px;
}
.check_member_txt {
    float: left;
    width: 470px;
}
ul, dl {
    margin: 0;
    padding: 0;
    list-style: none;
}
.bul_list .dot_arr {
    display: block;
    margin-bottom: 6px;
    padding-left: 10px;
    color: #555;
    line-height: 1.5;
}
.check_member_form {
    float: right;
    width: 450px;
}

.input_txt {
    display: inline-block;
    height: 34px;
    padding-right: 32px;
    vertical-align: middle;
    zoom: 1;
}
.box_member {
    padding: 80px;
    border-top: 1px solid #222;
    background: #f8f8f8;
    height: 350px;
    width: 1100px;
    margin: 0px auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
    // 생년월일 숫자 및 길이 제한 검증
    $('#birth').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, ''); // 숫자만 입력되도록 함
        if (this.value.length > 6) {
            this.value = this.value.slice(0, 6); // 6자 초과하면 자름
        }//end if
    });
    // 핸드폰 번호 숫자 및 길이 제한 검증
    $('#phone').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, ''); // 숫자만 입력되도록 함
        if (this.value.length > 8) {
            this.value = this.value.slice(0, 8); // 8자 초과하면 자름
        }//end if
    });
 	// 이름 필드에서 한글과 영어만 입력되도록 제한
    $('#name').on('input', function() {
        this.value = this.value.replace(/[^ㄱ-ㅎ|가-힣|a-z|A-Z]/g, ''); // 한글과 영어만 입력되도록 함
    });
    // 비밀번호 찾기 버튼 클릭 시 필수 입력 검증 및 서버 요청
    $('#btnSearch').on('click', function(e) {
    	e.preventDefault(); // 기본 동작(폼 전송)을 막음
        const userName = $('#name').val();
        const birthDate = $('#birth').val();
        const mobileNo = $('#phone').val();
        // 입력 필드 검증
        if (!userName || !birthDate || !mobileNo) {
            alert('모든 필드를 입력해주세요.');
            return;
        }//end if
        if (birthDate.length !== 6) {
            alert('생년월일은 6자리여야 합니다.');
            return;
        }//end if
        if (mobileNo.length < 7 || mobileNo.length > 8) {
            alert('휴대전화번호는 7~8자리여야 합니다.');
            return;
        }//end if
   		// DB 연결 후 코드 추가
   		// 가입된 정보가 있을 시 membership_member로,
    	// 가입된 정보가 없을 시 회원가입 정보 입력 페이지로
    	// 수정 필요
        // 회원가입 여부에 따라 다른 페이지로 이동
         if (isRegistered) {
            // 회원가입 되어 있을 경우
            RequestDispatcher dispatcher = request.getRequestDispatcher("membership_member.jsp");
            dispatcher.forward(request, response);
        } else {
            // 회원가입 안되어 있을 경우
            RequestDispatcher dispatcher = request.getRequestDispatcher("dduru_join_frm.jsp");
            dispatcher.forward(request, response);
        } 
  });
});
</script>
</head>
<body>
<div class="cont_header">
	<h1 class="h1_tit">회원가입</h1>
</div>
<div class="check_member">
<div class="box_member">
	<dl class="check_member_txt">
	<dt>회원가입 여부 안내</dt>
	<dd>
		<span>기존 회원가입 정보와 일치하는 정보를 입력하셔야<br> 회원가입 여부를 정확하게 확인하실 수 있습니다. <br><em class="em">입력하신 정보는 회원가입 여부에만 <br> 사용되며 저장되지 않습니다.</em></span>
	</dd>
	</dl>
	<form class="check_member_form" method="POST">
		<span class="input_txt"><input type="text" class="text" id="name" name="name" placeholder="이름을 입력해주세요."  size="45"></span>
		<p class="msg_info hide" id="msg_name" ></p>
		<span class="input_txt"><input type="text" class="text" id="birth" name="birth" placeholder="법정생년월일 6자리를 입력해주세요." maxlength="6" size="45"></span>
		<p class="msg_info hide" id="msg_birth" ></p>
		<span class="input_txt"><input type="text" class="text" id="phone" name="phone" placeholder="휴대전화번호 뒤 7~8자리를 입력해주세요. (01X 제외)" maxlength="8" size="45"></span>
		<p class="msg_info hide" id="msg_phone"></p>
		<div class="btn_sec">
			<button type="button" class="btn btn_em" id="btnSearch">가입여부확인</button>
		</div> 
	</form>
</div>
</div>
</body>
</html>
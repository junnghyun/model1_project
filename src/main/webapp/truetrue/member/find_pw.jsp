<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="비밀번호 찾기 페이지"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title</title>
<link rel="shorcut icon"
href="../jsp_prj/common/images/paka.jpg">
<link rel="stylesheet" type="text/css"
href="../jsp_prj/common/CSS/main_20240911.css">
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
.pw_find_wrap {
	margin:0px auto;
	width: 900px;
    padding: 50px;
    border-top: 1px solid #222;
    background-color: #f8f8f8;
}
.find_handy {
	width:500px;
	height:400px;
    margin-top: 40px;
    margin: 0px auto;
    text-align: center;
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
    padding: 0 15px;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 10px;
    width: 375px;
}
.cont_area {
    padding-top: 60px;
}
.h2_tit {
    line-height: 50px;
    display: block; /* 입력 필드가 한 줄에 표시되도록 설정 */
    padding-bottom: 50px;
}
.input_txt {
    margin-bottom: 5px; /* input 필드 사이 간격 추가 */
    display: block; /* 입력 필드가 한 줄에 표시되도록 설정 */
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
        $('form').submit();
  });
});
</script>
</head>
<body>
<div class="cont_header">
	<h1>비밀번호 찾기</h1>
	<p>비밀번호가 기억나지 않으세요? 원하시는 방법을 선택해 비밀번호를 확인하실 수 있습니다.</p>
</div>
<div class="cont_area">
<div class="pw_find_wrap">
<div class="find_handy">
	<h2 class="h2_tit">비밀번호 발급</h2>
	<form action="../Tourtour_prj/first_prj/find_pw2.jsp" method="POST">
	<span class="input_txt">
		<input type="text" class="text" id="name" name="name" placeholder="이름을 입력해주세요." title="이름을 입력해주세요." size=45><br>
	</span>
	<span class="input_txt">
		<input type="text" class="text" id="birth" name="birth" placeholder="법정생년월일 6자리를 입력해주세요." title="법정생년월일 6자리를 입력해주세요." maxlength="6" size=45><br>
	</span>
	<span class="input_txt">
		<input type="text" class="text" id="phone" name="phone" placeholder="휴대전화번호 뒤 7~8자리를 입력해주세요. (010 제외)" title="휴대전화번호 뒤 7~8자리를 입력해주세요. (01X 제외)" maxlength="8" size=45><br>
	</span>
		<div class="btn_sec">
		<button type="button" class="btn btn_em" id="btnSearch">비밀번호 재설정</button>
		</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../common/css/main_20240911.css">
<link rel="stylesheet" type="text/css" href="../common/css/common.css" />
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
.center{text-align: center;}
.mainTitle{font-family:'Nanum Barun Gothic'; font-size: 45px; margin-top: 100px;}
.subTitle{font-family:'Nanum Barun Gothic'; font-size: 13px; margin-top: 25px; margin-bottom: 50px;}
.tableChange{margin: 0 auto; font-size: 25px; margin-bottom: 50px;}
.tableChange td {margin: 0 auto; font-size: 25px; }
#fCell{width: 270px; height: 63px; font-size: 15px; padding: 20px; background-color: #F8F8F8; border-bottom:1px solid #E3E3E3; }
#sCell{width: 800px; height: 63px; font-size: 15px; padding: 20px; border-bottom:1px solid #E3E3E3; }
#topLine{border-top: 3px solid #333;}
.btnChange{width: 100px; height: 40px; font-size: 16px; padding: 4px; border-radius: 3px; background-color: #ffffff; border: 1px solid #A9A9A9 }
.btnZipcode{width: 100px; height: 35px; font-size: 13px; padding: 3px; border-radius: 3px; background-color: #ffffff; border: 1px solid #A9A9A9 }
.btnRight{position:relative; top: -15px; left: 960px; width: 100px; height: 40px; font-size: 16px; padding: 4px; border-radius: 3px; background-color: #ffffff; border: 1px solid #A9A9A9;}
.mynameisbaekeonhee{position:relative; top: 25px; left: 20px; font-weight: bold;}
.addrInputZipcode{width: 300px; height: 35px; border: 1px solid #A9A9A9; background-color: #fefefe; margin-bottom: 5px;}
.addrInput{width: 600px; height: 35px; border: 1px solid #A9A9A9; background-color: #fefefe; margin-bottom: 2px}
.emailInput{width: 150px; height: 35px; border: 1px solid #A9A9A9; background-color: #fefefe; margin-bottom: 2px}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
/*                 if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
 */
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script type="text/javascript">
$(function(){
	$("#selectEmail").change(function(){
		$("#email2").val($("#selectEmail").val());
	})
});//ready
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
	<div class="center">
	<h2 class="mainTitle">회원정보 수정</h2>
	</div>
	<div class="center">
	<h2 class="subTitle">회원님의 소중한 정보를 안전하게 관리하세요</h2>
	</div>
<table class="tableChange">
	<tr>
	<th>
		<h3 class="mynameisbaekeonhee">기본정보</h3>
		<input type="button" class="btnRight" value="회원탈퇴>">
	</th>
	</tr>
	<tr id="topLine">
		<td id="fCell">이름</td>
		<td id="sCell"></td>
	</tr>
	<tr>
		<td id="fCell">아이디</td>
		<td id="sCell"></td>
	</tr>
	<tr>
		<td id="fCell">생년월일</td>
		<td id="sCell"></td>
	</tr>
	<tr>
		<td id="fCell">휴대전화번호</td>
		<td id="sCell"></td>
	</tr>
	<tr>
		<td id="fCell">이메일</td>
		<td id="sCell">
		<input type="text" class="emailInput" name="email1" id="email1"> @ <input type="text" class="emailInput" name="email2" id="email2">
		<select id="selectEmail">
			<option value="---" disabled="disabled" selected="selected">선택해주세요
			<option value="">직접 입력
			<option value="naver.com">naver.com
			<option value="gmail.com">gmail.com
			<option value="hanmail.net">hanmail.net
			<option value="hotmail.com">hotmail.com
			<option value="nate.com">nate.com
		</select>
		</td>
	</tr>
	<tr>
		<td id="fCell">비밀번호</td>
		<td id="sCell">
		<input type="button" class="btnZipcode" value="변경하기>">
		</td>
	</tr>
	<tr>
		<td id="fCell">주소</td>
		<td id="sCell">
			<input type="text" class="addrInputZipcode" id="sample6_postcode" placeholder="우편번호">
			<input type="button" class="btnZipcode" onclick="sample6_execDaumPostcode()" value="우편번호 검색"><br>
			<input type="text" class="addrInput" id="sample6_address" placeholder="주소"><br>
			<input type="text" class="addrInput" id="sample6_detailAddress" placeholder="상세주소">
		</td>
	</tr>


</table>
<div class="center">
<input type="button" value="변경하기>" class="btnChange">
</div>
</div>
</body>
</html>
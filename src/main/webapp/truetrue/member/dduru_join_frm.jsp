<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="../common/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="../common/css/main_20240911.css"/>
<!--  bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!--  jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
td{height: 42px;padding-left: 20px;padding-top: 20px;padding-bottom: 20px;}
tr{border-top-color: #E9E9E9; border-bottom-color:#E9E9E9;border-style: solid;border-top-width: 1px;border-bottom-width: 1px;}
.b1{background-color:#F8F8F8;width:200px }

#agree{
	width : 1400px; height : 180px; border: 1px solid #333;
	overflow : auto;
	
}
</style>
<script type="text/javascript">

$(function(){
	$("#selectEmail").change(function(){
		$("#email2").val($("#selectEmail").val());
	});
});//ready


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 우편번호 API시작 -->
<script type="text/javascript">
window.onload=function(){
	document.getElementById("idbtn2").addEventListener("click",idDup2);
	document.getElementById("findZipcode").addEventListener("click",searchZipcode);

	$("#btnSubmit").click(function(){
		const phone1=$("#phone1").val();
		const phone2=$("#phone2").val();
		const phone3=$("#phone3").val();
		
		const phoneNum=($("#phone1").val())+($("#phone2").val())+($("#phone3").val());
		const regex=/^[0-9]+$/;
		const regex1 = /^[a-zA-Z0-9]+$/;
		const regex2 = /^[a-zA-Z0-9!@#$%^&*()_\-=\{\}\[\]|;:,.<>?]+$/;
		const regex3 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$/;
		const pass=$("#pass").val();
		const chk_pass=$("#chk_pass").val();
		const userId=$("#id").val();
		const birth=$("#birthday").val();
		const name=$("#name").val();
		const email=$("#email").val()+"@"+$("#email2").val();
		
		if(name == null || name === ""){
			alert("이름은 필수입력사항입니다.");
			return false;
		}
		if(userId == null || userId === ""){
			alert("아이디는 필수입력사항입니다.");
			return false;
		}
		if(pass!=chk_pass){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		if(pass == null || pass === ""){
			alert("비밀번호는 필수입력사항입니다.");
			return false;
		}
		if(birth == null || birth === ""){
			alert("생년월일은 필수선택사항입니다.");
			return false;
		}
		if(!regex1.test(userId)){
			alert("아이디에는 영어와 숫자만 사용가능합니다.");
			return false;
		}
		if(userId.length < 5 || userId.length > 20){
			alert("아이디는 최소 5자리 이상, 최대 20자리까지 가능합니다.");
			return false;
		}
		if(!regex3.test(email)){
			alert("이메일에는 영어와 숫자만 사용가능합니다.");
			return false;
		}
		if(!regex2.test(pass)){
			alert("비밀번호에는 영어와 숫자 그리고 허용된 일부 특수문자만 사용가능합니다.");
			return false;
		}

		if(pass.length < 8 || pass.length > 15){
			alert("비밀번호는 최소 8자리 이상, 최대 15자리 이하까지 가능합니다.");
			return false;
		}
		if((phone2==null || phone2==="")&&(phone3==null||phone3==="")){
			alert("전화번호를 둘다쓰던지 아예쓰지말던지");
			return false;
		}
		if(!regex.test(phoneNum)){
			alert("전화번호에는 숫자만 입력가능합니다.");
			return false;
		}
		
		if(!$("#btnChk").prop("checked")) {
	        alert("약관에 동의해주세요.");
	        return false;
	    }
		
		$("#memberFrm").submit();
	});//click
}//onload



//부모창에서 자식창으로 값 전달 : Query String 만들어서 팝업창 띄우기
function idDup2(){
	var left=window.screenX+350;
	var top=window.screenY+200;
	//1.현재창에 아이디를 가져와서
	var id=$("#id");
	//2. query String 만들어서 팝업을 띄운다.
	var id=document.memberFrm.id.value;
	
	window.open("id_dup.jsp?id="+id,"idDup",
			"width=460,height=380,left="+left+",top="+top);
}//idDup


</script>
<script type="text/javascript">
function searchZipcode() {
new daum.Postcode({
    oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var roadAddr = data.roadAddress; // 도로명 주소 변수
        var extraRoadAddr = ''; // 참고 항목 변수

        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraRoadAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가한다.
        if(data.buildingName !== '' && data.apartment === 'Y'){
           extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraRoadAddr !== ''){
            extraRoadAddr = ' (' + extraRoadAddr + ')';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('zipcode').value = data.zonecode;
        document.getElementById("addr1").value = roadAddr;
        document.getElementById("addr2").focus();
        
    }
}).open();
}

</script>	
</head>
<body>

	<form name="memberFrm" id="memberFrm" method="post" action="join_frm_process.jsp">
	<div align="left">
		<h2 >기본정보</h2>

		<table>
			<!-- id 입력 -->
			<tr style="border-top-color:#6D6D6D;">
				<td class="b1"><span class="required">*</span>이름</td>
				<td>
					<input type="text" name="name" id="name" class="inputBox" style="width:250px">
					
				</td>
				
			</tr>
			<tr>
				<td class="b1"><span class="required">*</span><label>아이디</label></td>
				<td>
					<input type="text" name="id" id="id" class="inputBox" style="width:250px" placeholder="아이디를 입력해주세요."> 
					<input type="button" id="idbtn2" class="idbtn btnMy" value="ID 중복 확인" style="width:150px">
					<p></p>
				</td>
			</tr>

			<tr>
				<td class="b1"><span class="required">*</span>비밀번호</td>
				<td>
					<input type="password" name="pass" id="pass" class="inputBox" style="width:250px" placeholder="비밀번호를 입력해주세요.">
					<p></p>
				</td>
			</tr>
			<tr>
				<td class="b1"><span class="required">*</span>비밀번호 확인</td> 
				<td>
					<input type="password" name="chk_pass" id="chk_pass" class="inputBox" style="width:250px" placeholder="비밀번호를 재입력해주세요.">
				</td>
			</tr>


			<tr>
				<td class="b1"><span class="required">*</span>생년월일</td>
				<td>
    				<input type="date" id="birthday" name="birthday">
    				<p></p>
				</td>
			</tr>

			<tr>
				<td class="b1"><span class="required">*</span>휴대전화</td>
				<td>
   					 <select id="phone1" name="phone1">
				        <option value="">직접 입력</option>
				        <option value="010" selected="selected">010</option>
				        <option value="011">011</option>
				        <option value="016">016</option>
				        <option value="017">017</option>
				        <option value="018">018</option>
				        <option value="019">019</option>
   					 </select>
				    -
				    <input type="text" id="phone2" name="phone2" maxlength="4" size="4" required>
				    -
				    <input type="text" id="phone3" name="phone3" maxlength="4" size="4" required>
				    <p>주문 및 배송, 쿠폰, 이벤트 정보 등을 제공 받을 수 있습니다.</p>
				 </td>
			</tr>

			<tr>
				<td class="b1"><span class="required">*</span>이메일</td>
				<td>
					
					<input type="email" name="email" id="email" class="inputBox" style="width:170px"> @
					<input type="email" name="email2" id="email2" class="inputBox" style="width:170px">
					<select size="1" class="inputBox" id="selectEmail">
						<option value="" selected="selected">선택해주세요</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
					</select>
					<p>이메일 주소 입력 시 사용 가능 특수 문자 : -._</p>
				</td>
			</tr>

			<tr>
				<td class="b1"><span class="required">*</span>주소</td>
				<td>
					<input type="text" name="zipcode" id="zipcode" readonly="readonly" class="inputBox" style="width:70px"> 
					<input type="button" value="우편번호 검색" id="findZipcode" class="btnMy" style="width:140px"><br>
					<input type="text" name="addr1" id="addr1" readonly="readonly" class="inputBox" style="width:500px"> <br> 
					<input type="text" name="addr2" id="addr2" class="inputBox" style="width:500px">
				</td>
			</tr>


		</table>
	</div>
	<div id="agree" >
		<h5 class="marno" style="font-family: 돋움, Dotum, Helvetica, sans-serif;"><p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>장
		총칙<span lang="EN-US" style=""><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>조
		목적<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">이 약관은 쌍용교육센터에서 제공하는 서비스 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 쌍용교육센터과<span lang="EN-US">(</span>와<span lang="EN-US">) </span>이용자의 권리<span lang="EN-US">, </span>의미
		및 책임사항 등을 규정함을 목적으로 합니다<span lang="EN-US">.<o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>조
		약관의 효력과 변경<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">이 약관은
		이용자에게 공시함으로서 효력이 발생합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		사정 변경의 경우와 영업상 중요사유가 있을 때 약관을 변경할 수 있으며<span lang="EN-US">, </span>변경된 약관은 전항과 같은
		방법으로 효력이 발생합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">3</span>조
		약관 외 준칙<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">이 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다<span lang="EN-US">.<o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>장
		회원 가입과 서비스 이용<span lang="EN-US" style=""><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>조
		회원의 정의<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">회원이란 쌍용교육센터에서 회원으로 적합하다고 인정하는 일반 개인으로 본 약관에 동의하고 서비스의 회원가입
		양식을 작성하고<span lang="EN-US"> 'ID'</span>와<span lang="EN-US"> '</span>비밀번호<span lang="EN-US">'</span>를 발급받은 사람을 말합니다<span lang="EN-US">.<o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>조
		서비스 가입의 성립<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스 가입은
		이용자의 이용신청에 대한 쌍용교육센터의 이용승낙과 이용자의 약관내용에 대한 동의로 성립됩니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">회원으로
		가입하여 서비스를 이용하고자 하는 희망자는 쌍용교육센터에서 요청하는 개인 신상정보를 제공해야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">이용자의
		가입신청에 대하여 쌍용교육센터에서 승낙한 경우<span lang="EN-US">, </span>쌍용교육센터는 회원<span lang="EN-US">
		ID</span>와 기타 쌍용교육센터에서 필요하다고 인정하는 내용을 이용자에게 통지합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(4) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">가입할 때
		입력한<span lang="EN-US"> ID</span>는 변경할 수 없으며<span lang="EN-US">, </span>한 사람에게 오직 한 개의<span lang="EN-US"> ID</span>가 발급됩니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(5) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		다음 각 호에 해당하는 가입신청에 대하여는 승낙하지 않습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>다른 사람의 명의를 사용하여 신청하였을 때<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>본인의 실명으로 신청하지 않았을 때<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>가입 신청서의 내용을 허위로 기재하였을 때<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">라<span lang="EN-US">. </span>사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청하였을
		때<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">3</span>조
		서비스 이용 및 제한<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스 이용은
		회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴<span lang="EN-US">, 1</span>일<span lang="EN-US">
		24</span>시간을 원칙으로 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">전항의 서비스
		이용시간은 시스템 정기점검 등 쌍용교육센터에서 필요한 경우<span lang="EN-US">, </span>회원에게 사전 통지한 후 제한할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스 내용
		중 온라인상담은 답변하는 전문의사의 개인사정에 따라<span lang="EN-US"> 1</span>일<span lang="EN-US"> 24</span>시간
		서비스가 불가능 할 수도 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">4</span>조
		서비스의 사용료<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스는
		회원으로 등록한 모든 사람들이 무료로 사용할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터에서
		서비스를 유료화할 경우 유료화의 시기<span lang="EN-US">, </span>정책<span lang="EN-US">, </span>비용에 대하여
		유료화 실시 이전에 서비스에 공시하여야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">3</span>장
		서비스 탈퇴<span lang="EN-US" style="">, </span>재가입 및 이용 제한<span lang="EN-US" style=""><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>조
		서비스 탈퇴<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">회원이 서비스의
		탈퇴를 원하면 회원 본인이 직접 전자메일을 통해 운영자에게 해지 신청을 요청해야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">탈퇴 신청시
		본인임을 알 수 있는 이름<span lang="EN-US">, ID, </span>전화번호<span lang="EN-US">, </span>해지사유를
		알려주면<span lang="EN-US">, </span>가입기록과 일치 여부를 확인한 후 가입을 해지합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">탈퇴 여부는
		기존의<span lang="EN-US"> ID</span>와 비밀번호로 로그인이 되지 않으면 해지된 것입니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>조
		서비스 재가입<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">제<span lang="EN-US">1</span>조에 의하여 서비스에서 탈퇴한 사용자가 재가입을 원할 경우<span lang="EN-US">, </span>회원
		본인이 직접 재가입을 할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">재가입 시
		입력한<span lang="EN-US">ID</span>와 비밀번호로 로그인이 되면 재가입이 이루어진 것입니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">3</span>조
		서비스 이용제한<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">쌍용교육센터는 회원이 다음 사항에 해당하는 행위를 하였을 경우<span lang="EN-US">, </span>사전통지
		없이 이용계약을 해지하거나 기간을 정하여 서비스 이용을 중지할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>공공 질서 및 미풍 양속에 반하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>범죄적 행위에 관련되는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을
		계획 또는 실행할 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">라<span lang="EN-US">. </span>타인의<span lang="EN-US"> ID </span>및
		비밀번호를 도용한 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">마<span lang="EN-US">. </span>타인의 명예를 손상시키거나 불이익을 주는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">바<span lang="EN-US">. </span>같은 사용자가 다른<span lang="EN-US"> ID</span>로
		이중 등록을 한 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">사<span lang="EN-US">. </span>서비스에 위해를 가하는 등 건전한 이용을 저해하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">아<span lang="EN-US">. </span>기타 관련 법령이나 쌍용교육센터에서 정한 이용조건에 위배되는
		경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">4</span>장
		서비스에 관한 책임의 제한<span lang="EN-US" style=""><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>조
		온라인상담<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		서비스의 회원 혹은 사용자들의 상담내용이 상담의사와 서비스 관리자를 제외한 제<span lang="EN-US">3</span>자에게 유출되지 않도록
		최선을 다해 보안을 유지하려고 노력합니다<span lang="EN-US">. </span>그러나 다음과 같은 경우에는 상담 내용 공개 및 상실에 대하여
		쌍용교육센터의 책임이 없습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>사용자의 부주의로 암호가 유출되어 상담내용이 공개되는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>사용자가<span lang="EN-US"> '</span>삭제<span lang="EN-US">' </span>기능을 사용하여 상담을 삭제하였을 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>천재지변이나 그 밖의 쌍용교육센터에서 통제할 수 없는 상황에
		의하여 상담내용이 공개되거나 상담내용이 상실되었을 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">회원이 신청한
		상담에 대한 종합적이고 적절한 답변을 위하여 쌍용교육센터의 행정 전담인력은 상담내용과 답변을 참고할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스에서
		진행된 상담의 내용은 개인 신상정보를 삭제한 다음 아래와 같은 목적으로 사용할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>학술활동<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>인쇄물<span lang="EN-US">, CD-ROM </span>등의
		저작활동<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. FAQ, </span>온라인상담 등의 서비스 내용의 일부<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(4) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">상담에 대한
		답변내용은 행정전담인력의 <span lang="EN-US">IT </span>지식을 바탕으로 한 주관적인 답변으로 쌍용교육센터의 서비스 의견을 대표하지는
		않습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(5) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">아래와 같은
		상담을 신청하는 경우에는 온라인상담 전체 또는 일부 제공하지 않을 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>같은 내용의 상담을 반복하여 신청하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>상식에 어긋나는 표현을 사용하여 상담을 신청하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>부정훈련에 부합된다고 인정 되는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>조
		정보 서비스<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">홈페이지
		서비스에서 제공되는 내용은 개략적이며 일반적인 내용이고 정보제공만을 위해 제공됩니다<span lang="EN-US">. </span>홈페이지 회원은
		다음의 서비스를 제공 받을 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>취업과정<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>재직자과정<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>교육제도안내<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">라<span lang="EN-US">. </span>기업교육컨설팅<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">마<span lang="EN-US">. </span>구인의뢰<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">바<span lang="EN-US">. </span>교육문의게시판<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">위 교육서비스를
		받기 위해서는 사용자 로그인을 하셔야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">교육서비스는
		지속적으로 추가 제공 될 것이며<span lang="EN-US">, </span>불가피한 사정에 의해 서비스의 내용을 변경하거나 중단할 수 있습니다<span lang="EN-US">. </span>서비스가 변경되거나 중단되는 경우 회원에게 홈페이지를 통해서 공지합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">5</span>장
		의무<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">1</span>조
		회사의 의무<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		특별한 사정이 없는 한 회원이 서비스를 이용할 수 있도록 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		이 약관에서 정한 바에 따라 계속적<span lang="EN-US">, </span>안정적으로 서비스를 제공할 의무가 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		회원으로부터 소정의 절차에 의해 제기되는 의견에 대해서 적절한 절차를 거쳐 처리하며<span lang="EN-US">, </span>처리시 일정기간이
		소요될 경우 회원에게 그 사유와 처리 일정을 알려주어야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">2</span>조
		회원정보 보안의 의무<span lang="EN-US" style="font-weight: normal;"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">회원의<span lang="EN-US"> ID</span>와 비밀번호에 관한 모든 관리의 책임은 회원에게 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">회원은 서비스의
		일부로 보내지는 서비스의 전자우편을 받는 것에 동의합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(3) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">자신의<span lang="EN-US"> ID</span>가 부정하게 사용된 경우<span lang="EN-US">, </span>회원은 반드시 쌍용교육센터에 그 사실을
		통보해야 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(4) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		개인의 신분 확인이 가능한 정보를 회원 혹은 사용자의 사전허락 없이 쌍용교육센터와 관계가 없는 제<span lang="EN-US">3</span>자에게
		팔거나 제공하지 않습니다<span lang="EN-US">. </span>그러나 쌍용교육센터는 자발적으로 제공된 등록된 정보를 다음과 같은 경우에
		활용할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">가<span lang="EN-US">. </span>회원들에게 유용한 새 기능<span lang="EN-US">, </span>정보<span lang="EN-US">, </span>서비스 개발에 필요한 정보를 개발자들에게 제공하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">나<span lang="EN-US">. </span>광고주들에게 서비스 회원과 사용자 집단에 대한 통계적<span lang="EN-US">(</span>결코 회원 개개인의 신분이 드러나지 않는<span lang="EN-US">) </span>정보를 제공하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size: 9pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;">다<span lang="EN-US">. </span>회원과 사용자 선호에 따른 광고 또는 서비스를 실시하기
		위하여 회사에서 사용하는 경우<span lang="EN-US"><o:p></o:p></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(5) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">게시판 등의
		커뮤니케이션 공간<span lang="EN-US">(</span>이하 커뮤니케이션 공간<span lang="EN-US">)</span>에 개인신분 확인이
		가능한 정보<span lang="EN-US">(</span>사용자 이름<span lang="EN-US">, ID, e-mail </span>주소 등<span lang="EN-US">)</span>가 자발적으로 공개될 수 있습니다<span lang="EN-US">. </span>이런 경우 공개된 정보가 제<span lang="EN-US">3</span>자에 의해 수집되고<span lang="EN-US">, </span>연관되어지며<span lang="EN-US">,
		</span>사용될 수 있으며 제<span lang="EN-US">3</span>자로부터 원하지 않는 메시지를 받을 수도 있습니다<span lang="EN-US">. </span>제<span lang="EN-US">3</span>자의 그러한 행위는 쌍용교육센터에서 통제할 수 없습니다<span lang="EN-US">. </span>따라서 쌍용교육센터는 쌍용교육센터에서 통제할 수 없는 방법에 의한 회원정보의 발견 가능성에 대해 아무런 보장을
		하지 않습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(6) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		서비스의 사용의 편의를 위하여<span lang="EN-US"> Cookie </span>기술을 사용할 수 있습니다<span lang="EN-US">.
		Cookie</span>란 다시 방문하는 사용자를 파악하고 그 사용자의 계속된 접속과 개인화된 서비스 제공을 돕기 위해 웹사이트가 사용하는 작은
		텍스트 파일입니다<span lang="EN-US">. </span>일반적으로<span lang="EN-US"> Cookie</span>는<span lang="EN-US"> Cookie</span>를 부여한 사이트 밖에서는 의미가 없는 유일한 번호를 사용자에게 부여하는 방식으로 작동합니다<span lang="EN-US">. Cookie</span>는 사용자의 시스템 내부로 침입하지 않으며 사용자의 파일에 위험하지 않습니다<span lang="EN-US">. </span>쌍용교육센터는 서비스의 광고주나 관련있는 제<span lang="EN-US">3</span>자가<span lang="EN-US"> Cookie</span>를 사용하는 것을 막을 수 없습니다<span lang="EN-US">. </span>회원 혹은 사용자가<span lang="EN-US"> Cookie</span>를 사용한 정보수집을 원하지 않는 경우에는 웹 브라우저에서<span lang="EN-US">
		Cookie</span>를 받아들일지 여부를 조절할 수 있습니다<span lang="EN-US">. </span>하지만 서비스<span lang="EN-US">(</span>특히<span lang="EN-US">, </span>개인화된 정보<span lang="EN-US">)</span>가
		제대로 작동하기 위해서는<span lang="EN-US"> Cookie</span>의 사용이 필요할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(7) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">쌍용교육센터는
		회원의 정보를 서비스 또는 회사와 업무제휴 업체간에 상호 제공<span lang="EN-US">/</span>활용할 수 있습니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="margin: 7.5pt 0cm; word-break: keep-all;"><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68);">제<span lang="EN-US" style="">6</span>장
		분쟁조정</span>
		<br class="Apple-interchange-newline"/><span style="font-size: 10.5pt; font-family: 돋움; color: rgb(68, 68, 68); font-weight: normal;"><span lang="EN-US"></span></span></p><p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(1) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">본 이용약관에
		규정된 것을 제외하고 발생하는 서비스 이용에 관한 제반문제에 관한 분쟁은 최대한 쌍방합의에 의해 해결하도록 한다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-weight: normal;"><span lang="EN-US" style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;
		color:#444444;mso-font-kerning:0pt">(2) </span><span style="font-size:9.0pt;
		font-family:돋움;mso-bidi-font-family:굴림;color:#444444;mso-font-kerning:0pt">서비스 이용으로
		발생한 분쟁에 대해 소송이 제기될 경우 회사의 소재지를 관할하는 법원을 관할법원으로 합니다<span lang="EN-US">.<o:p></o:p></span></span></span></p>
		
		<p class="MsoNormal" align="left" style="word-break: keep-all;"><span style="font-size:9.0pt;font-family:돋움;mso-bidi-font-family:굴림;color:#444444;
		mso-font-kerning:0pt"><span style="font-weight: normal;">부칙<span lang="EN-US"><br/>
		</span>이 약관은<span lang="EN-US"> 2021</span>년<span lang="EN-US"> 01</span>월<span lang="EN-US"> 01</span>일 시행합니다</span><span lang="EN-US"><span style="font-weight: normal;">.</span><o:p></o:p></span></span></p></h5>
						</div>
	<div>
		<input type="checkbox" value="개인정보취급방침" id="btnChk" name="btnChk">개인정보 취급방침
	</div>
	<div align="center" style="margin-top:30px">
		<input type="button" value="회원가입" name="btnSubmit" id="btnSubmit" class="btnMySubmit"> 
	</div>
	</form>
</body>
</html>

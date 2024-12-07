<%@page import="kr.co.truetrue.dao.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://192.168.10.222/html_prj/common/css/main_20240911.css">
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		chkNull();		
	});//click
	
	$("#id").keydown(function( evt ){
		if(evt.which == 13){
			chkNull();		
		}//end if
	});//click
	
	$("#btnUse").click(function(){
		useId();		
	});//click
	
});//ready

function useId(){
	var id=$("#id").val();
	opener.window.document.memberFrm.id.value=id;
// 	opener.window.document.memberFrm.idDupFlag.value='Y';
	self.close();
}//useId

function chkNull(){
	var id=$("#id").val();
	
	if(id.replace(/ /g,"")==""){
		alert("아이디를 입력해주세요.");
		$("#id").val("");
		$("#id").focus();
		return;
	}//end if
	
	$("#idDupFrm").submit();
}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">
	<div id="idBg">
	<form name="idDupFrm" id="idDupFrm" action="id_dup.jsp">
	<div id="idFrm">
		<input type="text" name="id" id="id" class="inputBox" value="${ param.id }"/>
		<input type="button" id="btn" value="아이디 중복확인" class="btnMy" style="width: 140px"/>
		<input type="text" style="display: none"/>
		<!-- web browser에서 키입력을 받는 HTML Form Control이 하나인 경우
		엔터를 치면 자동으로 submit 이된다.(자바스크립 유효성 검증을 실패해도 submit이된다.)
		=> <input type="text" 보이지 않게 생성하면 된다. -->
	</div>
	</form>
		<%
		String id=request.getParameter("id");
		
		if(id != null &&  !"".equals(id) ){
		userDAO uDAO=userDAO.getInstance();
		
		boolean selectFlag=uDAO.selectId(id);
		
		if(selectFlag){
		%>
		<div id="resultDiv2">입력하신 아이디(<%=id%>)는 
		<span id="resultMsg" style="color:#FF0000">사용중인 </span>아이디 입니다.</div>
		<%	
		}else{
		%>
		<div id="resultDiv">입력하신 <strong><%= id %></strong> 아이디는(은) 
		<span id="resultMsg">사용 가능 한 </span>
		아이디 입니다.
		<div style="text-align: center">
		<input type="button" value="사용" id="btnUse" class="btn btn-info"/>
		</div>
		</div>
		<%}//end else
		}//end if %>
		</div>
</div>
</body>
</html>
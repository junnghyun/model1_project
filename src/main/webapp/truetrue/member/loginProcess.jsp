<%@page import="kr.co.truetrue.dao.LoginDAO"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 체크 세션 페이지"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title</title>
<link rel="shortcut icon"
href="http://192.168.10.223/jsp_prj/common/images/paka.jpg">
<link rel="stylesheet" type="text/css"
href="http://192.168.10.223/jsp_prj/common/CSS/main_20240911.css">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
<div id="wrap">
<%
    // 사용자 입력 값 가져오기
    String userId = request.getParameter("user_id");
    String password = request.getParameter("pass");

    // 로그인 DAO 인스턴스 생성
    LoginDAO lDAO = new LoginDAO();

    // 사용자 검증
    boolean isValidUser = lDAO.validateUser(userId, password);

    if (isValidUser) {
        // 세션 생성 및 사용자 정보 저장
        session.setAttribute("user_id", userId); // 세션에 사용자 ID 저장
%>
        <script type="text/javascript">
            alert("로그인에 성공하셨습니다! 메인페이지로 이동합니다.");

        </script>
<%
    } else {
%>
        <script type="text/javascript">
            alert("아이디 또는 비밀번호가 잘못되었습니다. 다시 한 번 확인해주세요."); // 실패 시 경고창 표시
            window.location.href = "login.jsp?error=invalid"; // 실패 시 login.jsp로 이동
        </script>
<%
    }
%>
</div>
</body>
</html>

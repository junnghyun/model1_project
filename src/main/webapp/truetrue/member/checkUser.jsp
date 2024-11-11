<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
%>
<%@ page import="kr.co.truetrue.member.MemberDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String name = request.getParameter("name");
    String birth = request.getParameter("birth");
    String phone = request.getParameter("phone");

    // 입력 값 확인 (디버깅용)
    System.out.println("입력된 이름: " + name);
    System.out.println("입력된 생년월일: " + birth);
    System.out.println("입력된 전화번호: " + phone);
    
    MemberDAO mDAO = MemberDAO.getInstance();
    boolean isRegistered = false;

    try {
        String userId = mDAO.findId(name, birth, phone);
        isRegistered = (userId != null); // 사용자 ID가 있으면 등록된 사용자로 간주
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 응답으로 "true" 또는 "false"만 출력
    out.print(isRegistered ? "true" : "false");
%>
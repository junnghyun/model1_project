<%@page import="kr.co.truetrue.dao.userDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.dao.userVO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    
<%
    String userId = request.getParameter("userId");
    if (userId != null) {
        userVO uVO = new userVO();
        uVO.setUser_id(userId);
        userDAO uDAO = new userDAO();
        try {
            String result = uDAO.deleteUser(uVO);  // String을 반환받는 경우
            if ("success".equals(result)) {
                out.print("success");  // 탈퇴 성공
            } else if ("fail".equals(result)) {
                out.print("fail");  // 탈퇴 실패
            } else {
                out.print("error");  // 예상치 못한 오류 발생
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("error");  // SQL 예외 처리
        }
    } else {
        out.print("invalid");  // 잘못된 요청
    }
%>
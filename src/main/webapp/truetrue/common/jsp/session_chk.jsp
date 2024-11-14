<%@page import="kr.co.truetrue.member.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty userData }">
<c:redirect url="index.jsp"/>
</c:if>

<%
String remoteIp=request.getRemoteAddr();

String sessionId=((LoginVO)session.getAttribute("userData")).getUser_id();
%>
<%@page import="kr.co.turetrue.admin.login.AdminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty adminData }">
<c:redirect url="/admin/admin_login/admin_login.jsp"/>
</c:if>

<%
String remoteIp=request.getRemoteAddr();

String sessionId=((AdminVO)session.getAttribute("adminData")).getAdmin_id();
%>

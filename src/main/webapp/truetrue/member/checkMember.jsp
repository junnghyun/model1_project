<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.truetrue.dao.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%
    String userName=request.getParameter("userName");
    String moblieNo="010"+request.getParameter("mobileNo");
    String birthDate=request.getParameter("birthDate");
    Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	DbConnection dbCon=DbConnection.getInstance();
	String register="select withdrawn_flag from users where name = ? and phone = ?";
	boolean yn=false;
	try{
		con=dbCon.getConn();
		pstmt=con.prepareStatement(register);
		pstmt.setString(1, userName);
		pstmt.setString(2, moblieNo);
		rs=pstmt.executeQuery();
		if(rs.next()){
			yn=true;
		}else{
			yn=false;
		}
		response.setContentType("application/json");  // 응답 타입을 JSON으로 설정
	    PrintWriter writer = response.getWriter();
	    writer.print("{\"exists\": " + yn + "}");  // "exists"라는 속성으로 JSON 응답
	    writer.flush();
	}catch(SQLException se){
		se.printStackTrace();
	}finally{
		dbCon.dbClose(rs, pstmt, con);
	}
	
	
    %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@page import="java.sql.*,kr.co.truetrue.dao.userVO,kr.co.truetrue.dao.userDAO" %>

	<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("id");
	String name = request.getParameter("name");
    String pass = request.getParameter("pass");
    String chkpass = request.getParameter("chk_pass");
    String birth = request.getParameter("birthday");
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String email = request.getParameter("email");
    String email2 = request.getParameter("email2");
    String zip_code = request.getParameter("zipcode");  
    String address = request.getParameter("addr1");  
    String address_detail = request.getParameter("addr2"); 
// 	SimpleDateFormat sdf=new SimpleDateFormat("yy/mm/dd");
    String phone=phone1+phone2+phone3;
	
	out.print(user_id);
	out.print(name);
	out.print(pass);
	out.print(birth);
	out.print(phone);
	out.print(email);
	out.print(zip_code);
	out.print(address);
	out.print(address_detail);
	
    userVO uVO=new userVO();
    uVO.setUser_id(user_id);
    uVO.setName(name);
    uVO.setPass(pass);
    uVO.setBirth(birth); // yyyy-dd-mm 형식
    uVO.setPhone(phone);
	uVO.setEmail(email+"@"+email2);
	uVO.setZip_code(zip_code);
	uVO.setAddress(address);
	uVO.setAddress_detail(address_detail);
	
	userDAO uDAO=new userDAO();
	
	try{
		uDAO.joinInfo(uVO);
		uDAO.cartId(uVO);
	}catch(SQLException se){
		se.printStackTrace();
	}
	
	
	%>
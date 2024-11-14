<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
    <%@page import="java.sql.*,kr.co.truetrue.dao.userVO,kr.co.truetrue.dao.userDAO" %>
    
    <%
    String currentName=(String)session.getAttribute("currentName");
    String currentBirth=(String)session.getAttribute("currentBirth");
    String currentPhone=(String)session.getAttribute("currentPhone");
    String currentEmail=(String)session.getAttribute("currentEmail");
    String currentZip_code=(String)session.getAttribute("currentZip_code");
    String currentAddress=(String)session.getAttribute("currentAddress");
    String currentAddress_detail=(String)session.getAttribute("currentAddress_detail");
    
	request.setCharacterEncoding("UTF-8");
	String newName = request.getParameter("name");
    String newUser_id = request.getParameter("id");
    String newBirth = request.getParameter("birth");
    String newPhone1 = request.getParameter("phone1");
    String newPhone2 = request.getParameter("phone2");
    String newPhone3 = request.getParameter("phone3");
    String newEmail1 = request.getParameter("email1");
    String newEmail2 = request.getParameter("email2");
    String newZip_code = request.getParameter("zipcode");  
    String newAddress = request.getParameter("addr1");  
    String newAddress_detail = request.getParameter("addr2");
    
    String newPhone=newPhone1+newPhone2+newPhone3;
    String newEmail=newEmail1+"@"+newEmail2;
    
    if(newName == null || newName.isEmpty()){
    	newName=currentName;
    }
    if(newBirth == null || newBirth.isEmpty()){
    	newBirth=currentBirth;
    }
    if(newPhone == null || newPhone.isEmpty()){
    	newPhone=currentPhone;
    }
    if(newEmail == null || newEmail.isEmpty()){
    	newEmail=currentEmail;
    }
    if(newZip_code == null || newZip_code.isEmpty()){
    	newZip_code=currentZip_code;
    }
    if(newAddress == null || newAddress.isEmpty()){
    	newAddress=currentAddress;
    }
    if(newAddress_detail == null || newAddress_detail.isEmpty()){
    	newAddress_detail=currentAddress_detail;
    }
    

    userVO uVO=new userVO();
	userDAO uDAO=new userDAO();
	
	try{
		uDAO.updateUser(uVO);
	}catch(SQLException se){
		se.printStackTrace();
	}
	
	%>

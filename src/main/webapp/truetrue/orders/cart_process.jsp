<%@page import="kr.co.truetrue.user.cart.CartDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.dao.DbConnection"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.truetrue.user.cart.CartVO" %>
<!-- 세션에 user_id가 있는지 확인하고 없다면 login페이지로 이동 -->
<%
String user_id = (String)session.getAttribute("user_id");
if(user_id == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<CartVO> cartItems = null;
try {
    CartDAO cDAO = CartDAO.getInstance();
    cartItems = cDAO.selectCartItems(user_id);
} catch(SQLException se) {
    se.printStackTrace();
}

request.setAttribute("cartItems", cartItems);
%>
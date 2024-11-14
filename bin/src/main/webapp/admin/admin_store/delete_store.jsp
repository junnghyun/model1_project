<%@page import="kr.co.truetrue.user.store.StoreDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String storeIdParam = request.getParameter("store_id");
    int storeId = 0;

    if (storeIdParam != null) {
        try {
            storeId = Integer.parseInt(storeIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    StoreDAO storeDAO = StoreDAO.getInstance();
    try {
        storeDAO.deleteStore(storeId); // 매장 삭제
        session.setAttribute("message", "매장이 성공적으로 삭제되었습니다."); // 성공 메시지
    } catch (SQLException e) {
        e.printStackTrace();
        session.setAttribute("message", "매장 삭제에 실패했습니다."); // 실패 메시지
    }

    // 삭제 후 매장 관리 페이지로 리다이렉트
    response.sendRedirect("admin_store.jsp");
%>

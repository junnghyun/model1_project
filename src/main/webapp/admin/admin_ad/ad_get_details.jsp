<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.truetrue.ad.AdDAO"%>
<%@page import="kr.co.truetrue.ad.AdVO"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%
    int adId = Integer.parseInt(request.getParameter("ad_id"));
    AdDAO adDAO = AdDAO.getInstance();
    AdVO adVO = null;

    try {
        adVO = adDAO.selectOneAd(adId);
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (adVO != null) {
        String jsonResponse = String.format(
            "{\"ad_Id\": %d, \"advertiser\": \"%s\", \"ad_Start_Date\": \"%s\", \"ad_End_Date\": \"%s\", \"ad_Phone\": \"%s\", \"ad_Price\": %d, \"ad_Detail\": \"%s\"}",
            adVO.getAd_Id(),
            adVO.getAdvertiser(),
            adVO.getAd_Start_Date(),
            adVO.getAd_End_Date(),
            adVO.getAd_Phone(),
            adVO.getAd_Price(),
            adVO.getAd_Detail()
        );
        out.print(jsonResponse);
    } else {
        out.print("{\"error\": \"광고 정보를 찾을 수 없습니다.\"}");
    }
%>

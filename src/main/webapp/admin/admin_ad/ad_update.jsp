<%@ page import="kr.co.truetrue.ad.AdDAO, kr.co.truetrue.ad.AdVO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String advertiser = request.getParameter("advertiser");
    String ad_Id = request.getParameter("ad_Id");
    String jsonResponse;

    AdDAO adDAO = AdDAO.getInstance();
    AdVO adVO = new AdVO();
    try {
        adVO.setAd_Id(Integer.parseInt(ad_Id));
        adVO.setAd_Start_Date(request.getParameter("ad_Start_Date"));
        adVO.setAdvertiser(advertiser);
        adVO.setAd_End_Date(request.getParameter("ad_End_Date"));
        adVO.setAd_Phone(request.getParameter("ad_Phone"));
        adVO.setAd_Price(Integer.parseInt(request.getParameter("ad_Price")));
        adVO.setAd_Detail(request.getParameter("ad_Detail"));
        adVO.setAd_Img(request.getParameter("ad_Img"));

        int result = adDAO.updateAd(adVO);
        boolean isUpdateSuccess = result > 0;

        if (isUpdateSuccess) {
            jsonResponse = "{\"status\": \"성공\", \"message\": \"업데이트에 성공하셨습니다.\"}";
        } else {
            jsonResponse = "{\"status\": \"실패\", \"message\": \"광고 업데이트 실패\"}";
        }
    } catch (Exception e) {
        e.printStackTrace();
        jsonResponse = "{\"status\": \"오류\", \"message\": \"데이터베이스 오류 발생\"}";
    }

    response.setContentType("application/json");
    response.getWriter().write(jsonResponse);
%>

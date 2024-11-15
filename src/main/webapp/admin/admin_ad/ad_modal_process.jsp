<%@page import="kr.co.truetrue.ad.AdDAO"%>
<%@page import="kr.co.truetrue.ad.AdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="" %>

<%
    String adIdParam = request.getParameter("ad_Id");
    int adId = 0;
    if (adIdParam != null && !adIdParam.isEmpty()) {
        try {
            adId = Integer.parseInt(adIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // 광고주 이름, 광고 비용 및 기타 필드에 대한 기본값 설정
    String advertiser = request.getParameter("advertiser") != null ? request.getParameter("advertiser") : "기본 광고주";

    // 광고 비용 파라미터에 대해 기본값 설정
    String adPriceParam = request.getParameter("ad_Price");
    int adPrice = 500000;  // 기본값 설정
    if (adPriceParam != null && !adPriceParam.isEmpty()) {
        try {
            adPrice = Integer.parseInt(adPriceParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // 광고 시작일과 종료일에 대한 기본값 설정
    String adStartDate = request.getParameter("ad_Start_Date") != null ? request.getParameter("ad_Start_Date") : "2024-01-01";
    String adEndDate = request.getParameter("ad_End_Date") != null ? request.getParameter("ad_End_Date") : "2024-03-31";
    String adPhone = request.getParameter("ad_Phone") != null ? request.getParameter("ad_Phone") : "01000000000";
    String adDetail = request.getParameter("ad_Detail") != null ? request.getParameter("ad_Detail") : "기본 광고 내용";
    String adImg = request.getParameter("ad_Img") != null ? request.getParameter("ad_Img") : "default.jpg";

    // AdVO 객체 생성 및 값 설정
    AdVO adVO = new AdVO();
    adVO.setAd_Id(adId);
    adVO.setAdvertiser(advertiser);
    adVO.setAd_Price(adPrice);
    adVO.setAd_Start_Date(adStartDate);
    adVO.setAd_End_Date(adEndDate);
    adVO.setAd_Phone(adPhone);
    adVO.setAd_Detail(adDetail);
    adVO.setAd_Img(adImg);

    // 광고 삽입
    AdDAO adDAO = AdDAO.getInstance();
    int result = adDAO.insertAd(adVO);

    String message = result > 0 ? "광고가 성공적으로 추가되었습니다." : "광고 추가 중 오류가 발생했습니다.";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>광고 추가 결과</title>
    <script>
        window.onload = function() {
            alert("<%= message %>");
            window.location.href = "admin_ad.jsp";
        }
    </script>
</head>
<body>
</body>
</html>

<%@page import="kr.co.truetrue.user.store.StoreUtil"%>
<%@page import="kr.co.truetrue.user.store.StoreVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.store.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="매장 안내 "%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매장안내</title>
    <link rel="stylesheet" type="text/css" href="store.css?after">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0f4b38fb42b57cde2b0919f29b1e7215"></script>
    <script src="js/storeMap.js"></script>
    <script src="js/store.js"></script>
</head>
<body>
<jsp:include page="../common/jsp/header.jsp"/>
    <div class="container">
        <div class="header">
            <h1>매장안내</h1>
            <jsp:useBean id="sVO" class="kr.co.truetrue.user.store.StoreSearchVO" scope="page"/>
            <jsp:setProperty property="*" name="sVO"/>
            <%
            // 총 매장의 수 구하기
            int yStoreCount = 0;
            
            StoreDAO sDAO = StoreDAO.getInstance();
            try {
                yStoreCount = sDAO.selectTotalCountY(sVO);
            } catch (SQLException se) {
                se.printStackTrace();
            }
            
            // 한 화면에 보여줄 레코드의 수 
            int pageScale = 15;
            
            // 총 페이지 수
            int totalPage = (int) Math.ceil((double) yStoreCount / pageScale);
            
            // 검색의 시작 번호 구하기
            String paramPage = request.getParameter("currentPage");
            
            int currentPage = 1;
            if (paramPage != null) {
                try {
                    currentPage = Integer.parseInt(paramPage);
                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                }
            }
            
            // 시작 번호
            int startNum = currentPage * pageScale - pageScale + 1;
            
            // 끝 번호
            int endNum = startNum + pageScale - 1;
            
            sVO.setCurrentStorePage(currentPage);
            sVO.setStartNum(startNum);
            sVO.setEndNum(endNum);
            sVO.setTotalPage(totalPage);
            sVO.setTotalCount(yStoreCount);
            
            List<StoreVO> storeList = null;
            try {
                storeList = sDAO.selectStoreY(sVO); // 새로운 페이지의 데이터 가져오기
            } catch (SQLException se) {
                se.printStackTrace();
            }
            
            pageContext.setAttribute("yStoreCount", yStoreCount);
            pageContext.setAttribute("pageScale", pageScale);
            pageContext.setAttribute("totalPage", totalPage);
            pageContext.setAttribute("currentPage", currentPage);
            pageContext.setAttribute("storeList", storeList);
            
            pageContext.setAttribute("startNum", startNum);
            pageContext.setAttribute("endNum", endNum);
            %>
            <div class="breadcrumb">
                Home <span class="separator">›</span> <span style="color: #666;">매장안내</span>
            </div>
        </div>

        <div class="search-section">
            <form class="search-form" method="get" action="store_list.jsp">
                <div>
                    <label>지역</label>
                    <select name="province" id="province" onchange="loadCities()">
                        <option value="">광역시/도</option>
                        <option value="서울">서울</option>
                        <option value="부산">부산</option>
                        <option value="대구">대구</option>
                        <option value="인천">인천</option>
                        <option value="광주">광주</option>
                        <option value="대전">대전</option>
                        <option value="울산">울산</option>
                        <option value="경기">경기</option>
                        <option value="강원">강원</option>
                        <option value="충북">충북</option>
                        <option value="충남">충남</option>
                        <option value="전북">전북</option>
                        <option value="전남">전남</option>
                        <option value="경북">경북</option>
                        <option value="경남">경남</option>
                        <option value="제주">제주</option>
                    </select>
                    <select name="city" id="city">
                        <option value="">시/군/구</option>
                    </select>
                </div>
                <input type="text" name="keyword" placeholder="매장명">
                <button type="submit" class="search-btn">검색</button>
                <button class="reset-btn" onclick="resetFilters()">초기화</button>
            </form>
            <p class="notice">* NEW 뚜르뚜르 매장안내: 새로운 뚜르뚜르와 즐거운 가치를 공유 하고싶은 고객님들을 환영합니다.</p>
        </div>

        <div class="content">
            <div class="store-list">
                <div class="store-count">
                    매장 검색 결과: <span><strong id="store-y-count"><c:out value="${yStoreCount}"/></strong></span>
                </div>
                <div class="store-items">
                    <c:forEach var="store" items="${storeList}">
                        <div class="store-item" data-lat="${store.lat}" data-lng="${store.lng}">
                            <h3><c:out value="${store.store_name}"/></h3>
                            <p><c:out value="${store.store_address}"/></p>
                            <p><c:out value="${store.store_phone}"/></p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty storeList}">
                        <div class="store-item">
                            <p class="no-data">등록된 매장이 없습니다.</p>
                        </div>
                    </c:if>
                </div>
                <div class="pagination" id="pagination">
                    <%
                        sVO.setUrl("store_list.jsp"); // URL 설정
                    %>
                    <c:if test="${sVO.totalCount ne 0}">
                        <%= new StoreUtil().pagination(sVO) %>
                    </c:if>
                </div>
            </div>

            <div class="map-section">
                <div class="map-info">
                    <h3>매장명: <span id="map-store-name"></span></h3>
                    <p>주소: <span id="map-store-address"></span></p>
                    <p>전화번호: <span id="map-store-phone"></span></p>
                    <!-- <input type="button" id="add-store-btn" value="+" class="square-btn" onclick="openMap()" /> -->
                </div>
                <div id="map"></div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/jsp/footer.jsp"/>
    
    <div id="modal" class="modal">
        <div class="modal-content">
            <!-- X 버튼 -->
            <span class="close">&times;</span> 
            <h3>매장명: <span id="modal-store-name"></span></h3>
            <p>주소: <span id="modal-store-address"></span></p>
            <p>전화번호: <span id="modal-store-phone"></span></p>
            <div id="modal-map" style="width: 100%; height: 300px; background-color: #ddd;">지도 영역</div>
        </div>
    </div>
</body>
</html>
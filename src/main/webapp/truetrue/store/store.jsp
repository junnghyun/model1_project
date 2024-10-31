<%@page import="kr.co.truetrue.user.store.StoreVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.user.store.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="매장 안내 "%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="store.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>매장안내</h1>
            <jsp:useBean id="sVO" class="kr.co.truetrue.user.store.StoreSearchVO" scope="page"/>
			<jsp:setProperty property="*" name="sVO"/>
			<%
			//총 매장의 수 구하기
			int totalCount=0;
			
			StoreDAO sDAO=StoreDAO.getInstance();
			try{
				totalCount=sDAO.selectTotalCount(sVO);
			} catch(SQLException se) {
				se.printStackTrace();
			}
			
			// 한 화면에 보여줄 레코드의 수 
			int pageScale=15;
			
			//총 페이지 수
			int totalPage=(int)Math.ceil((double)totalCount/pageScale);
			
			// 검색의 시작 번호 구하기
			String paramPage=request.getParameter("currentPage");
			
			int currentPage=1;
			if(paramPage != null) {
				try{
					currentPage=Integer.parseInt(paramPage);
				} catch (NumberFormatException nfe){
					nfe.printStackTrace();
				}
			}
			
			//시작 번호
			int startNum = currentPage * pageScale - pageScale + 1;
			
			// 끝 번호
			int endNum = startNum + pageScale - 1;
			
			sVO.setCurrentStorePage(currentPage);
			sVO.setStartNum(startNum);
			sVO.setEndNum(endNum);
			sVO.setTotalPage(totalPage);
			sVO.setTotalCount(totalCount);
			
			List<StoreVO> storeList = null;
			try {
			    storeList = sDAO.selectStore(sVO); // 새로운 페이지의 데이터 가져오기
			} catch (SQLException se) {
			    se.printStackTrace();
			}
			
			pageContext.setAttribute("totalCount", totalCount);
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
            <form class="search-form">
                <div>
                    <label>지역</label>
                    <select>
                        <option>광역시/도</option>
                    </select>
                    <select>
                        <option>시/군/구</option>
                    </select>
                </div>
                <input type="text" placeholder="매장명">
                <button type="submit" class="search-btn">검색</button>
            </form>
            <p class="notice">* NEW 뚜르뚜르 매장안내: 새로운 뚜르뚜르와 즐거운 가치를 공유 하고싶은 고객님들을 환영합니다.</p>
        </div>

        <div class="content">
            <div class="store-list">
                <div class="store-count">
                    매장 검색 결과 <span><strong id="store-count"><c:out value="${totalCount}"/></strong></span>
                </div>
                <div class="store-items">
                    <c:forEach var="store" items="${storeList}">
                    <div class="store-item">
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
                <div class="pagination">
                    <button>1</button>
                    <button>2</button>
                </div>
            </div>

            <div class="map-section">
                <div class="map-info">
                    <h3>매장명: <c:out value="${store.store_name}"/></h3>
                    <p>주소: <c:out value="${store.store_address}"/></p>
                    <p>전화번호: <c:out value="${store.store_phone}"/></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
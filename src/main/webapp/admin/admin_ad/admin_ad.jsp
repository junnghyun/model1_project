<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.ad.AdUtil" %>
<%@page import="kr.co.truetrue.ad.SearchAdVO"%>
<%@page import="kr.co.truetrue.ad.AdVO"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Map" %>
<%@page import="kr.co.truetrue.ad.AdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%-- admin_ad.jsp 상단에 메시지 확인 로직 추가 --%>
<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
        <script>alert('<%= message %>');</script>
<%
        session.removeAttribute("message"); // 메시지 출력 후 세션에서 제거
    }
%>
   
   
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<jsp:useBean id="shaVO" class="kr.co.truetrue.ad.SearchAdVO" scope="page"/>
	<jsp:setProperty property="*" name="shaVO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_광고관리</title>
   <link rel="stylesheet" type="text/css" href="../common/css/admin.css?after">
    <link rel="stylesheet" type="text/css" href="css/admin_ad.css?after">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 추가 -->
    <script src="js/admin_ad.js" defer></script>

<script type ="text/javascript">

$(document).ready(function () {
    // 검색 입력란에서 Enter 키를 눌렀을 때 검색
    $("#keyword").keyup(function (evt) {
        if (evt.which == 13) {
            chkNull();
            evt.preventDefault(); // 폼 제출 방지
        }
    });

    // 검색 버튼 클릭 시 검색
    $("#searchBtn").click(function (evt) {
        chkNull();
        evt.preventDefault(); // 폼 제출 방지
    });
});


//검색으로 선택한 컬럼명과 키워드를 설정(jsp코드로 작성가능)
if(${not empty param.keyword }) {
	$("#field").val(${param.field});
	$("#keyword").val("${param.keyword}");
	
	
}



function chkNull() {
    var keyword = $("#keyword").val();
    if (keyword.length < 1) { // 1자 이상 입력해야 검색 가능
        alert("검색 키워드는 한 글자 이상 입력하셔야 합니다.");
        return false; // 폼 제출 방지
    }
    $("#searchForm").submit(); // 조건 충족 시 폼 제출
}


$(document).ready(function () {
    // 광고자 이름으로 검색할 때
    $('#advertiser').on('keyup', function (evt) {
        if (evt.key === 'Enter') {
            $('#searchForm').submit();
        }
    });

    $('#searchBtn').click(function () {
        $('#searchForm').submit();
    });
});


</script>
</head>
<body>

   <jsp:include page="../common/admin.jsp" />
   <div class="common_admin">
      <h1>광고관리</h1>
      <div class="ad-summary">
         <div class="ad-active">
            <span>활성 광고 : </span> 
            <span class="ad-count">
            <!-- 활성 광고 수: 등록한 광고 수 -->
 		<%
                    AdDAO adDAO = AdDAO.getInstance();
                    int activeAdCount = 0;
                    int totalRevenue = 0;
                    int totalClicks = 0;
                    try {
                        // 활성 광고 수
                        activeAdCount = adDAO.getActiveAdCount(shaVO);
                        pageContext.setAttribute("activeAdCount", activeAdCount);
                        
                        // 총 수익
                        List<AdVO> adList = adDAO.selectAllDAO(shaVO);
                        for (AdVO ad : adList) {
                            totalRevenue += ad.getAd_Price();
                        }
                        pageContext.setAttribute("totalRevenue", totalRevenue);

                        // 활성 광고 클릭 수
                        Map<String, Integer> adClickData = adDAO.activeAd_Click();
                        totalClicks = adClickData.get("totalClicks"); // 총 클릭 수
                        pageContext.setAttribute("totalClicks", totalClicks);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <c:out value="${activeAdCount}" />
            </span>
         </div>
         <div class="total-impressions">
            <!-- 총 수익: 시작과 끝값을 구해 광고로 인한 총 수익 확인 -->
            <span>총 수익 : </span> 
            <span class="total-amount">
                <c:out value="${totalRevenue}" />
            </span>
         </div>
            <!-- 활성광고 수 클릭 수: 광고를 클릭한 수 -->
         <div class="total-clicks">
            <span>활성 광고 클릭 수 : </span>
            <span class="total-clicks-count">
                <c:out value="${totalClicks}" />
            </span>
         </div>
      </div>
      <div class="order-management">
         <div class="ad-filter">
         <form id="searchForm" action="admin_ad.jsp" method="get">
            <input type="text" placeholder="광고주 이름으로 검색" class="search-bar" name="keyword" 
            					value="${param.keyword}" id="keyword"/>
			<button class="search-btn" id="searchBtn">검색</button>
			</form>
            <div class="add-ad-btn">
			<!--<button class="csv-download-btn" onclick="location.href='excel_download.jsp'">Excel로 다운로드</button>-->
               <button class="ad-btn" onclick="location.href='ad_modal.jsp'">광고 추가</button>
            </div>
         </div>

      <%-- 광고 관리 - 광고 검색 섹션 --%>

<%
   int totalCount = 0;  // 총 레코드 수
   int pageScale = 20;  // 한 화면에 표시할 광고 수 = 20개 지정
   int currentPage = 1; // 현재 페이지 초기화

   // currentPage 파라미터 가져오기
   String paramPage = request.getParameter("currentPage");
   if (paramPage != null) {
       try {
           currentPage = Integer.parseInt(paramPage);
       } catch (NumberFormatException nfe) {
           currentPage = 1;
       }
   }

   // 시작 번호와 끝 번호 계산
   int startNum = (currentPage - 1) * pageScale + 1;
   int endNum = startNum + pageScale - 1;

   // SearchAdVO 객체 설정
   shaVO.setStartNum(startNum);
   shaVO.setEndNum(endNum);

   // AdDAO와 광고 리스트 초기화
   AdDAO dDAO = AdDAO.getInstance();
   List<AdVO> listAd = null;

   try {
       listAd = dDAO.selectAllAd(shaVO);  // SearchAdVOD의 매개변수 shaVO를 전달하여 selectAllAd 호출
       totalCount = listAd.size();        // 전체 레코드 수 계산
   } catch (SQLException se) {
       se.printStackTrace();
   }

   // 총 페이지 수 계산
   int totalPage = (int) Math.ceil((double) totalCount / pageScale);

   // JSP에서 사용할 속성 설정
   pageContext.setAttribute("totalCount", totalCount);
   pageContext.setAttribute("pageScale", pageScale);
   pageContext.setAttribute("totalPage", totalPage);
   pageContext.setAttribute("currentPage", currentPage);
   pageContext.setAttribute("listAd", listAd);  // listAd 리스트 설정

   // shaVO의 값 확인을 위해 출력 out.print(shaVO); */
%>

<% /* 시작 번호, 끝 번호 클릭하여 활성화된 광고 조회 */
   try{
	   listAd = dDAO.selectAllAd(shaVO);
	   String tempDetail = ""; 
      //시작번호, 끝 번호를 사용한 게시글 조회
      for(AdVO tempVO : listAd){ //저장할 객체 tempVO
    	  tempDetail=tempVO.getAd_Detail();
          
      if(tempDetail != null && tempDetail.length() > 30){
             //광고제목의 길이를 체크하여 30자를 초과하는 경우, 제목을 29자로 자르고 말줄임표(...)를 추가
            tempVO.setAd_Detail(tempDetail.substring(0, 29)+"...");
         }else if(tempDetail == null) {
        	 
        	 tempVO.setAd_Detail(""); 
         }
      }//end for
      
   }catch(SQLException se){
      se.printStackTrace();
   }//end catch
   
   pageContext.setAttribute("totalCount", totalCount); 
   pageContext.setAttribute("pageScale", pageScale);
   pageContext.setAttribute("totalPage", totalPage);
   pageContext.setAttribute("currentPage", currentPage);
//   pageContext.setAttribute("startNum", startNum);
//   pageContext.setAttribute("endNum", endNum); 
   pageContext.setAttribute("listAd", listAd);
   
   %>
   

   <table class="ad-table">
    <thead>
        <tr>
            <th>광고번호</th>
            <th style="width: 150px;">광고 기간</th>
            <th style="width: 180px;">광고주 이름</th>
            <th>광고주 연락처</th>
            <th>광고비용</th>
            <th>클릭 수</th>
            <th style="width: 150px;">입력일</th>
            <th style="width: 100px;">광고상태</th>
            <th style="width: 150px;">
                 <div class="pagination">
             	 <%   shaVO.setUrl("admin_ad.jsp"); %>
				<c:if test = "${ totalCount ne 0 }">
				<%= new AdUtil().pagination(shaVO) %>
				</c:if>
             <!-- 	<button class="prev-page">◀</button>   
               <button class="next-page">▶</button> -->
            </div>
            </th>
        </tr>
    </thead>
    <tbody>
       <c:if test="${ empty listAd }"> 
       <%-- 시작 번호 끝 번호 조회 --%>
 		 <%--  <tr>
      <td style="text-align: center" colspan="9">
      <br>
     <!--  <a href="ad_modal.jsp">편집</a>  -->
      </td> --%>
   </tr>
   </c:if>
   <c:if test = "${not empty param.keyword }">
   <c:set var = "searchParam" value = "&field=${ param.field }&keyword=${param.keyword }"/>
   </c:if>
   <!-- 검색창: keyword에 검색한 기록이 그대로 남아있게 하기 -->
   
   
   <c:forEach var="AdVO" items="${ listAd }" varStatus="status">
   <!-- listAd를 순회하며 메인 게시글을 출력합니다. 
   광고번호, 광고기간, 광고주 이름, 광고주 연락처, 광고비용, 클릭수, 입력일, 광고상태를 테이블 행에 각각 표시
 -->  <tr>
        <td><c:out value="${AdVO.ad_Id}"/></td> <!-- 광고 번호 -->
        <td>
            <c:out value="${AdVO.ad_Start_Date}"/> ~ 
            <c:out value="${AdVO.ad_End_Date}"/>
        </td> <!-- 광고 기간 -->
        <td><c:out value="${AdVO.advertiser}"/></td> <!-- 광고주 이름 -->
        <td><c:out value="${AdVO.ad_Phone}"/></td> <!-- 광고주 연락처 -->
        <td><c:out value="${AdVO.ad_Price}"/></td> <!-- 광고 비용 -->
        <td><c:out value="${AdVO.clicks}"/></td> <!-- 클릭 수 -->
        <td><c:out value="${AdVO.input_Date}"/></td> <!-- 입력일 -->
        <td><c:out value="${status.index + 1}"/></td> <!-- 광고 상태 -->
        <td>
  				<%-- 관리자 페이지 로그인 여부에 따라 변수에 값 할당--%>
  				 <c:set var="loginFlag" value="javascript:loginMove()"/> 
   				 <%--loginFlag라는 변수를 설정하고 초기값으로 javascript:loginMove()를 할당 --%>
   				 <c:if test="${ not empty userData }">
   				 <%-- userData에 변수가 비어(로그인)있으면 아래 코드 실행 --%>
   				<c:set var="loginFlag" value="ad_modal.jsp"/>
   				<%-- 로그인 한 상태에서면 편집 기능 사용 가능 --%>
  				 </c:if>
   				<%-- <a href = "${ loginFlag }">편집</a>--%>	
      			<button class="edit-btn" onclick="location.href='ad_edit.jsp?ad_Id=${AdVO.ad_Id}'">편집</button>
      			<button class="delete-btn" onclick="deleteAd('${AdVO.ad_Id}')">종료</button>
   				 </td>
 				 </tr>
				</c:forEach>
  				 </tbody>
  				 </table>
   				</div>
   
   <%--검색창 및 검색 기록 유지 기능 
   SearchAdVO:현재페이지, 시작번호, 끝 번호, 검색컬럼, 검색값, 검색URL --%>
   
   <form>
  
   <div id="search" style="height: 60px;text-align: center">
   <!-- <form action="board_list.jsp" method="get" name="searchFrm" id="searchFrm"> -->
     <%--  <input type="text" name="keyword" value = "${param.keyword }" id = "keyword" style="width: 200px"/> --%>
      <!-- 이전 검색어를 그대로 유지하기 위해 keyword 값이 파라미터로 전달 -->
   <!--    <input type="button" value="검색" id="btn" class="btn btn-sm btn-primary"/> -->
      <input type="text" style="display: none"/>
   </form>
    </tbody>
	</table>
      </div>
  <script src="../common/js/admin.js"></script>
   <div id="editAdModal" style="display: none;">
      <jsp:include page="ad_edit.jsp" />
   </div>
   <div id="adModal" style="display: none;">
      <jsp:include page="ad_modal.jsp" />
   </div>
</body>
</html>
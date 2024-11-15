<%@page import="kr.co.truetrue.ad.AdVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.ad.AdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<jsp:useBean id = "dVO" class = "kr.co.truetrue.ad.AdVO" scope = "page"/>
<%-- 글 제목 내용 번호가 bVO객체에 입력 --%>
<jsp:setProperty name = "dVO" property="*" />
<%
    int result = 0;
    String adIdParam = request.getParameter("ad_Id");
    if (adIdParam != null) {
        try {
            AdDAO dDAO = AdDAO.getInstance();
            AdVO adVO = new AdVO();
            adVO.setAd_Id(Integer.parseInt(adIdParam));

            // 삭제 메서드 호출 및 결과 확인
            result = dDAO.deleteAd(adVO);
            if (result > 0) {
                out.print("삭제 성공");
            } else {
                out.print("삭제 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("SQL 오류: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.221/jsp_prj/common/images/favicon.png">
<link rel = "stylesheet" type = "text/css" href = "http://192.168.10.221/jsp_prj/common/css/main_20240911.css"/>
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--JQuery 시작-->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css"> 

</style>
<script type="text/javascript">


var msg = "문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
var cnt = "${rowCnt}";


var flag = false; 
if(cnt == -1 || cnt == 0) {
	msg = "번호는 외부에서 임의로 편집할 수 없습니다."; 
	
}//end if

if(cnt == 1) {
	flag = true;
	msg = "${param.ad_id}번 글을 삭제하였습니다."; 
	
}//end if

alert(msg);

if(flag) {
	location.href = "admin_ad.jsp?currentPage=${param.currentPage}"; 
	
	
}else{
	history.back(); 
	
	
}

$(function() {
	
}); //ready

</script>
</head>
<body>
<div id = "wrap"> 
	
	
	
	
	
</div>
</body>
</html>
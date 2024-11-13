<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="아이디 찾기 결과 페이지" %>
<%@ page import="kr.co.truetrue.member.MemberDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.cont_header {
    padding-top: 75px;
    text-align: center;
    font-size: 14px;
    font-family: Arial, nbgr, '나눔바른고딕', '돋음';
    line-height: 24px;
}
.id_find_wrap {
    margin: 0 auto;
    width: 900px;
    padding: 50px;
    border-top: 1px solid #222;
    background-color: #f8f8f8;
}
.find_handy {
    width: 500px;
    height: 200px;
    margin: 0 auto;
    text-align: center;
}
.em {
    color: #ee6900;
    font-weight: normal;
}
.btn.btn_em {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    padding: 0 15px;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 100px;
    width: 375px;
}
.cont_area {
    padding-top: 60px;
}
</style>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String birth = request.getParameter("birth");
    String phone = request.getParameter("phone");

    String id = null; // 조회된 아이디를 저장할 변수
    String resultMessage = "";

    if (name != null && birth != null && phone != null) {
        try {
            // MemberDAO의 findId 메서드를 사용해 아이디 검색
            MemberDAO memberDAO = MemberDAO.getInstance();
            id = memberDAO.findId(name, birth, phone); // DB에서 아이디 조회
			
            if (id != null) {
                // 이름 마스킹 처리
                if (name.length() <= 2) {
                    name = name.replaceAll(".", "*");
                } else {
                    StringBuilder maskedName = new StringBuilder();
                    maskedName.append(name.charAt(0)); // 첫 글자
                    for (int i = 1; i < name.length() - 1; i++) {
                        maskedName.append("*"); // 중간 글자 마스킹
                    }
                    maskedName.append(name.charAt(name.length() - 1)); // 마지막 글자
                    name = maskedName.toString();
                }
                
                // 아이디 마스킹 처리
                if (id.length() > 2) {
                    StringBuilder maskedId = new StringBuilder(id);
                    maskedId.setCharAt(id.length() - 2, '*');
                    maskedId.setCharAt(id.length() - 1, '*');
                    id = maskedId.toString();
                } else {
                    id = id.replaceAll(".", "*"); // 아이디가 2자리 이하일 때 전체 마스킹
                }
            } else {
            	resultMessage = "입력하신 정보와 일치하는 아이디를 찾을 수 없습니다.";
            }
        } catch (SQLException e) {
            resultMessage = "데이터베이스 오류가 발생했습니다. 다시 시도해주세요.";
            e.printStackTrace();
        }
    } else {
        resultMessage = "모든 정보를 입력해주세요.";
    }
    if (!resultMessage.isEmpty()) {
%>
    <script>
        alert("<%= resultMessage %>");
        window.location.href = "find_id.jsp";
    </script>
<%
    }
%>


<div class="cont_header">
    <h1>아이디 확인</h1>
    <p><%= resultMessage.isEmpty() ? "입력하신 정보와 일치하는 아이디는 다음과 같습니다." : resultMessage %></p>
</div>
<div class="cont_area">
<div class="id_find_wrap">
<div class="find_handy">
    <form action="login.jsp" method="GET">
        <p class="desc"><%=name != null ? name + "님의 아이디는 " : "" %><em class="em"><%= id != null ? id : "" %></em>입니다.</p>
        <button type="button" class="btn btn_em" id="btnSearch">로그인</button>
    </form>
</div>
</div>
</div>

<script type="text/javascript">
$('#btnSearch').on('click', function(){ 
    $('form').submit();
});
</script>
</body>
</html>

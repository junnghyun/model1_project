<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 데이터 가져오기</title>
<link rel="stylesheet" type="text/css" href="css/admin_store_crawler.css?after">
</head>
<body>
    <div class="container">
        <h1>매장 정보 조회</h1>
        <div class="controls">
            <select id="regionSelect">
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
            <button id="fetchButton">매장 정보 가져오기</button>
            <div class="loader" id="loader"></div>
        </div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll"/></th>
                        <th>매장명</th>
                        <th>주소</th>
                        <th>연락처</th>
                        <th>위도</th>
                        <th>경도</th>
                    </tr>
                </thead>
                <tbody id="storesTableBody">
                    <tr>
                        <td colspan="6" class="empty-message">
                            지역을 선택하고 매장 정보를 조회해주세요.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
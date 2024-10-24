<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="매장 안내 "%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #fdf6e3;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            margin-bottom: 30px;
        }

        .header h1 {
            color: #1b4d3e;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .breadcrumb {
            font-size: 14px;
        }

        .breadcrumb .separator {
            margin: 0 8px;
            color: #666;
        }

        .search-section {
            background-color: #D5D9C7; /* 이미지의 연한 민트 베이지색으로 변경 */
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 10px;
        }

        .search-form label {
            font-weight: 500;
        }

        .search-form select,
        .search-form input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
        }

        .search-form input {
            flex-grow: 1;
        }

        .search-btn {
            background-color: #1b4d3e;
            color: white;
            border: none;
            padding: 8px 24px;
            border-radius: 4px;
            cursor: pointer;
        }

        .notice {
            font-size: 13px;
            color: #666;
        }

        .content {
            display: flex;
            gap: 20px;
        }

        .store-list {
            width: 50%;
        }

        .store-count {
            margin-bottom: 15px;
        }

        .store-count span {
            color: #1b4d3e;
        }

        .store-items {
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
        }

        .store-item {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .store-item:last-child {
            border-bottom: none;
        }

        .store-item h3 {
            margin-bottom: 8px;
        }

        .store-item p {
            color: #666;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
        }

        .pagination button {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .map-section {
            width: 50%;
            background-color: #f5f5f5;
            border-radius: 4px;
            height: 600px;
            position: relative;
        }

        .map-info {
            background-color: black;
            color: white;
            padding: 15px;
            width: 100%;
        }

        .map-info h3 {
            margin-bottom: 8px;
        }

        .map-info p {
            font-size: 14px;
            margin-bottom: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>매장안내</h1>
            <div class="breadcrumb">
                Home <span class="separator">›</span> <span style="color: #666;">매장안내</span>
            </div>
        </div>

        <div class="search-section">
            <form class="search-form">
                <div>
                    <label>구분</label>
                    <select>
                        <option>전체</option>
                    </select>
                </div>
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
            <p class="notice">* NEW 뚜레쥬르 매장안내: 새로운 뚜레쥬르와 즐거운 가치를 공유 하고싶은 고객님들을 환영합니다.</p>
        </div>

        <div class="content">
            <div class="store-list">
                <div class="store-count">
                    매장 검색 결과 <span>15</span>
                </div>
                <div class="store-items">
                    <div class="store-item">
                        <h3>뚜레쥬르 강남점</h3>
                        <p>서울특별시 강남구 테헤란로 180 (역삼동,강남무역센터빌딩1층)</p>
                        <p>02-6447-0404</p>
                    </div>
                    <div class="store-item">
                        <h3>뚜레쥬르 명동점</h3>
                        <p>서울특별시 강남구 테헤란로 845-1 (역삼동,삼창빌딩1층)</p>
                        <p>02-677-5555</p>
                    </div>
                    <div class="store-item">
                        <h3>뚜레쥬르 안양점</h3>
                        <p>경기도 안양시 동안구 관평로 180 (인덕원동) 1층</p>
                        <p>031-424-6661</p>
                    </div>
                </div>
                <div class="pagination">
                    <button>1</button>
                    <button>2</button>
                </div>
            </div>

            <div class="map-section">
                <div class="map-info">
                    <h3>매장명: 뚜레쥬르 강남점</h3>
                    <p>주소: 서울특별시 강남구 테헤란로 180 (역삼동,강남무역센터빌딩1층)</p>
                    <p>전화번호: 02-6447-0404</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>